//
//  PlaySurePayMoneyViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlaySurePayMoneyViewController.h"

#import "PlaySurePayMoneyTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
@interface PlaySurePayMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>
- (IBAction)clickSureButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation PlaySurePayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlaySurePayMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
  
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
   
    F3f3f3NavigationBarColor
    
    self.title = @"确认支付";
}

- (IBAction)clickSureButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"PlaySurePayMoneyViewController" sender:self];
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
       
        if (indexPath.row == 0) {
            PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
            cell.buttonView.hidden = YES;
            cell.hideView.hidden = YES;
            cell.explainLabel.hidden = YES;
            cell.csTitleLabel.text = @"阴历生日";
            cell.csImageView.image = DotaImageName(@"icon_1_birthday");
             return cell;
        } else if (indexPath.row == 1) {
            PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
            
            cell.hideView.hidden = YES;
            cell.explainLabel.hidden = YES;
            cell.csTitleLabel.text = @"性别";
            cell.csImageView.image = DotaImageName(@"icon_2_sex");
            cell.buttonView.hidden = NO;
             return cell;
        } else if (indexPath.row == 2) {
            PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
            cell.buttonView.hidden = YES;
            cell.hideView.hidden = YES;
            cell.explainLabel.hidden = YES;
            cell.csTitleLabel.text = @"出生地";
            cell.csImageView.image = DotaImageName(@"icon_3_site");
             return cell;
        }
        PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
        cell.buttonView.hidden = YES;
        
            cell.csTitleLabel.text = @"报数";
            cell.csImageView.image = DotaImageName(@"icon_4_number");
            cell.hideView.hidden = NO;
            cell.explainLabel.hidden = NO;
        
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 55;
    }
    if (indexPath.row == 3) {
        return 87.5;
    }
    return 47;
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
