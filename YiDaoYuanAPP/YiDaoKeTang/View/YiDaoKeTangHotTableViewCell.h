//
//  YiDaoKeTangHotTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YiDaoKeTangHotTableViewCellDelegate <NSObject>

- (void)goWhichIdString:(NSString *)classId;

@end
@interface YiDaoKeTangHotTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, weak) id<YiDaoKeTangHotTableViewCellDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
