//
//  ChooseDaShiTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChooseDaShiTableViewCell.h"
@interface ChooseDaShiTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dashiImageView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@end
@implementation ChooseDaShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ChooseDaShiModel *)model {
    _model = model;
    NSString *title = [NSString stringWithFormat:@"超过%@位用户选择",model.order_num];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
    
    [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:13/255.0 green:113/255.0 blue:200/255.0 alpha:1.0]} range:NSMakeRange(2, 4)];
    
    self.numLabel.attributedText = string;
    
    [self.dashiImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:PlaceHolderImage];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    if (model.choose) {
        self.chooseImageView.image = DotaImageName(@"icon_gouxuan");
    } else {
        self.chooseImageView.image = DotaImageName(@"icon_weigouxuan");
    }
}
@end
