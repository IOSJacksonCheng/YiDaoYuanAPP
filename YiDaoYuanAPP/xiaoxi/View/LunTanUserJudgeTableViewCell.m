//
//  LunTanUserJudgeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanUserJudgeTableViewCell.h"
@interface LunTanUserJudgeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *timeLL;
@property (weak, nonatomic) IBOutlet UILabel *neironLL;

@end
@implementation LunTanUserJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(pingjiaListModel *)model {
    _model = model;
    
    [self.iconIV sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.nameLabel.text = model.nickname;
    
    self.timeLL.text = model.create_time;
    self.neironLL.text = model.comment_content;
    
}
@end
