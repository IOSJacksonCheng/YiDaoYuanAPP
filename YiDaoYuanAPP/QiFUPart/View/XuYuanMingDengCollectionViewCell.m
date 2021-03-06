//
//  XuYuanMingDengCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/20.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "XuYuanMingDengCollectionViewCell.h"
@interface XuYuanMingDengCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;

@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;

@end
@implementation XuYuanMingDengCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(DengModel *)model {
    
    _model = model;
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];
    
    self.csTitleLabel.text =  model.name;
}
@end
