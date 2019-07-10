//
//  YiDaoKeTangDetailDaShiTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangDetailDaShiTableViewCell.h"
@interface YiDaoKeTangDetailDaShiTableViewCell()


@end
@implementation YiDaoKeTangDetailDaShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.csImageView.layer.cornerRadius = 42;
    self.csImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
