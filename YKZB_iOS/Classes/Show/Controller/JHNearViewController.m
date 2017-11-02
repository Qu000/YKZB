//
//  JHNearViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHNearViewController.h"
#import "JHLiveHandler.h"

#import "JHNearLiveCell.h"

static NSString * identifier = @"JHNearLiveCell";

#define kMargin 5
#define kItemWith 100

@interface JHNearViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray * dataList;

@end

@implementation JHNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    [self loadData];


}

-(void)setupUI{

    [self.collectionView registerNib:[UINib nibWithNibName:@"JHNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)loadData{

    [JHLiveHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        self.dataList = obj;
        
        [self.collectionView reloadData];
        
    } failed:^(id obj) {
        
        NSLog(@"%@",obj);
    
    }];
}

#pragma mark---UICollectionViewDelegate&&UICollectionViewDataSource代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.dataList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    JHNearLiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.flow = self.dataList[indexPath.row];
    
    return cell;
}

//cell将要显示时调用
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{

    //将cell的动画showAnimation写在cell里，不用暴露给外界
    JHNearLiveCell * cellAnimation = (JHNearLiveCell *)cell;
    [cellAnimation showAnimation];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}

#pragma mark---UICollectionViewDelegateFlowLayout代理
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger count = self.collectionView.width / kItemWith;
    CGFloat etraWith = (self.collectionView.width - kMargin * (count + 1)) / count;
    
    return CGSizeMake(etraWith, etraWith + 30);//30为item中label的高
}





@end
