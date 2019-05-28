//
//  DaShiDetailJudgeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDetailJudgeTableViewCell.h"
@interface DaShiDetailJudgeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;

@end
@implementation DaShiDetailJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firstLabel.layer.cornerRadius = 5;
    self.firstLabel.layer.borderColor = csBlueColor.CGColor;
    self.firstLabel.layer.borderWidth = 1;
    
    self.secondLabel.layer.cornerRadius = 5;
    self.secondLabel.layer.borderColor = csBlueColor.CGColor;
    self.secondLabel.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
