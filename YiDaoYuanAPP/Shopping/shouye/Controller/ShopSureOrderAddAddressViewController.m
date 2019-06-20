//
//  ShopSureOrderAddAddressViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopSureOrderAddAddressViewController.h"

#import "ShoppingAddressTableViewCell.h"
@interface ShopSureOrderAddAddressViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
- (IBAction)clickAddressButtonDone:(id)sender;

@end

@implementation ShopSureOrderAddAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}
- (void)configTableView {
    
    self.addressTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.addressTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAddressTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAddressTableViewCell)];
  
    
    
    
    
}

- (void)configSubViews {
    
    self.addressButton.layer.cornerRadius = 7;
}

- (void)configNavigationBar {
    
    
    self.title = @"收货地址";
    
    WhiteNavigationBarColor
    
}

- (IBAction)clickAddressButtonDone:(id)sender {
     [self performSegueWithIdentifier:@"NewAddressViewController" sender:self];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAddressTableViewCell)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}
@end
