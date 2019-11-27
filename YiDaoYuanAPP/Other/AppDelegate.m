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

#import "JPUSHService.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
//#import "IQKeyboardManager.h"
NSString * const HuanXinAppkey = @"1129190711046202#yidaoyuan";

NSString * const HuanXinApnsCertName = @"";


NSString * const JiGuangAppKey = @"bf89425120e02dd8dc2b9cb7";
NSString * const JiGuangMasterMasterSecret = @"9ddaa6b4f1bb857fb19b516a";
@interface AppDelegate ()<WXApiDelegate, JPUSHRegisterDelegate>

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
    
    
    
    
    [self registerRemoteNotificationWith:launchOptions];

    
    if ([WXApi registerApp:CSWeChatAppId enableMTA:YES]) {
        CSLog(@"注册微信支付成功");
    } else {
        CSLog(@"注册微信支付失败");
    }

    [CSUtility checkIsDevelopStatus];
    
    
    return YES;
}

- (void)registerRemoteNotificationWith:(NSDictionary *)launchOptions {
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
     entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    
    if (@available(iOS 12.0, *)) {
      entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
      entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    
     if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
       // 可以添加自定义 categories
       // NSSet<UNNotificationCategory *> *categories for iOS10 or later
       // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
     }
    
     [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
     

     [JPUSHService setupWithOption:launchOptions appKey:JiGuangAppKey
                   channel:@"APPStore"
          apsForProduction:NO
     advertisingIdentifier:nil];
    
    
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
      if(resCode == 0){
       
          CSLog(@"registrationID获取成功：%@",registrationID);
       
          NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

           [defaults setObject:registrationID forKey:@"CID"];

      }
      else{
        CSLog(@"registrationID获取失败，code：%d",resCode);
      }
    }];
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

#pragma mark -- Notification

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

  /// Required - 注册 DeviceToken
    
  [JPUSHService registerDeviceToken:deviceToken];
    

    
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
  //Optional
  CSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
  if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //从通知界面直接进入应用
  }else{
    //从通知设置界面进入应用
  }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
  // Required
  NSDictionary * userInfo = notification.request.content.userInfo;
  if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
  // Required
  NSDictionary * userInfo = response.notification.request.content.userInfo;
  if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    [JPUSHService handleRemoteNotification:userInfo];
  }
  completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {

  // Required, iOS 7 Support
  [JPUSHService handleRemoteNotification:userInfo];
  completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

  // Required, For systems with less than or equal to iOS 6
  [JPUSHService handleRemoteNotification:userInfo];
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
