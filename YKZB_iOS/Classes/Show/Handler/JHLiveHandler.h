//
//  JHLiveHandler.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/29.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHBaseHandler.h"

@interface JHLiveHandler : JHBaseHandler

/**
 * 获取热门直播信息
 * success
 * failed
*/
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;


/**
 * 获取附近直播信息
 * success
 * failed
 */
+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;


/**
 * 获取广告页信息
 * success
 * failed
 */
+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end
