//
//  LunTanButtonTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LunTanButtonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hitstoryTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyMoreLabel;
@property (weak, nonatomic) IBOutlet UIView *historyBottomView;
@property (weak, nonatomic) IBOutlet UILabel *nowLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nowImageView;

@end

NS_ASSUME_NONNULL_END
