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

#define LOAD_LABEL                     NSLocalizedString(@"登录过期，请重新登录",)
@implementation CSUtility
{
    MBProgressHUD *_mbProgressHUD;
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
            update(NO);
            
        }else {
            update(NO);

            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        update(NO);

        CSInternetFailure
    }];
}

@end
