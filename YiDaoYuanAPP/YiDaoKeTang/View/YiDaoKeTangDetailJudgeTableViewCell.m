//
//  YiDaoKeTangDetailJudgeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangDetailJudgeTableViewCell.h"
@interface YiDaoKeTangDetailJudgeTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dashiHuiLabel;

@property (weak, nonatomic) IBOutlet UIView *dashiView;

@end
@implementation YiDaoKeTangDetailJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.headImageView.layer.cornerRadius = 36;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(JudgeModel *)model {
    
    _model = model;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.nameLabel.text = model.nickname;
    
    self.timeLabel.text = model.ctime;
    
    self.contentLabel.text = model.content;
    
    if (csCharacterIsBlank(model.reply.content)) {
        self.dashiView.hidden = YES;
    } else {
        self.dashiView.hidden = NO;
        
        self.dashiHuiLabel.text = [NSString stringWithFormat:@"大师回复:%@",model.reply.content];;
    }
}
@end
