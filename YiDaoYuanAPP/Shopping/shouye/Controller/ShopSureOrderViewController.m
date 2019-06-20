//
//  ShopSureOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopSureOrderViewController.h"

#import "ShoppingSureOrderMoneyTableViewCell.h"
#import "ShoppingSureOrderProductTableViewCell.h"
#import "ShoppingAddPersonalAddressTableViewCell.h"
@interface ShopSureOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)clickSurePayButtonDone:(id)sender;

@end

@implementation ShopSureOrderViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}
- (void)configTableView {
    
    self.productTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingSureOrderMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingSureOrderProductTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingSureOrderProductTableViewCell)];

    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAddPersonalAddressTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];

    

    
}

- (void)configSubViews {
   
    
}

- (void)configNavigationBar {
    
    
    self.title = @"确认订单";
    
    WhiteNavigationBarColor
    
}


- (IBAction)clickSurePayButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"ShopSureOrderPayMoneyWayViewController" sender:self];
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ShoppingAddPersonalAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];
        return cell;
    } else if (indexPath.row == 1) {
        ShoppingSureOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingSureOrderProductTableViewCell)];
        return cell;
    }
    ShoppingSureOrderMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
        return 107;
    }else if (indexPath.row == 1) {
        return 128;
        
    }
    return 96;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ShopSureOrderAddAddressViewController" sender:self];
    }
}
@end
