//
//  MyCollectViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MyCollectViewController.h"

#import "MyCollectTableViewCell.h"
@interface MyCollectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MyCollectTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MyCollectTableViewCell)];
    
    self.tableView.rowHeight = 134;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
  
    self.title = @"我的收藏";
    
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
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MyCollectTableViewCell)];
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}
@end
