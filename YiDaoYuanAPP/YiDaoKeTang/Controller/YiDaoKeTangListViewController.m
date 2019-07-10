//
//  YiDaoKeTangListViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangListViewController.h"
#import "YiDaoKeTangTableViewCell.h"
#import "YiDaoKeTangDetailViewController.h"
@interface YiDaoKeTangListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *recordVideoId;
@end

@implementation YiDaoKeTangListViewController
- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.listArray = @[].mutableCopy;
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getNewData];
}
- (void)getNewData {
    
        NSMutableDictionary *para = @{}.mutableCopy;
        
        para[@"category_id"] = self.passIdString;
        
        para[@"is_hot"] = self.isHot;
        
        para[@"is_fee"] = self.isFree;
        self.page = 1 ;
        para[@"page"] = [NSString stringWithFormat:@"%d",self.page];

        [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Course Pameters:para success:^(id  _Nonnull responseObject) {
            [self endRefresh];
            if (CSInternetRequestSuccessful) {
                self.listArray = [CSParseManager getYiDaoKeTangModelArrayWithResponseObject:CSGetResult[@"lists"]];
                
                [self.tableview reloadData];
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
    
    para[@"category_id"] = self.passIdString;
    
    para[@"is_hot"] = self.isHot;
    
    para[@"is_fee"] = self.isFree;
    self.page ++;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Course Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getYiDaoKeTangModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                [self.tableview reloadData];

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
    if (self.tableview.mj_header.isRefreshing) {
        [self.tableview.mj_header endRefreshing];
    }
    if (self.tableview.mj_footer.isRefreshing) {
        [self.tableview.mj_footer endRefreshing];
    }
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
  
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
    
}

- (void)configSubViews {
    
   
    
}

    
- (void)configNavigationBar {
    
    self.title = @"易道课堂";
    
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
 
    YiDaoKeTangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
    YiDaoKeTangModel *model = self.listArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YiDaoKeTangModel *model = self.listArray[indexPath.row];
    self.recordVideoId = model.class_id;
   [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return 273;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     if ([segue.identifier isEqualToString:@"YiDaoKeTangDetailViewController"]) {
        YiDaoKeTangDetailViewController *new = segue.destinationViewController;
        new.passId = self.recordVideoId;
    }
}
@end
