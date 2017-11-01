//
//  JHInfo.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/11/1.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHActInfo.h"
#import "JHFCreator.h"
#import "JHExtra.h"

@interface JHInfo : NSObject

@property (nonatomic, strong) JHActInfo * actInfo;
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) JHFCreator * creator;
@property (nonatomic, strong) JHExtra * extra;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger landscape;
@property (nonatomic, strong) NSArray * like;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, strong) NSString * liveType;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pubStat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * shareAddr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, strong) NSString * token;
@property (nonatomic, assign) NSInteger version;

@end
