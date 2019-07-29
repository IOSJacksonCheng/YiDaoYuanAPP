//
//  ConsultTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConsultModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ConsultTableViewCellDelegate <NSObject>

- (void)passModel:(ConsultModel *)model;
- (void)refreshCurrentView;
@end
@interface ConsultTableViewCell : UITableViewCell
@property (nonatomic, strong) ConsultModel *model;
@property (nonatomic, weak) id<ConsultTableViewCellDelegate> simpleDelegate;

@property (nonatomic, assign) BOOL zixun;
@end

NS_ASSUME_NONNULL_END
