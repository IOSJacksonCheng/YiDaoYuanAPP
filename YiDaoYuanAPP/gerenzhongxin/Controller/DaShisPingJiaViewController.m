//
//  DaShisPingJiaViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShisPingJiaViewController.h"

#import "DaShiDetailJudgeTableViewCell.h"
@interface DaShisPingJiaViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *judgeTableView;
@property (nonatomic, assign) int page;
@end

@implementation DaShisPingJiaViewController

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
   
    para[@"master_id"] = CS_UserID;
    
    para[@"type"] = @"1";
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_evaluate Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getUserJudgeArrayArrayWithResponseObject:CSGetResult[@"lists"]];
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
    para[@"master_id"] = CS_UserID;
    
    para[@"type"] = @"1";
   
    self.page = 1;
   
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_evaluate Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getUserJudgeArrayArrayWithResponseObject:CSGetResult[@"lists"]];
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
    [self.judgeTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    self.title = @"用户评分";
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
    UserJudgeArray *model = self.listArray[indexPath.row];
  
    DaShiDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserJudgeArray *model = self.listArray[indexPath.row];
    return 83 + 10 + [CSUtility accrodingTextGiveItHeightWith:model.content WithLabelInterval:(87 + 19) WithFont:12];
}


@end
