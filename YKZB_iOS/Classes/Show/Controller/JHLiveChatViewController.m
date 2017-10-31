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


@end

@implementation JHLiveChatViewController

-(void)setLive:(JHLive *)live{
    _live = live;
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait]] forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = JHRGBA(255, 255, 255, 0);
    self.iconBtn.layer.cornerRadius = 15;
    self.iconBtn.layer.masksToBounds = YES;
    [self onlineChange];
    
}
-(void)onlineChange{
    [NSTimer scheduledTimerWithTimeInterval:2 block:^(NSTimer * _Nonnull timer) {
        self.onlineLab.text = [NSString stringWithFormat:@"%d",arc4random_uniform(10000)];
    } repeats:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
