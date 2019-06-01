//
//  YiDaoKeTangDetailButtonTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol YiDaoKeTangDetailButtonTableViewCellDelegate <NSObject>

- (void)clickIntroduceButtonDone;
- (void)clickJudgeButtonDone;
@end
@interface YiDaoKeTangDetailButtonTableViewCell : UITableViewCell
@property (nonatomic, weak) id<YiDaoKeTangDetailButtonTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
