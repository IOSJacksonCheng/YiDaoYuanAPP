//
//  LunTanTitleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanTitleTableViewCell.h"

@interface LunTanTitleTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icomImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cscontentLabel;

@end
@implementation LunTanTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(LunTanModel *)model {
    
    _model = model;
    
    [self.icomImageView sd_setImageWithURL:[NSURL URLWithString:model.topic_img] placeholderImage:PlaceHolderImage];
    
    self.titleLabel.text = model.topic;
    
    self.timeLabel.text = model.create_time;
    
    self.cscontentLabel.text = model.content;
    
}
@end
