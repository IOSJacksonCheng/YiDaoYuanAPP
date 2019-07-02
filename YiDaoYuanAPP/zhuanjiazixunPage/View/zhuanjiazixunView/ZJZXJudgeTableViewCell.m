//
//  ZJZXJudgeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXJudgeTableViewCell.h"
@interface ZJZXJudgeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *judgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csTitleImageVIew;

@end
@implementation ZJZXJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.csTitleImageVIew.layer.cornerRadius = 68 * 0.5;
    self.csTitleImageVIew.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FirstPageModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.nickname;
    
    self.typeLabel.text = model.title;
    
    self.timeLabel.text = model.ctime;
    
    self.judgeLabel.text = model.content;
    
    [self.csTitleImageVIew sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    
    
}
@end
