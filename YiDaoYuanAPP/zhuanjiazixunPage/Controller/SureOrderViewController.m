//
//  SureOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "SureOrderViewController.h"
#import "SureOrderDaShiInfomationTableViewCell.h"
#import "SureOrderCourseTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
#import "SureOrderMoneyTableViewCell.h"
#import "YiDaoYuanZheKouTableViewCell.h"

#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
#import "SureOrderWriteMessageViewController.h"

@interface SureOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;
- (IBAction)clickSurePayButtonDone:(id)sender;
@property (nonatomic, strong) DaShiOrderInfoModel *infoModel;
@property (nonatomic, assign) NSInteger currentClickIndex;

@property (nonatomic, strong) NSString *beishu;
@end

@implementation SureOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getDashiInfomation];
    
    [self getYiDaoYuanPrice];
}
- (void)getYiDaoYuanPrice {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_coin_multiple Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
           self.beishu =[NSString stringWithFormat:@"%@",CSGetResult[@"multiple"]];
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getDashiInfomation {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_order_msg Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.infoModel = [CSParseManager getSingleDaShiOrderInfoModellWithResponseObject:CSGetResult];
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderDaShiInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderCourseTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderCourseTableViewCell)];
      [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderMoneyTableViewCell)];
    
     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoYuanZheKouTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoYuanZheKouTableViewCell)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (void)configSubViews {
    
    self.surePayButton.layer.cornerRadius = 5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"WXpayResult_Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"AlipayResult_Notification" object:nil];
}

- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"确认订单";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        if (CSIsDev) {
            return 2;
        }
        return 5;
    }
    if (CSIsDev) {
        return 3;
    }
    if (self.currentClickIndex == 2) {
        return 3;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SureOrderDaShiInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
            cell.model = self.infoModel;
            return cell;
        }
        SureOrderCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderCourseTableViewCell)];
        return cell;
    }
    if (indexPath.section == 1) {
        
        if (CSIsDev) {
            
            if (indexPath.row == 1) {
                 YiDaoYuanZheKouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoYuanZheKouTableViewCell)];
                          
                           cell.beishu = self.beishu;
                           
                           return cell;
            }
            
            PayMoneyWaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
                   cell.explainLabel.hidden = YES;
                    
                       cell.titleImageView.image = DotaImageName(@"icon_yidaoyuan");
                       cell.titleLabel.text = @"易道源支付";
                       cell.explainLabel.hidden = NO;
             cell.chooseImageView.image = DotaImageName(@"icon_xuanze");
            return cell;
            
        }
        
        if (indexPath.row == 2) {
            YiDaoYuanZheKouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoYuanZheKouTableViewCell)];
           
            cell.beishu = self.beishu;
            
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
        } else if (indexPath.row == 3) {
            cell.titleImageView.image = DotaImageName(@"icon_zhifubao");
            cell.titleLabel.text = @"支付宝支付";
        } else if (indexPath.row == 4) {
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
    SureOrderMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderMoneyTableViewCell)];
  
    if (indexPath.row == 0) {
       
        cell.titleLabel.text = [NSString stringWithFormat:@"原价：%@元 ",self.infoModel.price];
    } else if (indexPath.row == 1) {
        if (self.currentClickIndex == 2) {
            
            NSString *old = CS_Coin;
            
            if (old.floatValue <= 0) {
                cell.titleLabel.text = @"易道元抵扣：0元";
                
            }else {
                  cell.titleLabel.text = [NSString stringWithFormat:@"易道元抵扣：%d元 ",old.intValue / self.beishu.intValue];
            }
            
           
        } else {
            cell.titleLabel.text = [NSString stringWithFormat:@"应付：%@元 ",self.infoModel.price];

        }
      
    } else if (indexPath.row == 2) {
       
        NSString *old = CS_Coin;
       
        int dikou = 0;

        if (!csCharacterIsBlank(self.beishu)) {
           
            dikou = old.intValue / self.beishu.intValue;

        }
        
        
        float yingfu = self.infoModel.price.floatValue - dikou;
        
        if (yingfu <= 0) {
            yingfu = 0;
        }
        cell.titleLabel.text = [NSString stringWithFormat:@"应付：%.1f元 ",yingfu];
    }
    return cell;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        if (CSIsDev) {
            self.currentClickIndex = 2;
            [self.tableView reloadData];
            return;
        }
        
        self.currentClickIndex = indexPath.row + 1;
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 73;
        }
        return 237;
    }
    if (indexPath.section == 1) {
        
        if (CSIsDev) {
            if (indexPath.row == 1) {
                return 75;
            }
        }
        if (indexPath.row == 2) {
            return 75;
        }
        return 55;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 0;
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
    if (section == 2) {
        label.text = @"支付金额";
    }
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
    if (section == 0) {
        return 0;
    }
    return 50;
}
- (IBAction)clickSurePayButtonDone:(id)sender {
    [self payMoneyRequest];
}

#pragma mark -- 支付
- (void)payMoneyWithOrderId:(NSString *)orderId {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = orderId;
    if (self.currentClickIndex == 4) {
 para[@"payType"] = @"3";
        
    } else if (self.currentClickIndex == 5) {
        para[@"payType"] = @"4";
    } else {
        para[@"payType"] = [NSString stringWithFormat:@"%ld",self.currentClickIndex];
    }
   
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
        
        
    } else if (self.currentClickIndex == 4) {
        
        [self getAlipayPay:result];
    } else if (self.currentClickIndex == 5) {
        
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
    
    [self performSegueWithIdentifier:@"SureOrderWriteMessageViewController" sender:self];
}
- (void)payMoneyRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
   
    
    if (self.currentClickIndex == 4) {
        para[@"payType"] = @"3";
        
    } else if (self.currentClickIndex == 5) {
        para[@"payType"] = @"4";
    } else {
        para[@"payType"] = [NSString stringWithFormat:@"%ld",self.currentClickIndex];
    }
    
    para[@"orderType"] = @"0";
    
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SureOrderWriteMessageViewController"]) {
        SureOrderWriteMessageViewController *new = segue.destinationViewController;
        new.infoModel = self.infoModel;
        
    }
}
@end
