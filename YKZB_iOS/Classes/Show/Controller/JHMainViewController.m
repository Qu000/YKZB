//
//  JHMainViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMainViewController.h"
#import "JHMainTopView.h"

@interface JHMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray * dataList;

@property (nonatomic, strong) JHMainTopView * topView;;
@end

@implementation JHMainViewController


-(JHMainTopView *)topView{
    if (!_topView) {
        _topView = [[JHMainTopView alloc]initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataList];
        
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
            
        };
    }
    return _topView;
}

-(NSArray *)dataList{
    if (!_dataList) {
        _dataList = @[@"关注",@"热门",@"附近"];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}
-(void)setupUI{
    //NavItem
    [self setupNavItem];
    
    //添加子视图控制器
    [self setupChildViewControllers];
    
}
#pragma mark---NavItem
-(void)setupNavItem{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];


    self.navigationItem.titleView = self.topView;

}

#pragma mark---添加子视图控制器
-(void)setupChildViewControllers{
    NSArray * vcNames= @[@"JHFocuseViewController",@"JHHotViewController",@"JHNearViewController"];
    for (NSInteger i = 0; i < vcNames.count; i++) {
        NSString * vcName = vcNames[i];
        UIViewController * vc = [[NSClassFromString(vcName)alloc]init];
        vc.title = self.dataList[i];
        
        //addChildViewController:vc 不会执行该vc的viewDidLoad
        [self addChildViewController:vc];
    }
    
    //将子控制器的view加到MainVc的scrollView上
    
    //设置scrollView的contentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.dataList.count, 0);

    self.contentScrollView.delegate = self;
    
    //默认先展示第二个界面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    //进入主控制器时加载页面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

#pragma mark---UIScrollViewDelegate
//减速结束时调用。加载子控制器view
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    CGFloat offset = scrollView.contentOffset.x;
    
    //获取第几个  的索引值
    NSInteger idx = offset / width;
    
    //传递联动索引值给topView
    [self.topView scrolling:idx];
    
    //根据索引值，返回vc的引用
    UIViewController * vc = self.childViewControllers[idx];
    
    //判读当前vc是否执行过viewDidLoad
    if ([vc isViewLoaded]) return;
    
    //设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, width, height);
    
    //将子控制器view加入到scrollView上
    [scrollView addSubview:vc.view];
}

//动画结束时调用(点击topView的button时，走的代理;因为topView中button的改变，不会走scrollViewDidEndDecelerating)
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    [self scrollViewDidEndDecelerating:scrollView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
