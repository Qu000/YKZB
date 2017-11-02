//
//  JHAdvertiseView.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/11/2.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHAdvertiseView.h"
#import "JHLiveHandler.h"
//#import 广告模型头文件

#import "JHCacheHelper.h"

static NSInteger showTime = 3;

@interface JHAdvertiseView()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation JHAdvertiseView

+ (instancetype)loadAdvertiseView{
    
    JHAdvertiseView *advertiseView = [[[NSBundle mainBundle]loadNibNamed:@"JHAdvertiseView" owner:nil options:nil] lastObject];
    
    return  advertiseView;
}

//广告页初始化方法
-(void)awakeFromNib{
    [super awakeFromNib];
    self.frame = [UIScreen mainScreen].bounds;
    
    //展示广告
    [self showAdvertise];
    
    //下载广告
//    [self dowmAdvertise];
    [self down];
    
    //倒计时
    [self startTimer];
}

-(void)showAdvertise{

    NSString * filename = [JHCacheHelper getAdvertise];
    NSString * filePath = [NSString stringWithFormat:@"%@%@",IMAGE_HOST,filename];
    UIImage * lastCacheImage = [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:filePath];
    if (lastCacheImage) {
        self.bgImageView.image = lastCacheImage;
    }
    else{
        self.hidden = YES;
    }
}

-(void)dowmAdvertise{
    //广告页接口挂了，不用模型了
    [JHLiveHandler executeGetAdvertiseTaskWithSuccess:^(id obj) {
        
//        [self.bgImageView downloadImage:API_AdvertisePic placeholder:@""];//不是要立即显示，下一次进来才显示
        
        NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,API_AdvertisePic]];
        //SDWebImageAvoidAutoSetImage下载完图片，不给imageView赋值
        [[SDWebImageManager sharedManager] downloadImageWithURL:imageURL options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
//            [[NSUserDefaults standardUserDefaults] setObject:[NSURL URLWithString:API_AdvertisePic] forKey:@"imageURL"];
//            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //让上面的偏好设置不暴露给外界
            [JHCacheHelper setAdvertise:API_AdvertisePic];
            NSLog(@"图片下载成功");
            
        }];
        
        
    } failed:^(id obj) {
        
    }];
    
    
}

-(void)down{

    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,API_AdvertisePic]];
    //SDWebImageAvoidAutoSetImage下载完图片，不给imageView赋值
    [[SDWebImageManager sharedManager] downloadImageWithURL:imageURL options:SDWebImageAvoidAutoSetImage progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //让偏好设置不暴露给外界
        [JHCacheHelper setAdvertise:API_AdvertisePic];
//        NSLog(@"图片下载成功");
        
    }];
    
}

/*
 如验证码的倒计时做法：
 nstimer，可以，但是不准确
 最优的方法依旧是 dispatch_source_t
 RunLoop有待学习
 */
-(void)startTimer{
    
    __block NSUInteger timeOut = showTime + 1;
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    self.timer = timer;
    
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeOut <= 0) {
            //异步回主线程
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self dissMiss];
            });
            
        }else{
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.timeLab.text = [NSString stringWithFormat:@"跳过%lu",(unsigned long)timeOut];
            });
            
            timeOut --;
        }
        
        
    });
    dispatch_resume(timer);

}

-(void)dissMiss{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}
@end
