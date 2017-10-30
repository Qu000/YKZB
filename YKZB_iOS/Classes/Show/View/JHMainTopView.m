//
//  JHMainTopView.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMainTopView.h"

@interface JHMainTopView()
@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, strong) NSMutableArray * buttons;
@end

@implementation JHMainTopView

-(NSArray *)buttons{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}



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
            
            button.tag = i;//设置block的回传
            
            [self addSubview:button];
            
            [self.buttons addObject:button];
            
            if (i == 1) {
                CGFloat h = 2;
                CGFloat y = 40;
                
                [button.titleLabel sizeToFit];
                
                self.lineView = [[UIView alloc]init];
                self.lineView.backgroundColor = [UIColor whiteColor];
                self.lineView.height = h;
                self.lineView.width = button.titleLabel.width;
                self.lineView.top = y;
                self.lineView.centerX = button.centerX;
                [self addSubview:self.lineView];
            }
        }
    }
    return self;
}

//topView的button点击事件
-(void)clickTitle:(UIButton *)button{

    self.block(button.tag);
    
    //点击按钮，使ScrollView滑动到相应位置(展示相应的子视图控制器)
    [self scrolling:button.tag];
}

//mainVc滚动时调用
-(void)scrolling:(NSInteger)idx{

    UIButton * button = self.buttons[idx];
    
    //点击按钮，使line滑动到相应位置
    [UIView animateWithDuration:0.2 animations:^{
        self.lineView.centerX = button.centerX;
    }];
}

@end
