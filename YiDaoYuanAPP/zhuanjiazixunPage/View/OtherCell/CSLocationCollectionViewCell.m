//
//  CSLocationCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSLocationCollectionViewCell.h"

@implementation CSLocationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderColor = csBlueColor.CGColor;
    self.layer.cornerRadius = 3;
    self.layer.borderWidth = 1;
}

@end
