//
//  AskStepThreeDetailInfomationTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AskStepThreeDetailInfomationTableViewCell.h"

@implementation AskStepThreeDetailInfomationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.inputView.layer.masksToBounds = YES;
    self.inputView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
