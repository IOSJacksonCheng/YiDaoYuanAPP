//
//  ShoppingHaveFinishedViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingHaveFinishedViewController.h"


#import "ShoppingDetailTopTitleTableViewCell.h"
#import "ShoppingDetailWuLiuTableViewCell.h"
#import "ShoppingDetailWuLiuInfoTableViewCell.h"
#import "ShoppingDetailWuLiuInfoSecondRowTableViewCell.h"
#import "ShoppingAddPersonalAddressTableViewCell.h"
#import "ShoppingSureOrderMoneyTableViewCell.h"
#import "ShoppingDetailProductTableViewCell.h"

#import "ShopSureOrderAddAddressViewController.h"

#import "AddressModel.h"
@interface ShoppingHaveFinishedViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) NSMutableArray *productArray;

@property (nonatomic, strong) NSString *total_price;
@property (nonatomic, strong) NSString *freight;

@property (nonatomic, strong) NSString *pay_price;

@property (nonatomic, strong) NSString *order_id;
@end

@implementation ShoppingHaveFinishedViewController
- (AddressModel *)addressModel {
    if (!_addressModel) {
        _addressModel = [AddressModel new ];
    }
    return _addressModel;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.productArray = @[].mutableCopy;
    
    [self sendGetRequest];
    
    [self getWuLiuInfomation];
}
- (void)getWuLiuInfomation {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"order_id"] = self.passOrderId;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_Logistics Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"order_id"] = self.passOrderId;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_Affirm Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            if (!csCharacterIsBlank(CSGetResult[@"address"])) {
                self.addressModel.shipp_id = [NSString stringWithFormat:@"%@",CSGetResult[@"address"][@"shipp_id"]];
                self.addressModel.shipp_name = [NSString stringWithFormat:@"%@",CSGetResult[@"address"][@"shipp_name"]];
                
                self.addressModel.shipp_phone = [NSString stringWithFormat:@"%@",CSGetResult[@"address"][@"shipp_phone"]];
                
                self.addressModel.shipp_address = [NSString stringWithFormat:@"%@",CSGetResult[@"address"][@"shipp_address"]];
            }
            
            self.order_id = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            self.total_price = [NSString stringWithFormat:@"%@",CSGetResult[@"total_price"]];
            self.freight = [NSString stringWithFormat:@"%@",CSGetResult[@"freight"]];
            self.pay_price = [NSString stringWithFormat:@"%@",CSGetResult[@"pay_price"]];
            self.productArray = [CSParseManager getGoodsModelArrayWithResponseObject:CSGetResult[@"goods"]];
            [self.listTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
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
