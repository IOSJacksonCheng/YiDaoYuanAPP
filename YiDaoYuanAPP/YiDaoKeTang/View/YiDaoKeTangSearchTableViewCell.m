//
//  YiDaoKeTangSearchTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangSearchTableViewCell.h"
@interface YiDaoKeTangSearchTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *guanzhuLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
@implementation YiDaoKeTangSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(YiDaoKeTangModel *)model {
    
    _model = model;
    
    self.csTitleLabel.text = [NSString stringWithFormat:@"%@%@",model.title, model.intro];
    
    

    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    self.timeLabel.text = model.ctime;
    self.guanzhuLabel.text = [NSString stringWithFormat:@"%@关注",model.focus];
    
}
@end
