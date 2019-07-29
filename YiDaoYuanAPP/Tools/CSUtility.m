//
//  CSUtility.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSUtility.h"
#import "CSCommonTabBarController.h"
#import "AppDelegate.h"
#import "ShopTabBarController.h"
#import "EasyUIChatViewController.h"
#define LOAD_LABEL                     NSLocalizedString(@"登录过期，请重新登录",)
@implementation CSUtility
{
    MBProgressHUD *_mbProgressHUD;
}
+ (UIViewController *)shoppingGetCurrentViewController {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[ShopTabBarController class]]) {
        result = [(ShopTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
+ (UIViewController *)getCurrentViewController {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[CSCommonTabBarController class]]) {
        result = [(CSCommonTabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);  
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (BOOL)characterIsBlankString:(NSString *)string {
    return [[self alloc] characterIsBlankString:string];
}
- (BOOL)characterIsBlankString:(NSString *)string {
    
    
    if (string == nil || string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if (![string isKindOfClass:[NSString class]]) {
        
        string = [NSString stringWithFormat:@"%@", string];
        
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    return NO;
    
}
+ (void) showWrongMessageWithTitle:(NSString *)title
{
    [[self alloc] showWrongMessageWithTitle:title];
    
}

- (void) showWrongMessageWithTitle:(NSString *)title
{
    
    
    AppDelegate* delegate = nil;
    delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    _mbProgressHUD = [MBProgressHUD showHUDAddedTo:delegate.window animated:YES];
    _mbProgressHUD.mode = MBProgressHUDModeText;
    
    _mbProgressHUD.color = CSColorRGBA(228, 228, 229, 1);
    
    _mbProgressHUD.labelFont = csCharacterFont_14;
    _mbProgressHUD.labelColor = UIColor.blackColor;
    
    _mbProgressHUD.detailsLabelFont = csCharacterFont_14;
    
    _mbProgressHUD.detailsLabelColor = UIColor.blackColor;
    
    if (![title isKindOfClass:[NSString class]]) {
        
        title = [NSString stringWithFormat:@"%@", title];
        
        
    }
    
    if([self characterIsBlankString:title])
    {
        _mbProgressHUD.detailsLabelText = LOAD_LABEL;
    }
    else
    {
        if (title.length > 19) {
            
            _mbProgressHUD.detailsLabelText = title;
            
        } else {
            
            _mbProgressHUD.labelText = title;
            
        }
        
    }
    
    [_mbProgressHUD hide:YES afterDelay:1.5];
    
}
+ (NSDate *)convertStringIntoDate:(NSString *)dateString {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [format dateFromString:dateString];
    return date;
}
+ (NSString *)convertDateIntoString:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentTime = [formatter stringFromDate:date];
    
    return currentTime;
}
+ (NSString *) getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    
    
    return currentTime;
}
+ (BOOL) handleNumber:(NSNumber *)string {
    if ([string isEqualToNumber:@1]) {
        return YES;
    }
    return NO;
}
+ (void)updateCurrentMoney:(updateRequestBlock)update {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_User_Profile_Account Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"coin"]] forKey:@"CS_Coin"];
            
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"balance"]] forKey:@"CS_Balance"];
            update(YES);
            
        }else {
            update(NO);

            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        update(NO);

        CSInternetFailure
    }];
}
+ (UIImage *)csImageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path =
        
        CGPathCreateWithRoundedRect(rect, 5, 20, nil);
;
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    
    
    
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text WithLabelInterval:(CGFloat)interval WithFont:(CGFloat)font{
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - interval;
    
    
    
    UIFont *newfont = [UIFont fontWithName:@"Arial-BoldItalicMT" size:font];
    
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:newfont forKey:NSFontAttributeName];
    
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height));
    
}
+ (void)shoppingGoToKefuController {
    
    if (CS_UserIsMaster) {
        if (![EMClient sharedClient].isLoggedIn) {
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"m%@",CS_UserID] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError) {
                    CSLog(@"环信登录失败:%@",aError.errorDescription);
                    CustomWrongMessage(@"发送错误，请稍后再试");
                } else {
                    [self shoppinggoToChatView];
                    CSLog(@"环信登录成功！");
                }
            }];
        } else {
            [self shoppinggoToChatView];
            
        }
    } else {
        
        CSLog(@"环信登录账号%@", [NSString stringWithFormat:@"u%@",CS_UserID]);
        if (![EMClient sharedClient].isLoggedIn) {
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"u%@",CS_UserID] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError) {
                    CSLog(@"环信登录失败:%@",aError.errorDescription);
                    CustomWrongMessage(@"发送错误，请稍后再试");
                } else {
                    [self shoppinggoToChatView];
                    CSLog(@"环信登录成功！");
                }
            }];
        } else {
            [self shoppinggoToChatView];
            
        }
    }
    
}
+ (void)shoppinggoToChatView {
    EasyUIChatViewController *new = [[EasyUIChatViewController alloc] initWithConversationChatter:@"admin" conversationType:EMConversationTypeChat];
    
    new.name = @"客服";
    new.isKefu = YES;
    [[CSUtility shoppingGetCurrentViewController].navigationController pushViewController:new animated:YES];
}
+ (void)goToChatKefuViewController {
    if (CS_UserIsMaster) {
        if (![EMClient sharedClient].isLoggedIn) {
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"m%@",CS_UserID] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError) {
                    CSLog(@"环信登录失败:%@",aError.errorDescription);
                    CustomWrongMessage(@"发送错误，请稍后再试");
                } else {
                    [self goToChatView];
                    CSLog(@"环信登录成功！");
                }
            }];
        } else {
            [self goToChatView];
            
        }
    } else {
        
        CSLog(@"环信登录账号%@", [NSString stringWithFormat:@"u%@",CS_UserID]);
        if (![EMClient sharedClient].isLoggedIn) {
            [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"u%@",CS_UserID] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                if (aError) {
                    CSLog(@"环信登录失败:%@",aError.errorDescription);
                    CustomWrongMessage(@"发送错误，请稍后再试");
                } else {
                    [self goToChatView];
                    CSLog(@"环信登录成功！");
                }
            }];
        } else {
            [self goToChatView];
            
        }
    }
   
}

+ (void)goToChatView {
    
    EasyUIChatViewController *new = [[EasyUIChatViewController alloc] initWithConversationChatter:@"admin" conversationType:EMConversationTypeChat];
    
    new.name = @"客服";
    
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
    
}
@end
