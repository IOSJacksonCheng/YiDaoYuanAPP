//
//  PayMoneyViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayMoneyViewController : BaseViewController
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *masterName;
@property (nonatomic, strong) NSString *masterIcon;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *dashangren;
@property (nonatomic, strong) NSString *dashangqian;
@end

NS_ASSUME_NONNULL_END
