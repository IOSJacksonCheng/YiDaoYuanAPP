//
//  CSUtility.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSUtility : NSObject
/** 判断字符串是否为空 */
+ (BOOL) characterIsBlankString:(NSString *)string;

+(UIImage*) createImageWithColor:(UIColor*) color;
@end

NS_ASSUME_NONNULL_END
