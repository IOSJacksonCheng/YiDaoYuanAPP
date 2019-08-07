//
//  UserJudgeListViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSUserJudgeListViewController.h"

#import "UserMineJudgeListTableViewCell.h"
#import "GoToJudgeViewController.h"
@interface CSUserJudgeListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *judgeTableView;
@property (nonatomic, assign) int page;


@end

@implementation CSUserJudgeListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configNavigationBar];
    
    [self configTableView];
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)endRefresh {
    if (self.judgeTableView.mj_header.isRefreshing) {
        [self.judgeTableView.mj_header endRefreshing];
    }
    if (self.judgeTableView.mj_footer.isRefreshing) {
        [self.judgeTableView.mj_footer endRefreshing];
    }
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_evaluation Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getUserJudgeListModelWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.judgeTableView reloadData];
                
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}

- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
  
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_evaluation Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getUserJudgeListModelWithResponseObject:CSGetResult[@"lists"]];
            [self.judgeTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    
    self.judgeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.judgeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.judgeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [self.judgeTableView registerNib:[UINib nibWithNibName:CSCellName(UserMineJudgeListTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(UserMineJudgeListTableViewCell)];
  
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    self.title = @"我的评价";
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
    UserMineJudgeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(UserMineJudgeListTableViewCell)];
    UserJudgeListModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserJudgeListModel *model = self.listArray[indexPath.row];

    
    return 105 + [CSUtility accrodingTextGiveItHeightWith:model.content WithLabelInterval:20 WithFont:13];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserJudgeListModel *model = self.listArray[indexPath.row];

    GoToJudgeViewController *new = [GoToJudgeViewController new];
    
    new.order_id = model.order_id;
    
    new.typestring = model.type;
    
    
    
    [self.navigationController pushViewController:new animated:YES];
}
@end
