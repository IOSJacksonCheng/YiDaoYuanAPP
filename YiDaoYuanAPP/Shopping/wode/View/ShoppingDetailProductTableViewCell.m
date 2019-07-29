//
//  ShoppingDetailProductTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingDetailProductTableViewCell.h"
@interface ShoppingDetailProductTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csimageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuXingLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation ShoppingDetailProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AllOrderModel *)model {
    _model = model;
    
    [self.csimageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:PlaceHolderImage];
    self.numLabel.text = [NSString stringWithFormat:@"X%@",model.quantity];
    
    self.titleLabel.text = model.goods_name;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    self.shuXingLabel.text = [NSString stringWithFormat:@"%@%@",model.goods_attr_name, model.goods_attr_value];
    
}
@end
