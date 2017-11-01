//
//  JHLiveHandler.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/29.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHLiveHandler.h"
#import "HttpTool.h"

#import "JHLocationManager.h"
#import "JHLive.h"
#import "JHFlow.h"


@implementation JHLiveHandler


+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{

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


+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{

//    JHLocationManager * manager = [JHLocationManager sharedManager];
//    @"longitude":manager.lon,
//    @"latitude":manager.lat,
    NSDictionary * param = @{@"gender":@"1",
                             @"gps_info":@"116.449411%2C39.904484",
                         @"loc_info":@"CN%2C%E5%8C%97%E4%BA%AC%E5%B8%82%2C%E5%8C%97%E4%BA%AC%E5%B8%82",
                             @"is_new_user":@"1",
                             @"lc":@"0000000000000049",
                             @"cc":@"TG0001",
                             @"cv":@"IK4.0.00_Iphone",
                             @"proto":@"7",
                             @"idfa":@"2D707AF8-980F-415C-B443-6FED3E9BBE97",
                           @"idfv":@"723152C7-9C98-43F8-947F-18331280D72F",
                             @"devi":@"135ede19e251cd6512eb6ad4f418fbbde03c9266",
                             @"osversion":@"ios_10.100000",
                             @"ua":@"iPhone5_2",
                             @"imei":@"",
                             @"imsi":@"",
                             @"uid":@"609350158",
                             @"sid":@"20f7ZyQ3C09I3wDcU0i0bM5n3F8osSAui2L04fGf4WTHRgL9J8qi1",
                             @"conn":@"wifi",
                             @"mtid":@"87edd7144bd658132ae544d7c9a0eba8",
                             @"mtxid":@"acbc329027f3",
                             @"logid":@"133",
                             @"interest":@"1",
                             @"longitude":@"106.160000",
                             @"latitude":@"29.180000",
                             @"multiaddr":@"1",
                             @"s_sg":@"dba9d2e16943a8d4568e8bc0f32e6f7d",
                             @"s_sc":@"100",
                             @"s_st":@"1488507776"
                             };
    
    [HttpTool getWithPath:API_NearLocation params:param success:^(id json) {

        //因为这里的数据结构和热门直播很相似，所以就用了live模型
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json[@"error_msg"]);
            
        }
        else{
            //            success(json);
            //返回信息正确--数据解析
            NSArray * flow = [JHFlow mj_objectArrayWithKeyValuesArray:json[@"flow"]];
            
            success(flow);
            
            
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];
}

@end
