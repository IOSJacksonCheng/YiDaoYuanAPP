//
//  YiDaoKeTangTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangTableViewCell.h"
@interface YiDaoKeTangTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftguanzhuLabel;
@end
@implementation YiDaoKeTangTableViewCell

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
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@%@",model.title, model.intro];
    
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self.titleLabel.text];
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"icon_shi"];
    attach.bounds = CGRectMake(0, -1, 15, 15);
    [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach] atIndex:self.titleLabel.text.length];
    
    self.titleLabel.attributedText = attriStr;
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    self.leftTimeLabel.text = model.ctime;
    self.leftguanzhuLabel.text = [NSString stringWithFormat:@"关注%@",model.count];
    
}
@end
