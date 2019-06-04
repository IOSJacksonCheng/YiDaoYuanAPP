//
//  YiDaoYuanChongZhiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoYuanChongZhiViewController.h"

#import "YiDaoYuanCollectionTableViewCell.h"
#import "YiDaoYuanChongZhiTitleTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
#import "YiDaoYuanCollectionModel.h"
@interface YiDaoYuanChongZhiViewController ()<UITableViewDelegate, UITableViewDataSource, YiDaoYuanCollectionTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickSureButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (nonatomic, strong) NSMutableArray *itemMutableArray;
@end

@implementation YiDaoYuanChongZhiViewController
- (NSMutableArray *)itemMutableArray {
    if (!_itemMutableArray) {
        
        _itemMutableArray = @[].mutableCopy;
        
        YiDaoYuanCollectionModel *model1 = [YiDaoYuanCollectionModel new];
        model1.choose = YES;
        model1.money = @"10";
        model1.RMB = @"10";
        model1.showSales = NO;
        model1.sales = @"9.0";
        [_itemMutableArray addObject:model1];
        
        YiDaoYuanCollectionModel *model2 = [YiDaoYuanCollectionModel new];
        model2.choose = NO;
        model2.money = @"10";
        model2.RMB = @"10";
        model2.showSales = NO;
        model2.sales = @"9.0";
        [_itemMutableArray addObject:model2];
        
        YiDaoYuanCollectionModel *model3 = [YiDaoYuanCollectionModel new];
        model3.choose = NO;
        model3.money = @"10";
        model3.RMB = @"10";
        model3.showSales = YES;
        model3.sales = @"9.0";
        [_itemMutableArray addObject:model3];
        
        YiDaoYuanCollectionModel *model4 = [YiDaoYuanCollectionModel new];
        model4.choose = NO;
        model4.money = @"10";
        model4.RMB = @"10";
        model4.showSales = YES;
        model4.sales = @"9.0";
        [_itemMutableArray addObject:model4];
        
        YiDaoYuanCollectionModel *model5 = [YiDaoYuanCollectionModel new];
        model5.choose = NO;
        model5.money = @"10";
        model5.RMB = @"10";
        model5.showSales = YES;
        model5.sales = @"9.0";
        [_itemMutableArray addObject:model5];
        
        
        
        YiDaoYuanCollectionModel *model6 = [YiDaoYuanCollectionModel new];
        model6.choose = NO;
        model6.money = @"10";
        model6.RMB = @"1000";
        model6.showSales = YES;
        model6.sales = @"9.0";
        [_itemMutableArray addObject:model6];
        
        YiDaoYuanCollectionModel *model7 = [YiDaoYuanCollectionModel new];
        model7.choose = NO;
        model7.money = @"10";
        model7.RMB = @"10";
        model7.showSales = YES;
        model7.sales = @"9.0";
        [_itemMutableArray addObject:model7];
        
        YiDaoYuanCollectionModel *model8 = [YiDaoYuanCollectionModel new];
        model8.choose = NO;
        model8.money = @"10";
        model8.RMB = @"10";
        model8.showSales = YES;
        model8.sales = @"9.0";
        [_itemMutableArray addObject:model8];
        
        YiDaoYuanCollectionModel *model9 = [YiDaoYuanCollectionModel new];
        model9.choose = NO;
        model9.money = @"10";
        model9.RMB = @"10";
        model9.showSales = YES;
        model9.sales = @"9.0";
        [_itemMutableArray addObject:model9];
        
        YiDaoYuanCollectionModel *model10 = [YiDaoYuanCollectionModel new];
        model10.choose = NO;
        model10.money = @"10";
        model10.RMB = @"1000";
        model10.showSales = YES;
        model10.sales = @"9.0";
        [_itemMutableArray addObject:model10];
        
    }
    return _itemMutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoYuanCollectionTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoYuanCollectionTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoYuanChongZhiTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoYuanChongZhiTitleTableViewCell)];
    
        [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    
}

- (void)configSubViews {
    self.successView.hidden = YES;
    self.successView.layer.cornerRadius = 5;
    self.successView.layer.masksToBounds = YES;
    
    
    
    
    self.sureButton.layer.cornerRadius = 5;
    
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"充值";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
- (IBAction)clickSureButtonDone:(id)sender {
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 2;
    }
    return 1;
}
- (void)clickItemWithRow:(NSInteger)row {
    for (int i = 0; i < self.itemMutableArray.count; i ++) {
        YiDaoYuanCollectionModel *model = self.itemMutableArray[i];
        if (i == row) {
            model.choose = YES;
        } else {
            model.choose = NO;
        }
    }
    [self.tableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YiDaoYuanChongZhiTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoYuanChongZhiTitleTableViewCell)];
        return cell;
    }
    if (indexPath.section == 1) {
        YiDaoYuanCollectionTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoYuanCollectionTableViewCell)];
        cell.csDelegate = self;
        cell.titleArray = self.itemMutableArray;
        return cell;
    }
    
    PayMoneyWaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    cell.explainLabel.hidden = YES;
    if (indexPath.row == 0) {
        cell.titleImageView.image = DotaImageName(@"icon_zhifubao");
        cell.titleLabel.text = @"支付宝支付";
    } else if (indexPath.row == 1) {
        cell.titleImageView.image = DotaImageName(@"icon_weixing");
        cell.titleLabel.text = @"微信支付";
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 92;
    }
    if (indexPath.section == 1) {
        return 85 * 4 + 10 * 5;
    }
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
    if (section == 1) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"选择购买数量" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        label.attributedText = string;
    } else if (section == 2) {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请选择支付方式" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        label.attributedText = string;
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 50;
}
@end
