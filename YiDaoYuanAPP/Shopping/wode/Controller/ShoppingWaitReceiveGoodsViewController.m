//
//  ShoppingWaitReceiveGoodsViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingWaitReceiveGoodsViewController.h"
#import "ShoppingDetailTopTitleTableViewCell.h"
#import "ShoppingDetailWuLiuTableViewCell.h"
#import "ShoppingDetailWuLiuInfoTableViewCell.h"
#import "ShoppingDetailWuLiuInfoSecondRowTableViewCell.h"
#import "ShoppingAddPersonalAddressTableViewCell.h"
#import "ShoppingSureOrderMoneyTableViewCell.h"
#import "ShoppingDetailProductTableViewCell.h"
#import "ShopSureOrderAddAddressViewController.h"
@interface ShoppingWaitReceiveGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ShoppingWaitReceiveGoodsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingDetailTopTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingDetailTopTitleTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingDetailProductTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingDetailProductTableViewCell)];
    
    
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingDetailWuLiuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingDetailWuLiuTableViewCell)];
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingDetailWuLiuInfoTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingDetailWuLiuInfoTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingDetailWuLiuInfoSecondRowTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingDetailWuLiuInfoSecondRowTableViewCell)];
    
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAddPersonalAddressTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingSureOrderMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"订单详情";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 2;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ShoppingAddPersonalAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ShoppingDetailTopTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailTopTitleTableViewCell)];
            return cell;
        }
        ShoppingDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailProductTableViewCell)];
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ShoppingSureOrderMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
            return cell;
        }
        ShoppingDetailWuLiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailWuLiuTableViewCell)];
        return cell;
    }
    
    
    if (indexPath.row == 0) {
        ShoppingDetailWuLiuInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailWuLiuInfoTableViewCell)];
        return cell;
    }
    ShoppingDetailWuLiuInfoSecondRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailWuLiuInfoSecondRowTableViewCell)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        return 107;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 45;
        }
        return 109;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
            return 96;
        }
        
        return 128;
    }
    
    
    
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
        
        
        
        
        ShopSureOrderAddAddressViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShopSureOrderAddAddressViewController"];
        
        [self.navigationController pushViewController:new animated:YES];
    }
    
}

@end
