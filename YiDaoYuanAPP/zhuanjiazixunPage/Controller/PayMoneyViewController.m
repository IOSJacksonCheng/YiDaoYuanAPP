//
//  PayMoneyViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "PayMoneyTitleTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
@interface PayMoneyViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger currentClickIndex;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPeopleLabel;
- (IBAction)clickSurePayMoneyDone:(id)sender;

@end

@implementation PayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.totalMoneyLabel.text = self.dashangqian;
    self.totalPeopleLabel.text = self.dashangren;
    [self.tableView reloadData];
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyTitleTableViewCell)];
    
     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
      self.surePayButton.layer.cornerRadius = 5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"WXpayResult_Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"AlipayResult_Notification" object:nil];
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"赞赏";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
       
        PayMoneyTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PayMoneyTitleTableViewCell)];
        [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.masterIcon] placeholderImage:CSUserImagePlaceHolder];
        cell.nameLabel.text = self.masterName;
        cell.moneyLabel.text = [NSString stringWithFormat:@"¥%@",self.money];
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
    if (self.currentClickIndex == indexPath.row + 1) {
        cell.chooseImageView.image = DotaImageName(@"icon_xuanze");
    } else {
        cell.chooseImageView.image = DotaImageName(@"icon_weixuanze");
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        self.currentClickIndex = indexPath.row + 1;
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 88;
    }
    return 55;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
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
#pragma mark -- 支付
- (void)payMoneyWithOrderId:(NSString *)orderId {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = orderId;
    para[@"payType"] = [NSString stringWithFormat:@"%ld",self.currentClickIndex];
    para[@"orderType"] = @"1";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Index_Createpay Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self configMoneyWith:CSGetResult];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configMoneyWith:(id)result {
    
    if (self.currentClickIndex == 1) {
        
        
        
        [[NSUserDefaults standardUserDefaults] setValue:result[@"balance"] forKey:@"CS_Balance"];
        
        [self goToSuccessViewController];
        
    } else if (self.currentClickIndex == 2) {
        [[NSUserDefaults standardUserDefaults] setValue:result[@"balance"] forKey:@"CS_Coin"];
        
        [self goToSuccessViewController];
        
        
    } else if (self.currentClickIndex == 3) {
        
        [self getAlipayPay:result];
    } else if (self.currentClickIndex == 4) {
        
        [self getWeiXinPay:result];
        
        
    }
    
    
}

- (void)getAlipayPay:(id)responseObject {
    
    NSString *string = responseObject[@"code"];
    
    NSString *appScheme = @"alisdkdemo";
    
    [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        int resultStatus = [[resultDic objectForKey:@"resultStatus"]intValue];
        
        if (resultStatus == 9000) {
            
            [self goToSuccessViewController];
            
        }
        
        CSLog(@"reslut = %@",resultDic);
        
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
        
        [self goToSuccessViewController];
        
        
    } else {
        
        CustomWrongMessage(@"支付失败！");
    }
}
- (void) dealloc
{
    
    
    //注销通知接收
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
    
}
- (void)goToSuccessViewController {
    
    CustomWrongMessage(@"打赏成功！");
}
- (IBAction)clickSurePayMoneyDone:(id)sender {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.orderId;
    para[@"payType"] = [NSString stringWithFormat:@"%ld",self.currentClickIndex];
    para[@"orderType"] = @"5";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Index_Createpay Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self configMoneyWith:CSGetResult];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
@end
