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

#import "WuLiuModel.h"
#import "WuLiuSubModel.h"
@interface ShoppingWaitReceiveGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) NSMutableArray *productArray;

@property (nonatomic, strong) NSString *total_price;
@property (nonatomic, strong) NSString *freight;


@property (nonatomic, strong) NSString *order_id;

@property (weak, nonatomic) IBOutlet UIButton *querenshouhuoButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lianxikefuLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lianxikefuWidthConstraint;

- (IBAction)clickLianXiKefuButtonDone:(id)sender;
- (IBAction)clickQueRenShouHuoButtonDone:(id)sender;
@property (nonatomic, strong) WuLiuModel *wuliuModel;
@end

@implementation ShoppingWaitReceiveGoodsViewController
- (WuLiuModel *)wuliuModel {
    if (!_wuliuModel) {
        _wuliuModel = [WuLiuModel new];
    }
    return _wuliuModel;
}
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
            self.wuliuModel.logistics_order = [NSString stringWithFormat:@"%@",CSGetResult[@"logistics_order"]];
            self.wuliuModel.status = [NSString stringWithFormat:@"%@",CSGetResult[@"status"]];
            self.wuliuModel.brand_name = [NSString stringWithFormat:@"%@",CSGetResult[@"brand_name"]];
            self.wuliuModel.data = [CSParseManager getWuLiuSubModelArrayWithResponseObject:CSGetResult[@"data"]];
            [self.listTableView reloadData];
        }else {
//            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
//        CSInternetFailure
    }];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"order_id"] = self.passOrderId;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Order_Details Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
              
                self.addressModel.shipp_name = [NSString stringWithFormat:@"%@",CSGetResult[@"consignee"]];
                
                self.addressModel.shipp_phone = [NSString stringWithFormat:@"%@",CSGetResult[@"recivphone"]];
                
                self.addressModel.shipp_address = [NSString stringWithFormat:@"%@",CSGetResult[@"address"]];
           
            
            self.order_id = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            self.total_price = [NSString stringWithFormat:@"%@",CSGetResult[@"total_price"]];
            self.freight = [NSString stringWithFormat:@"%@",CSGetResult[@"freight"]];
            self.productArray = [CSParseManager getAllSubOrderModelArrayWithResponseObject:CSGetResult[@"goods"]];
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
    
    if (![self.passStatus isEqualToString:@"2"]) {
        self.lianxikefuLeftConstraint.constant = 0;
        self.lianxikefuWidthConstraint.constant = MainScreenWidth;
        self.querenshouhuoButton.hidden = YES;
    }
    
    
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
        if (self.isWuLiu) {
            return 0;
        }
        return 1;
    }
    if (section == 1) {
        if (self.isWuLiu) {
            return 0;
        }
        return 1 + self.productArray.count;
    }
    if (section == 2) {
        if (csCharacterIsBlank(self.wuliuModel.logistics_order)) {
            return 1;
        }
        return 2;
    }
    return self.wuliuModel.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ShoppingAddPersonalAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAddPersonalAddressTableViewCell)];
        cell.model = self.addressModel;
        cell.moreIconImageView.hidden = YES;
        return cell;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ShoppingDetailTopTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailTopTitleTableViewCell)];
            cell.orderLabel.text = [NSString stringWithFormat:@"订单编号:%@",self.order_id];
            
            
            cell.statusLabel.text = [self getStatusTitle];

            return cell;
        }
        ShoppingDetailProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailProductTableViewCell)];
        
        AllOrderModel *model = self.productArray[indexPath.row - 1];
        cell.model = model;
        
        return cell;
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            ShoppingSureOrderMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingSureOrderMoneyTableViewCell)];
            cell.freightLabel.text = [NSString stringWithFormat:@"%@",self.freight];
            cell.totalLabel.text = [NSString stringWithFormat:@"¥%@",self.total_price];

            return cell;
        }
        ShoppingDetailWuLiuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailWuLiuTableViewCell)];
        cell.orderIdLabel.text = [NSString stringWithFormat:@"运单编号：%@",self.wuliuModel.logistics_order];
        cell.statusLabel.text = [NSString stringWithFormat:@"物流状态：%@",[self getStatusTitle:self.wuliuModel.status]];
        cell.laiYuanLabel.text = [NSString stringWithFormat:@"承运来源：%@",self.wuliuModel.brand_name];

        return cell;
    }
    
    WuLiuSubModel *subModel = self.wuliuModel.data[indexPath.row];
    if (indexPath.row == 0) {
        ShoppingDetailWuLiuInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailWuLiuInfoTableViewCell)];
        cell.addressLabel.text = subModel.context;
        cell.timeLabel.text = subModel.time;
        return cell;
    }
    ShoppingDetailWuLiuInfoSecondRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingDetailWuLiuInfoSecondRowTableViewCell)];
    cell.addressLabel.text = subModel.context;
    cell.timeLabel.text = subModel.time;
    return cell;
}
- (NSString *)getStatusTitle:(NSString *)title {
    
    //collected-收件；sending-运送中；delivering-派件中；signed-签收；question-问题件;allograph-代收
    if ([title isEqualToString:@"collected"]) {
        return @"收件";
    }
    if ([title isEqualToString:@"sending"]) {
        return @"运送中";
    }
    if ([title isEqualToString:@"delivering"]) {
        return @"派件中";
    }
    if ([title isEqualToString:@"signed"]) {
        return @"签收";
    }
    if ([title isEqualToString:@"question"]) {
        return @"问题件";
    }
    if ([title isEqualToString:@"allograph"]) {
        return @"代收";
    }
    
    return @"";
}
- (NSString *)getStatusTitle {
    
    //-2 已退款 -1 已取消 0 未支付 1 已支付等待发货 2收货中 3申请退款中 10完成订单
    if ([self.passStatus isEqualToString:@"-2"]) {
        return @"已退款";
    }
    if ([self.passStatus isEqualToString:@"-1"]) {
        return @"已取消";
    }
    if ([self.passStatus isEqualToString:@"0"]) {
        return @"未支付";
    }
    if ([self.passStatus isEqualToString:@"1"]) {
        return @"待发货";
    }
    if ([self.passStatus isEqualToString:@"2"]) {
        return @"待收货";
    }
    if ([self.passStatus isEqualToString:@"3"]) {
        return @"申请退款中";
    }
    if ([self.passStatus isEqualToString:@"10"]) {
        return @"已完成";
    }
    return @"";
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
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
//        
//        
//        ShopSureOrderAddAddressViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShopSureOrderAddAddressViewController"];
//        
//        [self.navigationController pushViewController:new animated:YES];
    }
    
}

- (IBAction)clickLianXiKefuButtonDone:(id)sender {
    
    [CSUtility shoppingGoToKefuController];
}
- (void)sendQueRenSHouHuo {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_affirm_order Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (IBAction)clickQueRenShouHuoButtonDone:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认收货吗？" preferredStyle:UIAlertControllerStyleAlert];
    //2.创建界面上的按钮
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self sendQueRenSHouHuo];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //3.将按钮添加到AlertController中
    [alert addAction:actionNo];
    [alert addAction:actionYes];
    //5.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
@end
