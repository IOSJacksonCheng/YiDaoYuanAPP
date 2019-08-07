//
//  AppDelegate.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>

#import <TencentOpenAPI/QQApiInterface.h>

#import <TencentOpenAPI/TencentOAuth.h>

#import <EaseUI.h>

//#import "IQKeyboardManager.h"
NSString * const HuanXinAppkey = @"1129190711046202#yidaoyuan";

NSString * const HuanXinApnsCertName = @"";



@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.


   
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                        didFinishLaunchingWithOptions:launchOptions
                                               appkey:HuanXinAppkey
                                         apnsCertName:HuanXinApnsCertName
                                          otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
 
    
    
    [WXApi startLogByLevel:WXLogLevelNormal logBlock:^(NSString *log) {
        CSLog(@"！！！！！！log : %@", log);
    }];
    
    
    if ([WXApi registerApp:CSWeChatAppId enableMTA:YES]) {
        CSLog(@"注册微信支付成功");
    } else {
        CSLog(@"注册微信支付失败");
    }
//    if (!CSIsLogin) {
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//        
//        self.window.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CSLoginNavigationController"];
//    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cswillenterForeground" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 微信支付回调

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
   
    
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            CSLog(@"result = %@",resultDic);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipayResult_Notification"
                                                                object:resultDic];
        }];
    }
    //微信支付
    if([url.host isEqualToString:@"pay"]  || [url.host isEqualToString:@"oauth"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    
    return YES;
}
- (void)onResp:(BaseResp *)resp
{
    //支付返回结果，实际支付结果需要去微信服务器端查询
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response = (PayResp *)resp;
        switch (response.errCode) {
            case WXSuccess:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayResult_Notification" object:[NSNumber numberWithBool:YES]];
                break;
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXpayResult_Notification" object:[NSNumber numberWithBool:NO]];
                break;
        }
    } else  if([resp isKindOfClass:[SendAuthResp class]]){//判断是否为授权登录类
        
        SendAuthResp *req = (SendAuthResp *)resp;
        if([req.state isEqualToString:@"wx_oauth_authorization_state"]){//微信授权成功
            
            if(req.errCode == 0){
                
                CSLog(@"获取code：%@", req.code);
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXLoginstatus_Notification" object:req.code];
                
//                [self sendPostRequestWithCodeInfo:req.code];
                //                req.code;
            }
        }
    }
    
}

@end
