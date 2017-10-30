//
//  JHLiveHandler.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/29.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHLiveHandler.h"
#import "HttpTool.h"
#import "JHLive.h"
@implementation JHLiveHandler


+ (void)ececuteGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{

    [HttpTool getWithPath:API_LiveGetTop params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json[@"error_msg"]);
        
        }
        else{
//            success(json);
            //返回信息正确--数据解析
            NSArray * lives = [JHLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            success(lives);
            

        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];

}


@end
