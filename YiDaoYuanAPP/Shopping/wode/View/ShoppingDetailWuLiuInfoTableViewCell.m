//
//  ShoppingDetailWuLiuInfoTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingDetailWuLiuInfoTableViewCell.h"
@interface ShoppingDetailWuLiuInfoTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *circleView;

@end
@implementation ShoppingDetailWuLiuInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.circleView.layer.cornerRadius = 21 * 0.5;
    self.circleView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
