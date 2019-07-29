//
//  MoneyHistoryFourTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MoneyHistoryFourTableViewCell.h"
@interface MoneyHistoryFourTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;

@end
@implementation MoneyHistoryFourTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MoneyHistoryModel *)model {
    
    _model = model;
    
    self.firstLabel.text = model.money;
    
    self.secondLabel.text = model.price;
    
    self.thirdLabel.text = model.title;
    
    self.fourthLabel.text = model.ctime;
}
@end
