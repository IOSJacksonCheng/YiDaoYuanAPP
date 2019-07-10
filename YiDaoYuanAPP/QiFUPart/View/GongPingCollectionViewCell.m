//
//  GongPingCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/8.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GongPingCollectionViewCell.h"
@interface GongPingCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *xiangImageView;

@property (weak, nonatomic) IBOutlet UILabel *labelTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation GongPingCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(GongPingModel *)model {
    
    _model = model;
    
    [self.xiangImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];

    
    self.labelTitleLabel.text = model.name;
    
    if (model.price.floatValue == 0) {
        self.moneyLabel.text = @"免费";
    } else {
        self.moneyLabel.text = [NSString stringWithFormat:@"%d易道元",model.price.intValue];
    }
    
}
@end
