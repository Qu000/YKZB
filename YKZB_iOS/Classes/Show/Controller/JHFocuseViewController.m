//
//  JHFocuseViewController.m
//  YKZB_iOS
//
//  Created by qujiahong on 2017/10/28.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

#import "JHFocuseViewController.h"

#import "JHLiveCell.h"
#import "JHPlayerViewController.h"
#import "JHCreator.h"

static NSString * identifier = @"focuse";

@interface JHFocuseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataList;

@end

@implementation JHFocuseViewController



- (NSMutableArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self updateUI];
    
    [self loadData];
    
}

- (void)updateUI{
    self.tableView.separatorColor = JHRGB(0, 187, 174);
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"JHLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
}

//这都是做的假数据
-(void)loadData{
    
    JHLive * live = [[JHLive alloc] init];
    JHCreator * creator = [[JHCreator alloc] init];
    live.creator = creator;
    
    live.streamAddr = Live_FEMH;
    live.city = @"重庆";
    live.onlineUsers = 66666;
    live.creator.nick = @"福尔摩洪";
    creator.portrait = @"FEMH";
    [self.dataList addObject:live];
    
    [self.tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    JHLiveCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"JHLiveCell" owner:self options:nil] lastObject];
    
    JHLiveCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return 70 + self.view.bounds.size.width + 10;
    return 70 + SCREEN_WIDTH;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    JHPlayerViewController * playerVC = [[JHPlayerViewController alloc] init];
//    playerVC.live = self.dataList[indexPath.row];
//    [self.navigationController pushViewController:playerVC animated:YES];
    
    JHLive * live = self.dataList[indexPath.row];
    
    JHPlayerViewController * playerVc = [[JHPlayerViewController alloc]init];
    playerVc.live = live;//传值
    playerVc.judgeIdx = 0;
    [self.navigationController pushViewController:playerVc animated:YES];
    
}




@end
