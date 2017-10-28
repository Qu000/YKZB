//
//  JHMainTopView.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMainTopView.h"

@implementation JHMainTopView


- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles{
    self = [super initWithFrame:frame];
    if (self) {//self.frame.size.width使用YYKit->self.width
        CGFloat btnW = self.width / titles.count;
        CGFloat btnH = self.height;
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString * vcTitle = titles[i];
            [button setTitle:vcTitle forState:UIControlStateNormal];
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            
            button.frame = CGRectMake(i*btnW, 0, btnW, btnH);
            
            [button addTarget:self action:@selector(clickTitle:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
        }
    }
    return self;
}

-(void)clickTitle:(UIButton *)button{

    //
    
}

@end
