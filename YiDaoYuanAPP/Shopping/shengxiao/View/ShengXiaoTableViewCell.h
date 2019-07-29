//
//  ShengXiaoTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ShengXiaoTableViewCellDelegate <NSObject>

- (void)reloadTableViewWithId:(NSString *)passId;

@end
@interface ShengXiaoTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, weak) id<ShengXiaoTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
