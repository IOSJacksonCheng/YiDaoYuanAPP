//
//  YuEChongZhiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YuEChongZhiViewController.h"

#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
@interface YuEChongZhiViewController ()
/** 10 */
@property (weak, nonatomic) IBOutlet UIButton *button1;
/** 50 */
@property (weak, nonatomic) IBOutlet UIButton *button2;
/** 100 */
@property (weak, nonatomic) IBOutlet UIButton *button3;
/** 300 */
@property (weak, nonatomic) IBOutlet UIButton *button4;
/** 500 */
@property (weak, nonatomic) IBOutlet UIButton *button5;
/** 1000 */
@property (weak, nonatomic) IBOutlet UIButton *button6;
/** 3000 */
@property (weak, nonatomic) IBOutlet UIButton *button7;
/** 10000 */
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;
- (IBAction)clickMoneyButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
- (IBAction)clickSurePayButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *remindView;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
- (IBAction)clickHideButtonDone:(id)sender;

@property (nonatomic, assign) int recordMoney;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;

@property (weak, nonatomic) IBOutlet UIView *zhifubaoView;
@property (weak, nonatomic) IBOutlet UIView *weixinView;
@property (weak, nonatomic) IBOutlet UIImageView *zhifubaoChooseView;

@property (weak, nonatomic) IBOutlet UIImageView *weixinChooseView;
@property (nonatomic, assign) BOOL chooseAlipay;
@end

@implementation YuEChongZhiViewController

- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.yueLabel.text = [NSString stringWithFormat:@"%@元",CS_Balance];
    
}
- (void)clickZhifubao {
    self.chooseAlipay = YES;
    self.weixinChooseView.image = DotaImageName(@"icon_weixuanzhong");
    self.zhifubaoChooseView.image = DotaImageName(@"icon_xuanzhong");

}
- (void)clickweixin {
    
    self.chooseAlipay = NO;

    self.weixinChooseView.image = DotaImageName(@"icon_xuanzhong");
    self.zhifubaoChooseView.image = DotaImageName(@"icon_weixuanzhong");

}
- (void)configSubViews {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"WXpayResult_Notification" object:nil];
    
    self.chooseAlipay = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickZhifubao)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.zhifubaoView addGestureRecognizer:tap];
   
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickweixin)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [self.weixinView addGestureRecognizer:tap1];
    
    self.recordMoney = 0;
    self.successLabel.text = [NSString stringWithFormat:@"已为您的账户充值%d元",self.recordMoney];
    
    self.successView.hidden = YES;
    self.remindView.layer.cornerRadius = 5;
    self.remindView.layer.masksToBounds = YES;
    
    [self changeButtonStatus:1];
    
    
    self.surePayButton.layer.cornerRadius = 5;
    
    self.button1.layer.borderWidth = 1;
    self.button1.layer.borderColor = csBlueColor.CGColor;
    self.button1.layer.cornerRadius = 5;
    
    self.button2.layer.borderWidth = 1;
    self.button2.layer.borderColor = csBlueColor.CGColor;
    self.button2.layer.cornerRadius = 5;
    
    self.button3.layer.borderWidth = 1;
    self.button3.layer.borderColor = csBlueColor.CGColor;
    self.button3.layer.cornerRadius = 5;
    
    self.button4.layer.borderWidth = 1;
    self.button4.layer.borderColor = csBlueColor.CGColor;
    self.button4.layer.cornerRadius = 5;
    
    self.button5.layer.borderWidth = 1;
    self.button5.layer.borderColor = csBlueColor.CGColor;
    self.button5.layer.cornerRadius = 5;
    
    self.button6.layer.borderWidth = 1;
    self.button6.layer.borderColor = csBlueColor.CGColor;
    self.button6.layer.cornerRadius = 5;
    
    self.button7.layer.borderWidth = 1;
    self.button7.layer.borderColor = csBlueColor.CGColor;
    self.button7.layer.cornerRadius = 5;
    
    self.button8.layer.borderWidth = 1;
    self.button8.layer.borderColor = csBlueColor.CGColor;
    self.button8.layer.cornerRadius = 5;
    
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"充值";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (IBAction)clickMoneyButtonDone:(UIButton *)sender {
    
    [self changeButtonStatus:sender.tag];
    
}

- (IBAction)clickSurePayButtonDone:(UIButton *)sender {
    
    if (self.recordMoney == 0) {
        CustomWrongMessage(@"请选择要充值的金额");
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"price"] = [NSString stringWithFormat:@"%d",self.recordMoney];
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
        
        int resultStatus = [[resultDic objectForKey:@"resultStatus"]intValue];
        
        if (resultStatus == 9000) {
            
            self.successView.hidden = NO;
            
            self.successLabel.text = [NSString stringWithFormat:@"已为您的账户充值%d元",self.recordMoney];
            [self updateCurrentMoney];
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
- (void)changeButtonStatus:(NSInteger)tag {
    if (tag == 1) {
        self.recordMoney = 10;
        self.button1.backgroundColor = csBlueColor;
        [self.button1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button1.backgroundColor = UIColor.whiteColor;
        [self.button1 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 2) {
        self.recordMoney = 50;

        self.button2.backgroundColor = csBlueColor;
        [self.button2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button2.backgroundColor = UIColor.whiteColor;
        [self.button2 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 3) {
        self.recordMoney = 100;

        self.button3.backgroundColor = csBlueColor;
        [self.button3 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button3.backgroundColor = UIColor.whiteColor;
        [self.button3 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 4) {
        self.recordMoney = 300;

        self.button4.backgroundColor = csBlueColor;
        [self.button4 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button4.backgroundColor = UIColor.whiteColor;
        [self.button4 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 5) {
        self.recordMoney = 500;

        self.button5.backgroundColor = csBlueColor;
        [self.button5 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button5.backgroundColor = UIColor.whiteColor;
        [self.button5 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 6) {
        self.recordMoney = 1000;

        self.button6.backgroundColor = csBlueColor;
        [self.button6 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button6.backgroundColor = UIColor.whiteColor;
        [self.button6 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 7) {
        
        self.recordMoney = 3000;

        self.button7.backgroundColor = csBlueColor;
        [self.button7 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button7.backgroundColor = UIColor.whiteColor;
        [self.button7 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 8) {
        self.recordMoney = 10000;

        self.button8.backgroundColor = csBlueColor;
        [self.button8 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button8.backgroundColor = UIColor.whiteColor;
        [self.button8 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
}

- (IBAction)clickHideButtonDone:(id)sender {
    
    self.successView.hidden = YES;
}

- (void)execute:(NSNotification *)notification {
    if([notification.name isEqualToString:@"WXpayResult_Notification"])
    {
        [self payResult:[notification.object boolValue]];
    }
}
- (void) payResult:(BOOL)result
{
    
    if (result) {
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
        self.successView.hidden = NO;

 self.successLabel.text = [NSString stringWithFormat:@"已为您的账户充值%d元",self.recordMoney];
        
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
             self.yueLabel.text = [NSString stringWithFormat:@"%@元",CS_Balance];
        }
    }];
}
@end
