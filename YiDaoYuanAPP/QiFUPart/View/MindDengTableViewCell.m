//
//  MindDengTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MindDengTableViewCell.h"
@interface MindDengTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *xuanzhongImageView;
@end
@implementation MindDengTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DengPriceModel *)model {
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"点灯%@天",model.day];
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@",model.start, model.end];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@\n易道元",model.price];
    if (model.recommend) {
        self.csImageView.hidden = NO;
    } else {
        self.csImageView.hidden = YES;
    }
    
    if (model.choose) {
        
        self.xuanzhongImageView.hidden = NO;
        
        self.backgroundColor = [UIColor colorWithHexString:@"#F3861F"];
        UIColor *titleColor = [UIColor colorWithHexString:@"#FAFBCB"];;
        
        self.titleLabel.textColor = titleColor;
        self.moneyLabel.textColor = titleColor;
        self.timeLabel.textColor = titleColor;
        
    }else {
        self.xuanzhongImageView.hidden = YES;

        self.backgroundColor = [UIColor colorWithHexString:@"#FFFFAC"];
        
        UIColor *titleColor = [UIColor colorWithHexString:@"#BD5F4A"];;
        
        self.titleLabel.textColor = titleColor;
        self.moneyLabel.textColor = titleColor;
        self.timeLabel.textColor = titleColor;
        
    }
}
@end
