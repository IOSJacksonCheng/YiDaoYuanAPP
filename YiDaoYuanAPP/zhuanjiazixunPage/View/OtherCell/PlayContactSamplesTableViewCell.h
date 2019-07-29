//
//  PlayContactSamplesTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstPageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlayContactSamplesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (nonatomic, strong) FirstPageModel *model;
@end

NS_ASSUME_NONNULL_END
