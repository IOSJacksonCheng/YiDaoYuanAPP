//
//  ShoppingShouYeTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShoppingShouYeTableViewCellDelegate <NSObject>

- (void)passID:(NSString *)passID;

@end
@interface ShoppingShouYeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *itemMutableArray;
@property (nonatomic, weak) id<ShoppingShouYeTableViewCellDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
