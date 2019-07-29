//
//  ZhangDanViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZhangDanViewController.h"

#import "ZhangDanTableViewCell.h"

#import "YiDaoYuanCollectionModel.h"
@interface ZhangDanViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation ZhangDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self configNavigationBar];
    self.listArray =@[].mutableCopy;
    [self getNewData];
}
- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"type"] = @"1";
    
    self.page = 1 ;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_share_bill Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getYiDaoYuanCollectionModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
    
    
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"type"] = @"1";

    self.page ++;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_share_bill Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getYiDaoYuanCollectionModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.tableView reloadData];
                
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)configTableView {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ZhangDanTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZhangDanTableViewCell)];
    
    self.tableView.rowHeight = 50;
}
- (void)configNavigationBar {
    
    
    self.title = @"账单";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhangDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZhangDanTableViewCell)];
    
    YiDaoYuanCollectionModel *model = self.listArray[indexPath.row];
    cell.moneyLabel.text = model.money;
    cell.timeLabel.text = model.ctime;
    return cell;
}
@end
