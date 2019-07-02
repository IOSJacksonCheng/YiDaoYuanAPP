//
//  CSLocationTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAreaModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CSLocationTableViewCellDelegate <NSObject>

- (void)GetLocationModel:(CSAreaModel *)model;

@end
@interface CSLocationTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *itemMutableArray;
@property (nonatomic, weak) id<CSLocationTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
