//
//  YiDaoKeTangSearchViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangSearchViewController.h"

#import "YiDaoKeTangSearchTableViewCell.h"

#import "YiDaoKeTangDetailViewController.h"
@interface YiDaoKeTangSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *recordVideoId;
- (IBAction)clickSearchButtonDone:(id)sender;


@end

@implementation YiDaoKeTangSearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getNewData];
    
    [self.searchTextField becomeFirstResponder];
}
- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"keyword"] = self.searchTextField.text;
    
    
    self.page = 1 ;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Course Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getYiDaoKeTangModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
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
    
    para[@"keyword"] = self.searchTextField.text;
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
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangSearchTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangSearchTableViewCell)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
    self.searchView.layer.cornerRadius = 15;
   
    self.searchView.layer.masksToBounds = YES;
    
    self.listArray = @[].mutableCopy;
   
    
    self.searchTextField.returnKeyType = UIReturnKeySearch;//变为搜索按钮
    
    self.searchTextField.delegate = self;//设置代理
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    
    [self getNewData];
    return YES;
    
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

    YiDaoKeTangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangSearchTableViewCell)];
    YiDaoKeTangModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 225;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    YiDaoKeTangModel *model = self.listArray[indexPath.row];

    self.recordVideoId = model.class_id;
 
    [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     if ([segue.identifier isEqualToString:@"YiDaoKeTangDetailViewController"]) {
        YiDaoKeTangDetailViewController *new = segue.destinationViewController;
        new.passId = self.recordVideoId;
    }
}
- (IBAction)clickSearchButtonDone:(id)sender {
    [self getNewData];
}
@end
