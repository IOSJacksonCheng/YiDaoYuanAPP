//
//  RightNowConsultTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RightNowConsultTableViewCellDelegate <NSObject>

- (void)passCurrentSection:(NSInteger)section WithRow:(NSInteger)row;

@end
@interface RightNowConsultTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, weak) id<RightNowConsultTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
