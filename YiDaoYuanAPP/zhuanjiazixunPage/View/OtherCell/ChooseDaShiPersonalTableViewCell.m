//
//  ChooseDaShiPersonalTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChooseDaShiPersonalTableViewCell.h"
@interface ChooseDaShiPersonalTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dashiImageView;
@property (weak, nonatomic) IBOutlet UILabel *answerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;

@end
@implementation ChooseDaShiPersonalTableViewCell

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
    self.nameLabel.text = model.name;
    [self.dashiImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:PlaceHolderImage];
    self.answerCountLabel.text = [NSString stringWithFormat:@"%@个回答",model.order_num];
    self.skillLabel.text = model.speciality;
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    if (model.choose) {
        self.chooseImageView.image = DotaImageName(@"icon_gouxuan");
    } else {
        self.chooseImageView.image = DotaImageName(@"icon_weigouxuan");
    }
}
@end
