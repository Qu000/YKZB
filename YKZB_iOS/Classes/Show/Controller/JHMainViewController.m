//
//  JHMainViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHMainViewController.h"

@interface JHMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray * dataList;
@end

@implementation JHMainViewController


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
    [self scrollViewDidEndDecelerating:self.contentScrollView];
}

#pragma mark---UIScrollViewDelegate
//减速结束时调用。加载子控制器view
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    CGFloat offset = scrollView.contentOffset.x;
    
    //获取第几个  的索引值
    NSInteger idx = offset / width;
    
    //根据索引值，返回vc的引用
    UIViewController * vc = self.childViewControllers[idx];
    
    //判读当前vc是否执行过viewDidLoad
    if ([vc isViewLoaded]) return;
    
    //设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, width, height);
    
    //将子控制器view加入到scrollView上
    [scrollView addSubview:vc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
