//
//  ShopSureOrderPayMoneyWayViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ShopSureOrderPayMoneyWayViewControllerDelegate <NSObject>

- (void)successGoBack;

@end
@interface ShopSureOrderPayMoneyWayViewController : BaseViewController
@property (nonatomic, strong) NSString *passVideoId;
@property (nonatomic, weak) id<ShopSureOrderPayMoneyWayViewControllerDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
