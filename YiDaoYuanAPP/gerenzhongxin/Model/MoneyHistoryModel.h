//
//  MoneyHistoryModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoneyHistoryModel : NSObject
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *price;

@end

NS_ASSUME_NONNULL_END
