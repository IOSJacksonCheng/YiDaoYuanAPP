//
//  DaShiDuanDaiHuiFuViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/6.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDuanDaiHuiFuViewController.h"
#import "DaShiDuanYiWanChengDetailTableViewCell.h"
#import "DaShiDuanYiWanChengInfoTableViewCell.h"
@interface DaShiDuanDaiHuiFuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *rightNowButton;
@end

@implementation DaShiDuanDaiHuiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanYiWanChengDetailTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanYiWanChengDetailTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanYiWanChengInfoTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    self.rightNowButton.layer.cornerRadius = 5;
    self.rightNowButton.layer.masksToBounds = YES;
    
   
    
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"确认订单";
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
    if (indexPath.row == 0) {
        DaShiDuanYiWanChengDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengDetailTableViewCell)];
        return cell;
    }
    if (indexPath.row == 1) {
        DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
        cell.csTitleLabel.text = @"阴历生日：";
        return cell;
    }
    if (indexPath.row == 2) {
        DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
        
        cell.csTitleLabel.text = @"出生地：";
        
        
        return cell;
    }
    
        DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
        cell.csTitleLabel.text = @"问题描述：";
        return cell;
    
    
    
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 182;
    }
   
    
    return 50;
}

@end
