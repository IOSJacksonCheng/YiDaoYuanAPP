//
//  ManyItemTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstPageManyItemModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ManyItemTableViewCellDelegate <NSObject>

- (void)passItemId:(FirstPageManyItemModel *)model;

@end
@interface ManyItemTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, weak) id<ManyItemTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
