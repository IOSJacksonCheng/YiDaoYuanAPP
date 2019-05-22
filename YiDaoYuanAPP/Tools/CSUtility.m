//
//  CSUtility.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSUtility.h"

@implementation CSUtility

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
@end
