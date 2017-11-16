//
//  JHLiveChatViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/31.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHLiveChatViewController.h"

@interface JHLiveChatViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *onlineLab;
@property (nonatomic, strong) dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UIImageView *shareBtn;


@end

@implementation JHLiveChatViewController

//-(void)setLive:(JHLive *)live{
//    _live = live;
////    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait]] forState:UIControlStateNormal];
//
//}
//-(void)setFlow:(JHFlow *)flow{
//    _flow = flow;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JHRGBA(255, 255, 255, 0);
    
    [self judgeIconFrom];
    
    [self onlineChange];
    
    [self initTimer];
    
}

-(void)judgeIconFrom{
    self.iconBtn.layer.cornerRadius = 15;
    self.iconBtn.layer.masksToBounds = YES;
    
    if (self.judgeIdx == 0) {
        [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,self.live.creator.portrait]] forState:UIControlStateNormal];
    }
    else{
        [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,self.flow.info.creator.portrait]] forState:UIControlStateNormal];
    }
}

-(void)onlineChange{
    [NSTimer scheduledTimerWithTimeInterval:2 block:^(NSTimer * _Nonnull timer) {
        self.onlineLab.text = [NSString stringWithFormat:@"%d",arc4random_uniform(10000)];
    } repeats:YES];
}

-(void)initTimer{

    //初始化心形动画
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        
        [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
    });
    dispatch_resume(self.timer);

}

- (void)showMoreLoveAnimateFromView:(UIView *)fromView addToView:(UIView *)addToView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 25)];
    CGRect loveFrame = [fromView convertRect:fromView.frame toView:addToView];
    CGPoint position = CGPointMake(fromView.layer.position.x, loveFrame.origin.y - 30);
    imageView.layer.position = position;
    NSArray *imgArr = @[@"heart_1",@"heart_2",@"heart_3",@"heart_4",@"heart_5",@"heart_1"];
    NSInteger img = arc4random()%6;
    imageView.image = [UIImage imageNamed:imgArr[img]];
    [addToView addSubview:imageView];
    
    imageView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        imageView.transform = CGAffineTransformIdentity;
    } completion:nil];
    
    CGFloat duration = 3 + arc4random()%5;
    CAKeyframeAnimation *positionAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimate.repeatCount = 1;
    positionAnimate.duration = duration;
    positionAnimate.fillMode = kCAFillModeForwards;
    positionAnimate.removedOnCompletion = NO;
    
    UIBezierPath *sPath = [UIBezierPath bezierPath];
    [sPath moveToPoint:position];
    CGFloat sign = arc4random()%2 == 1 ? 1 : -1;
    CGFloat controlPointValue = (arc4random()%50 + arc4random()%100) * sign;
    [sPath addCurveToPoint:CGPointMake(position.x, position.y - 300) controlPoint1:CGPointMake(position.x - controlPointValue, position.y - 150) controlPoint2:CGPointMake(position.x + controlPointValue, position.y - 150)];
    positionAnimate.path = sPath.CGPath;
    [imageView.layer addAnimation:positionAnimate forKey:@"heartAnimated"];
    
    
    [UIView animateWithDuration:duration animations:^{
        imageView.layer.opacity = 0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self showMoreLoveAnimateFromView:self.shareBtn addToView:self.view];
}


@end
