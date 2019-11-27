//
//  CSAppPayTools.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/10/18.
//  Copyright © 2019 Jackson cheng. All rights reserved.
//

#import "CSAppPayTools.h"


@interface CSAppPayTools()<PKPaymentAuthorizationViewControllerDelegate>


@end
@implementation CSAppPayTools
+ (BOOL)isValidForApplyPay {
    
    if (![PKPaymentAuthorizationViewController class] || ![PKPaymentAuthorizationViewController canMakePayments]) {
        CustomWrongMessage(@"操作系统不支持ApplePay，请升级至9.0以上版本，且iPhone6以上设备才支持");
        return NO;
    }

    //检查用户是否可进行某种卡的支付，是否支持Amex、MasterCard、Visa与银联四种卡，根据自己项目的需要进行检测
    
   NSArray *supportedNetworks = @[PKPaymentNetworkAmex,PKPaymentNetworkMasterCard,PKPaymentNetworkVisa,PKPaymentNetworkChinaUnionPay];
           
           if (![PKPaymentAuthorizationViewController canMakePaymentsUsingNetworks:supportedNetworks]) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"没有绑定支付卡，请先绑定支付卡" preferredStyle:UIAlertControllerStyleAlert];
                  //2.创建界面上的按钮
                  UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                      [[self alloc] jumpAddBank];
                  }];
                  UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                      
                  }];
                  //3.将按钮添加到AlertController中
                  [alert addAction:actionNo];
                  [alert addAction:actionYes];
                  //5.显示AlertController
                  [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
               return NO;
           }
    
    return YES;
}
- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(nonnull PKPayment *)payment handler:(nonnull void (^)(PKPaymentAuthorizationResult * _Nonnull))completion API_AVAILABLE(ios(11.0)){
    
    
    
    PKPaymentToken *payToken = payment.token;
    
    //支付凭据，发给服务端进行验证支付是否真实有效

//    PKContact *billingContact = payment.billingContact;

    //等待服务器返回结果后再进行系统block调用

 
    CSLog(@"%@", payToken);
    
}
- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
   
    [controller dismissViewControllerAnimated:YES completion:nil];
}

+ (void)beginBuyWithTItle:(NSString *)productTitle WithMoney:(NSString *)money WithDelegate:(id<PKPaymentAuthorizationViewControllerDelegate>)delegate{
    
    PKPaymentRequest *request = [[PKPaymentRequest alloc] init];
    
    request.merchantIdentifier = @"merchant.com.normal.yidaoyuan";
    
    request.countryCode = @"CN";
    
    request.currencyCode = @"CNY";
    
    request.supportedNetworks = @[PKPaymentNetworkChinaUnionPay, PKPaymentNetworkVisa];
    
    request.merchantCapabilities = PKMerchantCapability3DS | PKMerchantCapabilityEMV;
    
    
    NSDecimalNumber *price=[NSDecimalNumber decimalNumberWithString:money];
    
    PKPaymentSummaryItem *item=[PKPaymentSummaryItem summaryItemWithLabel:productTitle amount:price];
    
    request.paymentSummaryItems=@[item];
    
    
    PKPaymentAuthorizationViewController *PayVC=[[PKPaymentAuthorizationViewController alloc]initWithPaymentRequest:request];
    
    
    PayVC.delegate = delegate;
    
    
    [[CSUtility getCurrentViewController] presentViewController:PayVC animated:YES completion:nil];
    
}


#pragma mark - 添加银行卡界面
-(void)jumpAddBank
{
    // 跳转到添加银行卡界面
    
    PKPassLibrary *pl=[[PKPassLibrary alloc]init];
    
    [pl openPaymentSetup];
    
}

@end
