//
//  ShopProductGuiGeTypeTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DaShiListItemModel;
@protocol ShopProductGuiGeTypeTableViewCellDelegate <NSObject>

- (void)clickItemPassPrice:(DaShiListItemModel *)itemModel;

@end
@interface ShopProductGuiGeTypeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *itemMutableArray;
@property (nonatomic, weak) id<ShopProductGuiGeTypeTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
