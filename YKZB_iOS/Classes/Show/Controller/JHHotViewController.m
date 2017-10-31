//
//  JHHotViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHHotViewController.h"
#import "JHLiveHandler.h"
#import "JHLiveCell.h"

#import "JHPlayerViewController.h"
static NSString *identifier = @"JHLiveCell";
@interface JHHotViewController ()

@property (nonatomic, strong) NSMutableArray * dataList;
@end

@implementation JHHotViewController


-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    
    [self updateUI];
    
    [self loadData];
}

- (void)updateUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"JHLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}
- (void)loadData{
    [JHLiveHandler ececuteGetHotLiveTaskWithSuccess:^(id obj) {
        NSLog(@"%@",obj);
        [self.dataList addObjectsFromArray:obj];
        [self.tableView reloadData];
        
    } failed:^(id obj) {
        
        NSLog(@"%@",obj);
        
    }];
}

#pragma mark---delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
//    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JHLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.live = self.dataList[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70+SCREEN_WIDTH;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JHLive * live = self.dataList[indexPath.row];
    
    JHPlayerViewController * playerVc = [[JHPlayerViewController alloc]init];
    playerVc.live = live;//传值
    [self.navigationController pushViewController:playerVc animated:YES];
}

@end
