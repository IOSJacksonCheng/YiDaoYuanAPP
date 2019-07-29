//
//  ShoppingAllOrderTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAllOrderTableViewCell.h"




@interface ShoppingAllOrderTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shuxingLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@end

@implementation ShoppingAllOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setModel:(AllOrderModel *)model {
    
    _model = model;
    
   
    self.goodsNameLabel.text = model.goods_name;
    
    self.shuxingLabel.text = [NSString stringWithFormat:@"%@(%@)",model.goods_attr_name, model.goods_attr_value];
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    self.numLabel.text = [NSString stringWithFormat:@"X%@",model.quantity];
   
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_img] placeholderImage:PlaceHolderImage];
    
   
    
    
    
}

@end
