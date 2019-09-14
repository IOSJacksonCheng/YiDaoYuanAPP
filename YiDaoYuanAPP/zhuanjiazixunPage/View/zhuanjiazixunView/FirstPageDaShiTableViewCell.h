//
//  FirstPageDaShiTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZJZXDaShiTableViewCellDelegate <NSObject>

- (void)passDaShiMasterId:(NSString *)idString;
- (void)passLevelId:(NSString *)level WithTitle:(NSString *)title;
@end
@interface FirstPageDaShiTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *itemMutableArray;
@property (nonatomic, weak) id<ZJZXDaShiTableViewCellDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
