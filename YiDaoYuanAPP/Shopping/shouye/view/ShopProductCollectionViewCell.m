//
//  ShopProductCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/13.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopProductCollectionViewCell.h"
@interface ShopProductCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIButton *shopCarButton;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;

@end
@implementation ShopProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shopCarButton.layer.cornerRadius = 29 * 0.5;
    
    self.shopCarButton.layer.masksToBounds = YES;
    
    self.typeLabel.layer.cornerRadius = 5;
    self.typeLabel.layer.borderColor = [UIColor colorWithHexString:@"#EA4141"].CGColor;
    self.typeLabel.layer.borderWidth = 1;
}

@end
