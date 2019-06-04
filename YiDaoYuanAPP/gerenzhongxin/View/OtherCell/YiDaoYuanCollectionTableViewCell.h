//
//  YiDaoYuanCollectionTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YiDaoYuanCollectionTableViewCellDelegate <NSObject>

- (void)clickItemWithRow:(NSInteger)row;

@end
@interface YiDaoYuanCollectionTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, weak) id<YiDaoYuanCollectionTableViewCellDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
