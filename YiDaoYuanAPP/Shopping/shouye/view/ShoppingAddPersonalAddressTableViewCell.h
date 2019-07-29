//
//  ShoppingAddPersonalAddressTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingAddPersonalAddressTableViewCell : UITableViewCell
@property (nonatomic, strong) AddressModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *moreIconImageView;


@end

NS_ASSUME_NONNULL_END
