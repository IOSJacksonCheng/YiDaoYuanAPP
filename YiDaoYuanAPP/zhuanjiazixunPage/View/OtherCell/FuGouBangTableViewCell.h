//
//  FuGouBangTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuGouBangTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *titleView;
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;

@end

NS_ASSUME_NONNULL_END
