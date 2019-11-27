//
//  CSAppPayTools.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/10/18.
//  Copyright © 2019 Jackson cheng. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <PassKit/PassKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSAppPayTools : NSObject 

+ (BOOL)isValidForApplyPay;


+ (void)beginBuyWithTItle:(NSString *)productTitle WithMoney:(NSString *)money WithDelegate:(id<PKPaymentAuthorizationViewControllerDelegate>)delegate;


@end

NS_ASSUME_NONNULL_END
