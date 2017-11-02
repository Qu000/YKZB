//
//  JHNearLiveCell.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/11/1.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHNearLiveCell.h"

@interface JHNearLiveCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *starNumberBtn;
@property (weak, nonatomic) IBOutlet UILabel *distanceLab;


@end


@implementation JHNearLiveCell


-(void)showAnimation{
    //执行过动画的cell就不用再执行了
    if (self.flow.info.isShow) {
        return;
    }
    
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{

        self.layer.transform = CATransform3DMakeScale(1, 1, 1);

        self.flow.info.show = YES;
    }];

}

-(void)setFlow:(JHFlow *)flow{
    _flow = flow;
    
    [self.headImageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,flow.info.creator.portrait] placeholder:@"default_room"];
    
    NSString * str = [NSString stringWithFormat:@"%ld",(long)flow.info.creator.level];
   
    [self.starNumberBtn setTitle:str forState:UIControlStateNormal];
    
    self.distanceLab.text = [NSString stringWithFormat:@"%@",flow.info.distance];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.starNumberBtn.layer.cornerRadius = 2;
    self.starNumberBtn.layer.masksToBounds = YES;
}

@end
