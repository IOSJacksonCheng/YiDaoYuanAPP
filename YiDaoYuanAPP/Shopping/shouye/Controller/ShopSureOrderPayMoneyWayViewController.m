//
//  ShopSureOrderPayMoneyWayViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopSureOrderPayMoneyWayViewController.h"

#import "PayMoneyWaysTableViewCell.h"

#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>

@interface ShopSureOrderPayMoneyWayViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *moneyTableView;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickSureButtonDone:(id)sender;

@property (nonatomic, assign) int currentClickIndex;
@end

@implementation ShopSureOrderPayMoneyWayViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self.moneyTableView reloadData];
}
- (void)configTableView {
    
    self.moneyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.moneyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.moneyTableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    
    
    
    
    
}

- (void)configSubViews {
    
    self.sureButton.layer.cornerRadius = 5;
    self.currentClickIndex = 0;
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"WXpayResult_Notification" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"AlipayResult_Notification" object:nil];
}

- (void)configNavigationBar {
    
    
    self.title = @"确认订单";
    
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
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
    if (self.currentClickIndex - 1 == indexPath.row) {
          cell.chooseImageView.image = DotaImageName(@"icon_xuanze");
       
    } else {
      
 cell.chooseImageView.image = DotaImageName(@"icon_weixuanze");
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentClickIndex = (int)indexPath.row + 1;
    
    [self.moneyTableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
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

        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"请选择支付方式" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        label.attributedText = string;
   
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = UIView.new;
    view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    return view;
}
- (IBAction)clickSureButtonDone:(id)sender {
    
    if (!csCharacterIsBlank(self.passVideoId)) {
        
        NSMutableDictionary *para = @{}.mutableCopy;
        para[@"id"] = self.passVideoId;
        para[@"payType"] = [NSString stringWithFormat:@"%d",self.currentClickIndex];
        
        [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Course_Order Pameters:para success:^(id  _Nonnull responseObject) {
            
            if (CSInternetRequestSuccessful) {
                [self configMoneyWith:CSGetResult];
            }else {
                CSShowWrongMessage
            }
        } failure:^(NSError * _Nonnull error) {
            CSInternetFailure
        }];
        
        
        return;
    }
    
}
- (void)configMoneyWith:(id)result {
    
    if (self.currentClickIndex == 1) {
        
        
        
        [[NSUserDefaults standardUserDefaults] setValue:result[@"balance"] forKey:@"CS_Balance"];

        [self.csDelegate successGoBack];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } else if (self.currentClickIndex == 2) {
        [[NSUserDefaults standardUserDefaults] setValue:result[@"balance"] forKey:@"CS_Coin"];
        [self.csDelegate successGoBack];
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
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
            
            [self.csDelegate successGoBack];
            [self.navigationController popViewControllerAnimated:YES];
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
        
        [self.csDelegate successGoBack];
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        CustomWrongMessage(@"支付失败！");
    }
}
- (void) dealloc
{
    
    
    //注销通知接收
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
    
}
@end
