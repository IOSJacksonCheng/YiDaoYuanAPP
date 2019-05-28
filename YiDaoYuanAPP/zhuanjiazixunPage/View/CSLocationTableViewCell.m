//
//  CSLocationTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSLocationTableViewCell.h"
@interface CSLocationTableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *onebutton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;

@end
@implementation CSLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.onebutton.layer.borderColor = csBlueColor.CGColor;
    self.onebutton.layer.cornerRadius = 3;
    self.onebutton.layer.borderWidth = 1;
    
    self.twoButton.layer.borderColor = csBlueColor.CGColor;
    self.twoButton.layer.cornerRadius = 3;
    self.twoButton.layer.borderWidth = 1;
    
    
    self.threeButton.layer.borderColor = csBlueColor.CGColor;
    self.threeButton.layer.cornerRadius = 3;
    self.threeButton.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
