//
//  IndustryNewsViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "IndustryNewsViewController.h"
#import "IndustryNewsTableViewCell.h"
#import "CSNewsViewController.h"
#import "YiDaoKeTangContentViewController.h"
@interface IndustryNewsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsTabelView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) IndustryNewsModel *chooseModel;
@end

@implementation IndustryNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listArray = @[].mutableCopy;
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getNewData];
}
- (void)endRefresh {
    if (self.newsTabelView.mj_header.isRefreshing) {
        [self.newsTabelView.mj_header endRefreshing];
    }
    if (self.newsTabelView.mj_footer.isRefreshing) {
        [self.newsTabelView.mj_footer endRefreshing];
    }
}
- (void)getNewData {
    self.page = 1;
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_News_Index Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getIndustryNewsModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.newsTabelView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.newsTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.newsTabelView registerNib:[UINib nibWithNibName:CSCellName(IndustryNewsTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(IndustryNewsTableViewCell)];
    self.newsTabelView.rowHeight = 133.5;
    self.newsTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.newsTabelView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)getMoreData {
    
    self.page ++;
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];

    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_News_Index Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getIndustryNewsModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了");
            } else {
                [self.listArray addObjectsFromArray:array];
                [self.newsTabelView reloadData];

            }
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)configSubViews {
    
}

- (void)configNavigationBar {
   
    self.title = @"行业资讯";
    
    F3f3f3NavigationBarColor
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    IndustryNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(IndustryNewsTableViewCell)];
    cell.model = self.listArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.chooseModel = self.listArray[indexPath.row];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    YiDaoKeTangContentViewController *new = [main instantiateViewControllerWithIdentifier:@"YiDaoKeTangContentViewController"];
    new.passTitle = @"行业资讯";
    new.showBottomView = NO;
    
    new.passUrl = [NSString stringWithFormat:@"%@%@&&news_id=%@", BASE_URL,CSURL_Site_News,self.chooseModel.news_id];

    [self.navigationController pushViewController:new animated:YES];
}


@end
