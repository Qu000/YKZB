//
//  JHMainTopView.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MianTopBlock)(NSInteger tag);



@interface JHMainTopView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@property ( nonatomic, copy) MianTopBlock block;

-(void)scrolling:(NSInteger)idx;
@end
