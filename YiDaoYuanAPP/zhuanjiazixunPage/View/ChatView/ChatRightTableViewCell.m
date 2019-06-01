//
//  ChatRightTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChatRightTableViewCell.h"

@interface ChatRightTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
@implementation ChatRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.layer.cornerRadius = 12;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ChatModel *)model {
    _model = model;
    self.imageView.image = DotaImageName(model.imageString);
    self.contentLabel.text = model.contentString;
}
@end
