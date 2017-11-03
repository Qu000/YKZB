//
//  JHLiveCell.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/29.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHLiveCell.h"

@interface JHLiveCell()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *onLineLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;


@end


@implementation JHLiveCell


-(void)setLive:(JHLive *)live{

    _live = live;
    
    self.nameLabel.text = live.creator.nick;
    self.locationLabel.text = live.city;
    self.onLineLabel.text = [@(live.onlineUsers) stringValue];
    
    //关注-造的假数据-这里进行判断
    if ([live.creator.nick isEqualToString:@"福尔摩洪"]) {
        self.headView.image = [UIImage imageNamed:@"FEMH"];
        self.bigImageView.image = [UIImage imageNamed:@"FEMH"];
    }else{
        [self.headView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
        [self.bigImageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    }
   
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headView.backgroundColor = JHRGB(0, 227, 212);
    self.headView.layer.cornerRadius = 25;
    self.headView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
