//
//  PayMoneyViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "PayMoneyTitleTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
@interface PayMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation PayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyTitleTableViewCell)];
    
     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
      self.surePayButton.layer.cornerRadius = 5;
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"赞赏";
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
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
       
        PayMoneyTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PayMoneyTitleTableViewCell)];
      
        return cell;
        
    }
    
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
    if (indexPath.section == 0) {
        return 88;
    }
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.whiteColor;
    UILabel *label = UILabel.new;
    label.text = @"支付方式";
    label.font = csCharacterFont_18;
    label.textColor = cs333333Color;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.centerY.mas_equalTo(0);
    }];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 0;
}
@end
