//
//  JHTabBar.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, JHItemType) {

    JHItemTypeLive = 100,//直播
    JHItemTypeProfile,//我的
    JHItemTypeLaunch = 10,//启动直播
};


@class JHTabBar;

typedef void(^TabBlock)(JHTabBar * tabbar,JHItemType idx);


@protocol JHTabBarDelegate <NSObject>

-(void)tabbar:(JHTabBar *)tabbar clickButton:(JHItemType)idx;

@end

@interface JHTabBar : UIView

@property (nonatomic, weak) id<JHTabBarDelegate> delegate;
@property (nonatomic,copy) TabBlock block;
@end
