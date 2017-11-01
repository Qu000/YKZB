//
//  JHNearViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHNearViewController.h"
#import "JHLiveHandler.h"

@interface JHNearViewController ()

@end

@implementation JHNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [JHLiveHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        NSLog(@"%@",obj);
        
    } failed:^(id obj) {
        
        NSLog(@"%@",obj);
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
