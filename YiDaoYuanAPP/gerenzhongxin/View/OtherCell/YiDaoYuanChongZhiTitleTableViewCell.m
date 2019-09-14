//
//  YiDaoYuanChongZhiTitleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoYuanChongZhiTitleTableViewCell.h"
@interface YiDaoYuanChongZhiTitleTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end
@implementation YiDaoYuanChongZhiTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moneyLabel.text = CS_Coin;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
