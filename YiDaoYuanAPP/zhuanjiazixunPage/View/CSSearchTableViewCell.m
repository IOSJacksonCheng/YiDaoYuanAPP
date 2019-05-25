//
//  CSSearchTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSSearchTableViewCell.h"
@interface CSSearchTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *searchView;

@end
@implementation CSSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
