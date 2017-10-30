//
//  JHBaseHandler.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/29.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 处理事件完成
 */
typedef void(^CompleteBlock)();


/**
 * 处理事件成功
 * obj 返回数据
 */
typedef void(^SuccessBlock)(id obj);


/**
 * 处理事件失败
 * obj 错误信息
 */
typedef void(^FailedBlock)(id obj);
@interface JHBaseHandler : NSObject




@end
