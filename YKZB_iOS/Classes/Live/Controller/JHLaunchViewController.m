//
//  JHLaunchViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHLaunchViewController.h"
#import "LFLivePreview.h"

@interface JHLaunchViewController ()

@end

@implementation JHLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)closeLaunch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)startLive:(id)sender {
    
    //推流页面可能来的很慢，会造成两个view的重叠，这时候，用一个黑屏来过渡一下
    UIView * bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bgView];
    
    LFLivePreview * preView = [[LFLivePreview alloc]initWithFrame:self.view.bounds];
    
    preView.vc = self;
    
    [self.view addSubview:preView];
    
    //开启直播
    [preView startLive];
    
}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return YES;
//}


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
