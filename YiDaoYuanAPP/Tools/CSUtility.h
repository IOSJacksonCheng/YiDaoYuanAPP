//
//  CSUtility.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^updateRequestBlock)(BOOL updateSuccess);

@interface CSUtility : NSObject
/** 判断字符串是否为空 */
+ (BOOL) characterIsBlankString:(NSString *)string;

+(UIImage*) createImageWithColor:(UIColor*) color;

+ (UIViewController *)getCurrentViewController;
/** 设置错误提示信息 */
+ (void) showWrongMessageWithTitle:(NSString *)title;
+ (NSDate *)convertStringIntoDate:(NSString *)dateString;
+ (NSString *)convertDateIntoString:(NSDate *)date;
+ (NSString *) getCurrentDate;
+ (BOOL) handleNumber:(NSNumber *)string;
+ (void)updateCurrentMoney:(updateRequestBlock)update;
+ (UIImage *)csImageWithColor:(UIColor *)color
                         size:(CGSize)size
                         text:(NSString *)text
               textAttributes:(NSDictionary *)textAttributes
                     circular:(BOOL)isCircular;

+ (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text WithLabelInterval:(CGFloat)interval WithFont:(CGFloat)font;
+ (void)goToChatKefuViewController;
+ (UIViewController *)shoppingGetCurrentViewController;
+ (void)shoppingGoToKefuController;
+ (void)goToHistoryChatViewControllerWithOrderId:(NSString *)orderId;

+ (void)sendTextMessage:(NSString *)text WithOrderId:(NSString *)orderid;
+ (void)sendImageMessage:(UIImage *)image WithOrderId:(NSString *)orderid;
+ (void)sendVoiceMessageWithLocalPath:(NSString *)localPath duration:(NSInteger)duration WithOrderId:(NSString *)orderid;
@end

NS_ASSUME_NONNULL_END
