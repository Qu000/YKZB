//
//  JHAPIConfig.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JHAPIConfig : NSObject


//http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"

//http://service.ingkee.com/api/live/gettop


//信息类服务器地址http://service.ingkee.com
#define SERVER_HOST @""

//图片服务器地址http://img.meelive.cn/   http://img2.inke.cn/  可用的
#define IMAGE_HOST @""

//首页数据（热门直播）api/live/gettop
#define API_LiveGetTop @"http://116.211.167.106/api/live/aggregation?uid=609350158&interest=1"//133825214

//广告地址
#define API_Advertise @"advertise/get"

/**
 广告图片
 */
#define API_AdvertisePic @"http://img2.inke.cn/NTY3MTMxNDczMDczNjc3.jpg"
//@"http://img2.inke.cn/NTY3MTMxNDczMDczNjc3.jpg"广告图片

//

//热门话题
#define API_TopicIndex @"api/live/topicindex"

//附近的人
#define API_NearLocation @"http://116.211.167.106/api/live/near_flow_old"

//@"http://116.211.167.106/api/live/near_flow_old?&gender=1&gps_info=116.449411%2C39.904484&loc_info=CN%2C%E5%8C%97%E4%BA%AC%E5%B8%82%2C%E5%8C%97%E4%BA%AC%E5%B8%82&is_new_user=1&lc=0000000000000049&cc=TG0001&cv=IK4.0.00_Iphone&proto=7&idfa=2D707AF8-980F-415C-B443-6FED3E9BBE97&idfv=723152C7-9C98-43F8-947F-18331280D72F&devi=135ede19e251cd6512eb6ad4f418fbbde03c9266&osversion=ios_10.100000&ua=iPhone5_2&imei=&imsi=&uid=609350158&sid=20f7ZyQ3C09I3wDcU0i0bM5n3F8osSAui2L04fGf4WTHRgL9J8qi1&conn=wifi&mtid=87edd7144bd658132ae544d7c9a0eba8&mtxid=acbc329027f3&logid=133&interest=1&longitude=106.160000&latitude=29.180000&multiaddr=1&s_sg=dba9d2e16943a8d4568e8bc0f32e6f7d&s_sc=100&s_st=1488507776"

//@"api/live/near_recommend"//?uid=85149891&latitude=40.090562&longitude=116.413353

//福尔摩洪直播地址
#define Live_FEMH @"rtmp://live.hkstv.hk.lxdns.com:1935/live/FEMH"

@end

