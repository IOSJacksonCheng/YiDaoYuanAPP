//
//  QingFoViewCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/20.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QingFoViewCollectionViewCell.h"
@interface QingFoViewCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;

@end
@implementation QingFoViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.csTitleLabel.layer.borderColor = [UIColor colorWithHexString:@"#BF8B1B"].CGColor;
    self.csTitleLabel.layer.borderWidth = 1;
    self.csTitleLabel.layer.cornerRadius = 5;
}

@end
