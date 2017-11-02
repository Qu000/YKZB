//
//  JHCacheHelper.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/11/2.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHCacheHelper.h"

#define kimageURL @"imageURL"

@implementation JHCacheHelper

+(NSString *)getAdvertise{

    return [[NSUserDefaults standardUserDefaults]objectForKey:kimageURL];
}

+(void)setAdvertise:(NSString *)imageURL{

    [[NSUserDefaults standardUserDefaults] setObject:imageURL forKey:kimageURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
