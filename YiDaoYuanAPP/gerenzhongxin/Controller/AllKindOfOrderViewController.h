//
//  AllKindOfOrderViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, OrderType) {
    DaShiDuanZiXunType = 0,
    DaShiDuanHuiDaType,
    UserDuanZiXuanType,
    UserDuanHuiDaType
};
NS_ASSUME_NONNULL_BEGIN

@interface AllKindOfOrderViewController : BaseViewController
@property (nonatomic, strong) NSString *passTitle;
@property (nonatomic, assign) OrderType currentType;

@end

NS_ASSUME_NONNULL_END
