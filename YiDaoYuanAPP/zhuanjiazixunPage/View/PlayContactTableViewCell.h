//
//  PlayContactTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *askButton;
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *csSubTitleLabel;

@end

NS_ASSUME_NONNULL_END
