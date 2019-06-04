//
//  SureOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "SureOrderViewController.h"
#import "SureOrderDaShiInfomationTableViewCell.h"
#import "SureOrderCourseTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
#import "SureOrderMoneyTableViewCell.h"
@interface SureOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;
- (IBAction)clickSurePayButtonDone:(id)sender;

@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderDaShiInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderCourseTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderCourseTableViewCell)];
      [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderMoneyTableViewCell)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)configSubViews {
    
    self.surePayButton.layer.cornerRadius = 5;

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
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 4;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SureOrderDaShiInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
            return cell;
        }
        SureOrderCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderCourseTableViewCell)];
        return cell;
    }
    if (indexPath.section == 1) {
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
    SureOrderMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderMoneyTableViewCell)];
  
    if (indexPath.row == 0) {
       
        cell.titleLabel.text = @"原价：200元 ";
    } else if (indexPath.row == 1) {
       
        cell.titleLabel.text = @"易道元抵扣：2元 ";
      
    } else if (indexPath.row == 2) {
       
        cell.titleLabel.text = @"应付：198元 ";
    }
    return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 73;
        }
        return 227.5;
    }
    if (indexPath.section == 1) {

        return 55;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 0;
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
    if (section == 2) {
        label.text = @"支付金额";
    }
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
    if (section == 0) {
        return 0;
    }
    return 50;
}
- (IBAction)clickSurePayButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"SureOrderWriteMessageViewController" sender:self];
}
@end
