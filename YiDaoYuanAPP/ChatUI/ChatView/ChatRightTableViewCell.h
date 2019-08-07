//
//  ChatRightTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChatRightTableViewCell : UITableViewCell
@property (nonatomic, strong) ChatModel *model;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

NS_ASSUME_NONNULL_END
