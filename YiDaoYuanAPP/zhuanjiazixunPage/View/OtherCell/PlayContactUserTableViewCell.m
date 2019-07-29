//
//  PlayContactUserTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactUserTableViewCell.h"
@interface PlayContactUserTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *csImgView;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *csTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *csSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userJudgeLabel;

@end
@implementation PlayContactUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.csImgView.layer.cornerRadius = 25;
    self.csImgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FirstPageModel *)model {
    
    _model = model;
    
    [self.csImgView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.csTitleLabel.text = model.nickname;
    
    self.csTimeLabel.text = model.ctime;
    
    self.csSubTitleLabel.text = model.title;
    
    self.userJudgeLabel.text = model.content;
    
    
}
@end
