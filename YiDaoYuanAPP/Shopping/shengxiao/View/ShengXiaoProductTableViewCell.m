//
//  ShengXiaoProductTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShengXiaoProductTableViewCell.h"
@interface ShengXiaoProductTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation ShengXiaoProductTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ShopManyProductModel *)model {
    _model = model;
    self.introLabel.text = model.intro;
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    
    self.csTitleLabel.text = model.goods_name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.sell_price];
    
}
@end
