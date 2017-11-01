//
//  JHLocationManager.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/31.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface JHLocationManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locManager;
@property (nonatomic, copy) LocationBlock block;;

@end

@implementation JHLocationManager


+ (instancetype)sharedManager{
//dispatch_once
    static JHLocationManager * _manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[JHLocationManager alloc]init];
    });
    
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc]init];
        
        //精确度
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
    
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"未启定位服务");
        }
        else{
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {//
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}

#pragma mark--代理
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    NSString * lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString * lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];

    self.lat = lat;
    self.lon = lon;
    
    self.block(lat, lon);
    
    //停止定位
    [self.locManager stopUpdatingLocation];
//    NSLog(@"纬度=%@",@(coor.latitude));
//    NSLog(@"经度=%@",@(coor.longitude));
}

- (void)getGPS:(LocationBlock)block{
    
    self.block = block;
    
    //开启定位（定位时，回传到上一个代理方法）
    [self.locManager startUpdatingLocation];
}

@end
