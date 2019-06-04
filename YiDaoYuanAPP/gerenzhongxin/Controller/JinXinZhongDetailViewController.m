//
//  JinXinZhongDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "JinXinZhongDetailViewController.h"

#import "ConsultJinXingZhongTableViewCell.h"
#import "ConsultMyHuiFuTableViewCell.h"
#import "ConsultHuiFuTableViewCell.h"
#import "SureOrderDaShiInfomationTableViewCell.h"

@interface JinXinZhongDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JinXinZhongDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderDaShiInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultMyHuiFuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultMyHuiFuTableViewCell)];
 [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultHuiFuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultHuiFuTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultJinXingZhongTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultJinXingZhongTableViewCell)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {

}
- (void)configNavigationBar {
    self.title = @"咨询详情";
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
        return 2;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SureOrderDaShiInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
            return cell;
        }
        ConsultJinXingZhongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultJinXingZhongTableViewCell)];
        return cell;
       
       
    }
    

    if (indexPath.row == 0) {
        ConsultJinXingZhongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultJinXingZhongTableViewCell)];
        return cell;
    }else if (indexPath.row == 1) {
        ConsultMyHuiFuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultMyHuiFuTableViewCell)];
        return cell;
    }
    
    ConsultHuiFuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultHuiFuTableViewCell)];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            return 153;
        }
        return 227.5;
    }

    if (indexPath.row == 0) {
        return 153;
    }else  if (indexPath.row == 1) {
        return 102;
    }
    return 44;

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    
    view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = UILabel.new;
    
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.centerY.mas_equalTo(0);
    }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"互动问答详情" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 44;
}
@end
