//
//  JHLiveChatViewController.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/31.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHBaseViewController.h"
#import "JHLive.h"
#import "JHFlow.h"

@interface JHLiveChatViewController : JHBaseViewController

@property (nonatomic, strong) JHLive * live;
@property (nonatomic, strong) JHFlow * flow;
@property (nonatomic, assign) NSUInteger judgeIdx;
@end
