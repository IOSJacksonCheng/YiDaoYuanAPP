//
//  CSSearchViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSSearchViewController.h"

#import "CSSearchTableViewCell.h"
#import "DaShiDetailViewController.h"
@interface CSSearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSString *recordMasterId;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)clickSearchButton:(id)sender;

@end

@implementation CSSearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameTextField becomeFirstResponder];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    self.nameTextField.text = @"";
    [self configNavigationBar];
    
    [self configTableView];
    self.listArray = @[].mutableCopy;
    [self getNewData];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"keyword"] = self.nameTextField.text;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_index_search Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getManyDaShiModellArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.searchTableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)GetMoreData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    para[@"keyword"] = self.nameTextField.text;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_index_search Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getManyDaShiModellArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.searchTableView reloadData];
                
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
    if (self.searchTableView.mj_header.isRefreshing) {
        [self.searchTableView.mj_header endRefreshing];
    }
    if (self.searchTableView.mj_footer.isRefreshing) {
        [self.searchTableView.mj_footer endRefreshing];
    }
}
- (void)configTableView {
    self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.searchTableView registerNib:[UINib nibWithNibName:CSCellName(CSSearchTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(CSSearchTableViewCell)];
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.searchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
    self.searchTableView.rowHeight = 156;
}
- (void)configSubViews {
    self.inputView.layer.cornerRadius = 12;
    self.inputView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"搜索";
    
    WhiteNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark --UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(CSSearchTableViewCell)];
    ManyDaShiModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ManyDaShiModel *model = self.listArray[indexPath.row];

    self.recordMasterId = model.master_id;
    [self performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DaShiDetailViewController"]) {
        DaShiDetailViewController *new = segue.destinationViewController;
        new.passMasterID = self.recordMasterId;
    }
}
- (IBAction)clickSearchButton:(id)sender {
    
    [self.view endEditing:YES];
    
    [self getNewData];
}
@end
