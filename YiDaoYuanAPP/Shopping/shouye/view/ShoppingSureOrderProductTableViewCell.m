//
//  ShoppingSureOrderProductTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingSureOrderProductTableViewCell.h"
@interface ShoppingSureOrderProductTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *feathureLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
@implementation ShoppingSureOrderProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(GoodsModel *)model {
    _model = model;
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    self.numLabel.text = [NSString stringWithFormat:@"X%@",model.quantity];
    
    self.titleLabel.text = model.title;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.feathureLabel.text = model.attr;
    
}
@end
