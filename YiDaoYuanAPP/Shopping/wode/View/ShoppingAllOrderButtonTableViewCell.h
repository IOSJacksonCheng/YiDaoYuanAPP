//
//  ShoppingAllOrderButtonTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/16.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllOrderModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ShoppingAllOrderButtonTableViewCellDelegate <NSObject>
- (void)clickCheckWuLiu;

- (void)clickCancelOrderDone;
- (void)passOrderId:(NSString *)orderID;
@end
@interface ShoppingAllOrderButtonTableViewCell : UITableViewCell
@property (nonatomic, strong) AllOrderModel *model;
@property (nonatomic, weak) id<ShoppingAllOrderButtonTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
