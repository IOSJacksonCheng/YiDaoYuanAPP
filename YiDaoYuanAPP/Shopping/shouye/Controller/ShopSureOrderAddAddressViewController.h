//
//  ShopSureOrderAddAddressViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"
@class AddressModel;
NS_ASSUME_NONNULL_BEGIN
@protocol ShopSureOrderAddAddressViewControllerDelegate <NSObject>

- (void)clickAddressModel:(AddressModel *)model;

@end
@interface ShopSureOrderAddAddressViewController : BaseViewController
@property (nonatomic, weak) id<ShopSureOrderAddAddressViewControllerDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
