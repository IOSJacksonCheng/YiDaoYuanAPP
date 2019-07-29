//
//  JieYuanJiaTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "JieYuanJiaTableViewCell.h"
@interface JieYuanJiaTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation JieYuanJiaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(HomePageADModel *)model {
    
    _model = model;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.sell_price];
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.adimg] placeholderImage:PlaceHolderImage];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",model.goods_name, model.intro];
    
}
@end
