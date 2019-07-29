//
//  ShoppingAddressTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/13.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ShoppingAddressTableViewCellDelegate <NSObject>

- (void)modifyAddres:(AddressModel *)model;
- (void)changeAddressMoRenButton:(AddressModel *)model;
@end
@interface ShoppingAddressTableViewCell : UITableViewCell
@property (nonatomic, strong) AddressModel *model;
@property (nonatomic, weak) id<ShoppingAddressTableViewCellDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
