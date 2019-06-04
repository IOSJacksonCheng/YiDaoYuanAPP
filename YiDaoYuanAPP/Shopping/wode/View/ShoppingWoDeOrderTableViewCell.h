//
//  ShoppingWoDeOrderTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShoppingWoDeOrderTableViewCellDelegate <NSObject>

- (void)goWhichTag:(NSInteger)tag;

@end
@interface ShoppingWoDeOrderTableViewCell : UITableViewCell
@property (nonatomic, weak) id<ShoppingWoDeOrderTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
