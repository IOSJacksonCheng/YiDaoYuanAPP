//
//  CSSearchViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSSearchViewController.h"

#import "CSSearchTableViewCell.h"
@interface CSSearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UIView *inputView;

@end

@implementation CSSearchViewController
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
}

- (void)configTableView {
    self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.searchTableView registerNib:[UINib nibWithNibName:CSCellName(CSSearchTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(CSSearchTableViewCell)];
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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(CSSearchTableViewCell)];
    cell.showButton = NO;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
}
@end
