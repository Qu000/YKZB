//
//  JHBaseNavViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHBaseNavViewController.h"

@interface JHBaseNavViewController ()

@end

@implementation JHBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏颜色
    self.navigationBar.barTintColor = JHRGB(0, 216, 201);
    self.navigationBar.tintColor = [UIColor whiteColor];//(item上为白色)

}

//重写push，隐藏tabBar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

@end
