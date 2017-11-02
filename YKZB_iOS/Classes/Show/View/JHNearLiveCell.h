//
//  JHNearLiveCell.h
//  YKZB_iOS
//
//  Created by qujiahong on 2017/11/1.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHFlow.h"

@interface JHNearLiveCell : UICollectionViewCell

@property (nonatomic, strong) JHFlow * flow;

-(void)showAnimation;

@end
