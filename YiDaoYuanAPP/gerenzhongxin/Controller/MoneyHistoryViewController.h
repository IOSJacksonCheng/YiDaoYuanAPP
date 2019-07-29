//
//  MoneyHistoryViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, MoneyType) {
    YuEMoneyType = 0,
    YiDaoYuanMoneyType
    
};
@interface MoneyHistoryViewController : BaseViewController
@property (nonatomic, strong) NSString *passString;
@property (nonatomic, assign) MoneyType currentType;
@end

NS_ASSUME_NONNULL_END
