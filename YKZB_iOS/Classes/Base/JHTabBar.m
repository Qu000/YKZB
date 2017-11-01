//
//  JHTabBar.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHTabBar.h"

@interface JHTabBar()

@property (nonatomic, strong)UIImageView * tabBarBGView;

@property (nonatomic, strong)NSArray * dataList;

@property (nonatomic, strong) UIButton * lastItem;;

@property (nonatomic, strong) UIButton * cameraButton;
@end

@implementation JHTabBar

-(UIButton *)cameraButton{
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        _cameraButton.tag = JHItemTypeLaunch;
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

-(NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"tab_live",@"tab_me"];
    }
    return _dataList;
}

-(UIImageView *)tabBarBGView{
    if (!_tabBarBGView) {
        _tabBarBGView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBarBGView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //背景
        [self addSubview:self.tabBarBGView];
        
        //item
        for (NSInteger i=0; i<self.dataList.count; i++) {
            UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
            //不让图片在高亮状态下改变
            item.adjustsImageWhenHighlighted = NO;//取消高亮(我们要手动配置)
            
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.dataList[i]stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            item.tag = JHItemTypeLive + i;
            
            if (i==0) {
                item.selected = YES;
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        
        //添加中间的特殊按钮
        [self addSubview:self.cameraButton];
    }
    return self;
}
-(void)clickItem:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:button.tag];
    }
    
//    !self.block?:self.block(self, button.tag);
    if (self.block) {
        self.block(self, button.tag);
    }
    
    //取消中间button的动画&&不影响其他两个按钮
    if (button.tag == JHItemTypeLaunch) {
        return;
    }
    
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //动画
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);//先扩大到1.2
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;//恢复
        }];
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.tabBarBGView.frame = self.bounds;
    CGFloat btnW = self.bounds.size.width / self.dataList.count;

    
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        UIView * btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.frame = CGRectMake((btn.tag-JHItemTypeLive)*btnW, 0, btnW, self.frame.size.height);//i * btnW可能会不执行到这一步，所以不用这个
            
        }
    }
    
    [_cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 40);
    
}





@end
