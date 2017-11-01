//
//  JHLocationManager.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/31.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationBlock)(NSString * lat, NSString * lon);

@interface JHLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)getGPS:(LocationBlock)block;

@property (nonatomic, copy) NSString * lon;
@property (nonatomic, copy) NSString * lat;
@end
