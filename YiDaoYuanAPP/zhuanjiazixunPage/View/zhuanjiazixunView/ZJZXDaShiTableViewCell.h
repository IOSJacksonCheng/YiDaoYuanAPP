//
//  ZJZXDaShiTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ZJZXDaShiTableViewCellDelegate <NSObject>

- (void)passDaShiMasterId:(NSString *)idString;

@end
@interface ZJZXDaShiTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *daShiArray;
@property (nonatomic, weak) id<ZJZXDaShiTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
