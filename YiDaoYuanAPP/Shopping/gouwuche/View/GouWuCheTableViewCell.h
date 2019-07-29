//
//  GouWuCheTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GouWuCheModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol GouWuCheTableViewCellDelegate <NSObject>

- (void)refreshAllMoney;

@end
@interface GouWuCheTableViewCell : UITableViewCell
@property (nonatomic, strong) GouWuCheModel *model;
@property (nonatomic, weak) id<GouWuCheTableViewCellDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
