//
//  LunTanMoreViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanMoreViewController.h"

#import "LunTanTitleTableViewCell.h"
@interface LunTanMoreViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LunTanMoreViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanTitleTableViewCell)];
    
    
}
- (void)configSubViews {
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"论坛";
    
    F3f3f3NavigationBarColor
    
    
    
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"LunTanMoreDetailViewController" sender:self];
}

@end
