//
//  ShopSureOrderPayMoneyWayViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopSureOrderPayMoneyWayViewController.h"

#import "PayMoneyWaysTableViewCell.h"
@interface ShopSureOrderPayMoneyWayViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *moneyTableView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@end

@implementation ShopSureOrderPayMoneyWayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}
- (void)configTableView {
    
    self.moneyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.moneyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.moneyTableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    
    
    
    
    
}

- (void)configSubViews {
    
    self.sureButton.layer.cornerRadius = 5;
}

- (void)configNavigationBar {
    
    
    self.title = @"确认订单";
    
    WhiteNavigationBarColor
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    PayMoneyWaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    cell.explainLabel.hidden = YES;
    if (indexPath.row == 0) {
        cell.titleImageView.image = DotaImageName(@"icon_yu e");
        cell.titleLabel.text = @"余额支付";
    } else if (indexPath.row == 1) {
        cell.titleImageView.image = DotaImageName(@"icon_yidaoyuan");
        cell.titleLabel.text = @"易道源支付";
        cell.explainLabel.hidden = NO;
    } else if (indexPath.row == 2) {
        cell.titleImageView.image = DotaImageName(@"icon_zhifubao");
        cell.titleLabel.text = @"支付宝支付";
    } else if (indexPath.row == 3) {
        cell.titleImageView.image = DotaImageName(@"icon_weixin");
        cell.titleLabel.text = @"微信支付";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 55;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = UIView.new;
    
    view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = [UILabel new];
    
    
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];

        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请选择支付方式" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        label.attributedText = string;
   
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = UIView.new;
    view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    return view;
}
@end
