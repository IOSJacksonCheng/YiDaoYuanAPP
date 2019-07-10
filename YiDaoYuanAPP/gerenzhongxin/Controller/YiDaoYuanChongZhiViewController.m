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

#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
@interface YiDaoYuanChongZhiViewController ()<UITableViewDelegate, UITableViewDataSource, YiDaoYuanCollectionTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickSureButtonDone:(id)sender;
@property (nonatomic, strong) NSMutableArray *itemMutableArray;

@property (nonatomic, assign) BOOL chooseAlipay;

@property (nonatomic, strong) YiDaoYuanCollectionModel *currentModel;
- (IBAction)clickHideButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@end

@implementation YiDaoYuanChongZhiViewController
- (NSMutableArray *)itemMutableArray {
    if (!_itemMutableArray) {
        
        _itemMutableArray = @[].mutableCopy;
        
    }
    return _itemMutableArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self sendGetRequest];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_User_Profile_Coindiscount Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.itemMutableArray = [CSParseManager getYiDaoYuanCollectionModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
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
    
    
    
    self.chooseAlipay = YES;
    self.sureButton.layer.cornerRadius = 5;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"WXpayResult_Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"AlipayResult_Notification" object:nil];
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"充值";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
- (IBAction)clickSureButtonDone:(id)sender {
    
 
    
    
    if (csCharacterIsBlank(self.currentModel.RMB)) {
        CustomWrongMessage(@"请选择要充值的金额");
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"price"] = self.currentModel.RMB;
    para[@"type"] = @"1";
    if (self.chooseAlipay) {
        para[@"pay_type"] = @"3";
        
    } else {
        para[@"pay_type"] = @"4";
        
    }
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_User_Recharge Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            if (!self.chooseAlipay) {
                [self getWeiXinPay:CSGetResult];
                
            } else {
                [self getAlipayPay:CSGetResult];
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
- (void)getAlipayPay:(id)responseObject {
    
    NSString *string = responseObject[@"code"];
    
    NSString *appScheme = @"alisdkdemo";
    
    [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
       
        
    }];
    
}
- (void)getWeiXinPay:(id)responseObject {
    PayReq* wxreq             = [[PayReq alloc] init];
    //                    wxreq.openID              = responseObject[@"params"][@""];
    wxreq.partnerId           = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"partnerid"]];;
    wxreq.prepayId            = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"prepayid"]];
    wxreq.nonceStr            = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"noncestr"]];
    
    UInt32 timeStamp    = [[NSString stringWithFormat:@"%@", responseObject[@"code"][@"timestamp"]] intValue];
    
    wxreq.timeStamp           = timeStamp; //timeStamp
    
    wxreq.package             = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"package"]];
    
    wxreq.sign                = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"sign"]];
    
    if ([WXApi isWXAppInstalled]) {
        CSLog(@"安装了");
    } else {
        CSLog(@"没有安装了");
    }
    
    if ([WXApi sendReq:wxreq]) {
        CSLog(@"微信支付调起成功");
    } else {
        CSLog(@"微信支付调起失败");
    }
    
}
- (void)execute:(NSNotification *)notification {
    if([notification.name isEqualToString:@"AlipayResult_Notification"])
    {
        NSDictionary *result=notification.object;
        if(result)
        {
            int resultStatus = [[result objectForKey:@"resultStatus"]intValue];
            
            if (resultStatus == 9000) {
                
                 [self payResult:YES];
                
                
            } else {
                [self payResult:NO];
            }
            
            
        }
    } else if([notification.name isEqualToString:@"WXpayResult_Notification"])
    {
        [self payResult:[notification.object boolValue]];
    }
}
- (void) payResult:(BOOL)result
{
    
    if (result) {
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
        self.successView.hidden = NO;
        
        self.successLabel.text = [NSString stringWithFormat:@"已为您的账户充值%@易道元",self.currentModel.money];
        [self updateCurrentMoney];
        
        
    } else {
        
        CustomWrongMessage(@"支付失败！");
    }
}
- (void) dealloc
{
    
    
    //注销通知接收
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
    
}
- (void)updateCurrentMoney {
    [CSUtility updateCurrentMoney:^(BOOL updateSuccess) {
        if (updateSuccess) {
            [self.tableView reloadData];
        }
    }];
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
            self.currentModel = model;
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
        if (self.chooseAlipay) {
            cell.chooseImageView.image = DotaImageName(@"icon_xuanze");
        } else {
            cell.chooseImageView.image = DotaImageName(@"icon_weixuanze");
        }
        cell.titleLabel.text = @"支付宝支付";
    } else if (indexPath.row == 1) {
        cell.titleImageView.image = DotaImageName(@"icon_weixing");
        cell.titleLabel.text = @"微信支付";
        if (self.chooseAlipay) {
           cell.chooseImageView.image = DotaImageName(@"icon_weixuanze");
        } else {
              cell.chooseImageView.image = DotaImageName(@"icon_xuanze");
           
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            self.chooseAlipay = YES;
        } else {
            self.chooseAlipay = NO;
        }
        
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 92;
    }
    if (indexPath.section == 1) {
        
        NSInteger count = self.itemMutableArray.count / 3;
        
        if (self.itemMutableArray.count % 3 != 0) {
            count += 1;
        }
        
        return 85 * count + 10 * (count + 1);
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
- (IBAction)clickHideButtonDone:(id)sender {
    
    self.successView.hidden = YES;
}
@end
