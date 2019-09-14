//
//  KeTangShiPingTitleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "KeTangShiPingTitleTableViewCell.h"

@implementation KeTangShiPingTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.freeButton.layer.cornerRadius = 5;
    self.freeButton.layer.borderColor = csBlueColor.CGColor;
    self.freeButton.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
