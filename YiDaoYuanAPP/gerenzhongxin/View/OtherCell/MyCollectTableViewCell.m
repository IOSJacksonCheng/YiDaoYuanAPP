//
//  MyCollectTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MyCollectTableViewCell.h"
@interface MyCollectTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *cstitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *guanzhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
@implementation MyCollectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MyCollectModel *)model {
    
    _model = model;
    
    self.cstitleLabel.text = model.title;
    
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail] placeholderImage:PlaceHolderImage];
    
    self.guanzhuLabel.text = [NSString stringWithFormat:@"%@关注",model.keep];
    self.cstitleLabel.text = [NSString stringWithFormat:@"%@:\n%@",model.title, model.descriptionString];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.create_time];
    
    
}
@end
