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
#import "NoAddressTableViewCell.h"

#import "ShopSureOrderPayMoneyWayViewController.h"
#import "ShopSureOrderAddAddressViewController.h"
@interface ShopSureOrderViewController ()<UITableViewDelegate, UITableViewDataSource, ShopSureOrderAddAddressViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)clickSurePayButtonDone:(id)sender;
@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) NSMutableArray *productArray;

@property (nonatomic, strong) NSString *total_price;
@property (nonatomic, strong) NSString *freight;

@property (nonatomic, strong) NSString *pay_price;

@property (nonatomic, strong) NSString *order_id;
@property (weak, nonatomic) IBOutlet UILabel *shouldPayLabel;
@property (nonatomic, strong) NSString *recordMoneyId;
@end

@implementation ShopSureOrderViewController
- (AddressModel *)addressModel {
    if (!_addressModel) {
        _addressModel = [AddressModel new ];
    }
    return _addressModel;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.productArray = @[].mutableCopy;
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self sendGetRequest];
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
            self.shouldPayLabel.text = [NSString stringWithFormat:@"应付:¥%@",self.pay_price];
            self.productArray = [CSParseManager getGoodsModelArrayWithResponseObject:CSGetResult[@"goods"]];
            [self.productTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    self.productTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingSureOrderMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingSureOrderProductTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingSureOrderProductTableViewCell)];

    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAddPersonalAddressTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];

    
 [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(NoAddressTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(NoAddressTableViewCell)];
    
}

- (void)configSubViews {
   
    
}

- (void)configNavigationBar {
    
    
    self.title = @"确认订单";
    
    WhiteNavigationBarColor
    
}


- (IBAction)clickSurePayButtonDone:(id)sender {
    
    if (csCharacterIsBlank(self.addressModel.shipp_id)) {
        CustomWrongMessage(@"选择收获地址");
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"shipp_id"] = self.addressModel.shipp_id;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Cart_Save Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.recordMoneyId = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            
            
            [self performSegueWithIdentifier:@"ShopSureOrderPayMoneyWayViewController" sender:self];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.productArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (csCharacterIsBlank(self.addressModel.shipp_id)) {
            NoAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NoAddressTableViewCell) forIndexPath:indexPath];
            return cell;
        }
        ShoppingAddPersonalAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];
        cell.model = self.addressModel;
        return cell;
        
    } else if (indexPath.section == 1) {
        
        ShoppingSureOrderProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingSureOrderProductTableViewCell)];
        GoodsModel *model = self.productArray[indexPath.row];
        
        cell.model = model;
        
        return cell;
        
    }
   
    ShoppingSureOrderMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
    cell.freightLabel.text = self.freight;
    cell.totalLabel.text = [NSString stringWithFormat:@"¥%@",self.total_price];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        if (csCharacterIsBlank(self.addressModel.shipp_id)) {
           
            return 45;
        }
        return 107;
    }else if (indexPath.section == 1) {
        return 128;
        
    }
    return 96;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"ShopSureOrderAddAddressViewController" sender:self];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShopSureOrderPayMoneyWayViewController"]) {
        ShopSureOrderPayMoneyWayViewController *new = segue.destinationViewController;
        new.passOrderId = self.recordMoneyId;
        new.passOrderType = @"4";
        
    }else if ([segue.identifier isEqualToString:@"ShopSureOrderAddAddressViewController"]) {
        ShopSureOrderAddAddressViewController *new = segue.destinationViewController;
        new.csDelegate = self;
    }
}
- (void)clickAddressModel:(AddressModel *)model {
    self.addressModel = model;
    [self.productTableView reloadData];
}
@end
