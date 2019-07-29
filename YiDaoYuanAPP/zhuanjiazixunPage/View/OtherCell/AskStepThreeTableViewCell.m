//
//  AskStepThreeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AskStepThreeTableViewCell.h"
@interface AskStepThreeTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *cstextLabel;

@end
@implementation AskStepThreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(QuestionId *)model {
    _model = model;

    
    if (model.choose) {
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.borderColor = csBlueColor.CGColor;
        self.cstextLabel.text = model.title;
        self.bgView.backgroundColor = csBlueColor;
        self.cstextLabel.textColor = UIColor.whiteColor;
        return;
    }
    
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#C2C2C2"].CGColor;
    self.cstextLabel.text = model.title;
    self.bgView.backgroundColor = UIColor.whiteColor;
    self.cstextLabel.textColor = cs333333Color;
        
}
@end
