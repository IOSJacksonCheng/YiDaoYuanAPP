//
//  DaShiRuZhuIdCardTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuIdCardTableViewCell.h"
@interface DaShiRuZhuIdCardTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation DaShiRuZhuIdCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DaShiRuZhuModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    
}
@end
