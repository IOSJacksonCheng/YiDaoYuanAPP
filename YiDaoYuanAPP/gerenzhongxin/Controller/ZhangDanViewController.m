//
//  ZhangDanViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZhangDanViewController.h"

#import "ZhangDanTableViewCell.h"
@interface ZhangDanViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ZhangDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTableView];
    [self configNavigationBar];
    
}
- (void)configTableView {
    
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZhangDanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZhangDanTableViewCell)];
    return cell;
}
@end
