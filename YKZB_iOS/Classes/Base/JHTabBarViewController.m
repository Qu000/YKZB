//
//  JHTabBarViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHTabBarViewController.h"
#import "JHTabBar.h"
#import "JHBaseNavViewController.h"

#import "JHLaunchViewController.h"

@interface JHTabBarViewController ()<JHTabBarDelegate>
@property(nonatomic, strong) JHTabBar * jhTabBar;

@end

@implementation JHTabBarViewController

-(JHTabBar *)jhTabBar{
    if (!_jhTabBar) {
        _jhTabBar = [[JHTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _jhTabBar.delegate = self;
    }
    return _jhTabBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];


    //加载子控制器
    [self configViewControllers];
    
    //加载tabbar
    [self.tabBar addSubview:self.jhTabBar];
    
    //去掉tabBar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}

-(void)tabbar:(JHTabBar *)tabbar clickButton:(JHItemType)idx{
    
    //不是模态视图时
    if (idx != JHItemTypeLaunch) {
        self.selectedIndex = idx - JHItemTypeLive;
        return;
    }
    
    //是模态视图
    JHLaunchViewController * launchVc = [[JHLaunchViewController alloc]init];
    
    [self presentViewController:launchVc animated:YES completion:^{
        
    }];
}

-(void)configViewControllers{
    NSMutableArray * array = [NSMutableArray arrayWithArray:@[@"JHMainViewController",@"JHProfileViewController"]];
    for (NSInteger i = 0; i < array.count; i++) {
        NSString * vcName = array[i];
        UIViewController * vc = [[NSClassFromString(vcName)alloc]init];
    
        JHBaseNavViewController * nav = [[JHBaseNavViewController alloc]initWithRootViewController:vc];
        [array replaceObjectAtIndex:i withObject:nav];
        
    }
    
    self.viewControllers = array;
    
    
}
@end
