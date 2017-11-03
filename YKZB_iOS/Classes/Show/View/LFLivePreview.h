//
//  LFLivePreview.h
//  LFLiveKit
//
//  Created by 倾慕 on 16/5/2.
//  Copyright © 2016年 live Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFLivePreview : UIView

@property (nonatomic, strong) UIViewController * vc;

/**
 点击开始直播，就直接开始录播（屏蔽了推流框架的startLiveBtn，自己写好提供外界的方法）
 */
-(void)startLive;

/**
 点击结束直播，就直接结束录播（自己写好提供外界的方法）
 */
-(void)endLive;

@end
