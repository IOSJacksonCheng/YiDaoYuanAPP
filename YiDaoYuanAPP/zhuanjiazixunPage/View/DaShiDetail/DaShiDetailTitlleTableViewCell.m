//
//  DaShiDetailTitlleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDetailTitlleTableViewCell.h"
@interface DaShiDetailTitlleTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation DaShiDetailTitlleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
