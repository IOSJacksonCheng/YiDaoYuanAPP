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
@property (nonatomic, strong) NSString *passOrderId;
//0咨询订单 1问答订单 2充值 3课堂订单 4商城订单 5赞赏订单
@property (nonatomic, strong) NSString *passOrderType;
@end

NS_ASSUME_NONNULL_END
