//
//  YiDaoKeTangSearchViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangSearchViewController.h"

#import "YiDaoKeTangSearchTableViewCell.h"
@interface YiDaoKeTangSearchViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *searchView;

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
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangSearchTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangSearchTableViewCell)];
    
    
    
}
- (void)configSubViews {
    
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
    
   
    
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YiDaoKeTangSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangSearchTableViewCell)];
    
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 225;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
}
@end
