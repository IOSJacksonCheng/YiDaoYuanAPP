//
//  ShopDetailWebTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/15.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShopDetailWebTableViewCellDelegate <NSObject>

- (void)passCellHeight:(CGFloat)height;

@end
@interface ShopDetailWebTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *passUrl;
@property (nonatomic, weak) id<ShopDetailWebTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
