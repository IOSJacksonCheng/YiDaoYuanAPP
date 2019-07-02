//
//  IndustryNewsTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "IndustryNewsTableViewCell.h"
@interface IndustryNewsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *csContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *csTimeLabel;

@end
@implementation IndustryNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(IndustryNewsModel *)model {
    _model = model;
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.thumb] placeholderImage:PlaceHolderImage];
    
    self.csTimeLabel.text = model.ctime;
    
    self.csTitleLabel.text = model.title;
    
    self.csContentLabel.text = model.excerpt;
    
    
    
}
@end
