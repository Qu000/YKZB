//
//  JHPlayerViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/30.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//
/*根据GitHub上的哔哩哔哩的demo写！！*/
#import "JHPlayerViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "JHLiveChatViewController.h"

#import "AppDelegate.h"
@interface JHPlayerViewController ()

@property (nonatomic, retain) id<IJKMediaPlayback> player;


@property (nonatomic, strong) UIImageView * blurImageView;

@property (nonatomic, strong) UIButton * closeBtn;

@property (nonatomic, strong) JHLiveChatViewController * liveChatVc;
@end

@implementation JHPlayerViewController

-(JHLiveChatViewController *)liveChatVc{
    if (!_liveChatVc) {
        _liveChatVc = [[JHLiveChatViewController alloc]init];
    }
    return _liveChatVc;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"mg_room_btn_guan_h"] forState:UIControlStateNormal];
        [_closeBtn sizeToFit];
        _closeBtn.frame = CGRectMake(SCREEN_WIDTH - _closeBtn.width - 10, SCREEN_HEIGHT - _closeBtn.height - 10, _closeBtn.width, _closeBtn.height);
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}


-(void)closeAction:(UIButton *)button{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    //注册直播需要用的通知
    [self installMovieNotificationObservers];
    
    //准备播放
    [self.player prepareToPlay];
    
    UIWindow * window = [(AppDelegate *)[UIApplication sharedApplication].delegate window];
    [window addSubview:self.closeBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    //返回时，bar才会依旧存在
    self.navigationController.navigationBarHidden = NO;
    
    //关闭直播
    [self.player shutdown];
    
    //移除通知
    [self removeMovieNotificationObservers];
    
    [self.closeBtn removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupPlayer];
    
    //毛玻璃(当直播能正常播放时就要将毛玻璃效果移除moviePlayBackStateDidChange)
    [self setupUI];
    
    [self addChildVC];

}
-(void)addChildVC{
    
    [self addChildViewController:self.liveChatVc];
    
    [self.view addSubview:self.liveChatVc.view];
    
    [self.liveChatVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //传递数据
//    if (self.judgeIdx == 0) {
//       self.liveChatVc.live = self.live;
//    }
//    else{
//    self.liveChatVc
//    }
    self.liveChatVc.live = self.live;
}

-(void)setupUI{
    
    
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    if (self.judgeIdx == 0) {
        [imageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,self.live.creator.portrait] placeholder:@"default_room"];
    }
    else{
    [imageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,self.flow.info.creator.portrait] placeholder:@"default_room"];
    }
    
    [self.view addSubview:imageView];
    self.blurImageView = imageView;
    
    //创建毛玻璃效果
    UIBlurEffect * blurEF = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    //创建毛玻璃视图
    UIVisualEffectView * visualEV = [[UIVisualEffectView alloc]initWithEffect:blurEF];
    visualEV.frame = imageView.bounds;
    
    //毛玻璃视图加入图片的View上
    [imageView addSubview:visualEV];
    
}

-(void)setupPlayer{
    IJKFFOptions * options = [IJKFFOptions optionsByDefault];
    
    if (self.judgeIdx == 0) {
        IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.live.streamAddr withOptions:options];
        self.player = player;
    }
    else{
        IJKFFMoviePlayerController * player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:self.flow.info.streamAddr withOptions:options];
        self.player = player;
    }
    
    self.player.view.frame = self.view.bounds;
    self.player.shouldAutoplay = YES;
    [self.view addSubview:self.player.view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Install Notifications Selector
- (void)loadStateDidChange:(NSNotification*)notification
{
    //    MPMovieLoadStateUnknown        = 0,未知
    //    MPMovieLoadStatePlayable       = 1 << 0,缓冲结束，可以播放
    //    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //缓冲结束，自动播放
    
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    //暂停
    
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStatePlaythroughOK: %d\n", (int)loadState);
    } else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    //    MPMovieFinishReasonPlaybackEnded,直播结束
    //    MPMovieFinishReasonPlaybackError,直播错误
    //    MPMovieFinishReasonUserExited  用户退出
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    
    switch (reason)
    {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
    NSLog(@"mediaIsPreparedToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    
    //    MPMoviePlaybackStateStopped,
    //    MPMoviePlaybackStatePlaying,
    //    MPMoviePlaybackStatePaused,
    //    MPMoviePlaybackStateInterrupted,
    //    MPMoviePlaybackStateSeekingForward,
    //    MPMoviePlaybackStateSeekingBackward
    
    switch (_player.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePlaying: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStatePaused: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
    
    self.blurImageView.hidden = YES;
    [self.blurImageView removeFromSuperview];
}

#pragma mark Install Movie Notifications

/* Register observers for the various movie object notifications. */
-(void)installMovieNotificationObservers
{
    //监听网络环境，监听缓冲 方法
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    
    //监听直播完成 回调
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    //监听用户主动操作
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

#pragma mark Remove Movie Notification Handlers

/* Remove the movie notification observers from the movie object. */
-(void)removeMovieNotificationObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackDidFinishNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification object:_player];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:_player];
}



@end
