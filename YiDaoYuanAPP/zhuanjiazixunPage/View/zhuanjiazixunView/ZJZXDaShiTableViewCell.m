//
//  ZJZXDaShiTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXDaShiTableViewCell.h"
@interface ZJZXDaShiTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *baziLabel;
@property (weak, nonatomic) IBOutlet UILabel *qumingLabel;
@property (weak, nonatomic) IBOutlet UILabel *fengshuiLabel;

@end
@implementation ZJZXDaShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.baziLabel.layer.cornerRadius = 3;
    self.baziLabel.layer.borderColor = csBlueColor.CGColor;
    self.baziLabel.layer.borderWidth = 1;
    
    self.qumingLabel.layer.cornerRadius = 3;
    self.qumingLabel.layer.borderColor = csBlueColor.CGColor;
    self.qumingLabel.layer.borderWidth = 1;
    
    self.fengshuiLabel.layer.cornerRadius = 3;
    self.fengshuiLabel.layer.borderColor = csBlueColor.CGColor;
    self.fengshuiLabel.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
