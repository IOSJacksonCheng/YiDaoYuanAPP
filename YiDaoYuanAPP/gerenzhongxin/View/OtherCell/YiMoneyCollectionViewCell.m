//
//  YiMoneyCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiMoneyCollectionViewCell.h"
@interface YiMoneyCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *RmbLabel;
@property (weak, nonatomic) IBOutlet UIView *saleView;
@property (weak, nonatomic) IBOutlet UILabel *saleLabel;

@end
@implementation YiMoneyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}
- (void)setModel:(YiDaoYuanCollectionModel *)model {
    self.moneyLabel.text = [NSString stringWithFormat:@"%@易道元",model.money];
    self.RmbLabel.text = [NSString stringWithFormat:@"¥%@", model.RMB];
    self.layer.borderWidth = 1;
    
    if (model.choose) {
        self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.moneyLabel.textColor = csBlueColor;
        self.RmbLabel.textColor = csBlueColor;
        self.layer.borderColor = csBlueColor.CGColor;
    } else {
        self.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
        
        self.moneyLabel.textColor = [UIColor colorWithHexString:@"333333"];
        self.RmbLabel.textColor = [UIColor colorWithHexString:@"666666"];
        self.layer.borderColor = [UIColor colorWithHexString:@"F3F3F3"].CGColor;
    }
    
    if (model.showSales) {
        self.saleView.hidden = NO;
        
        self.saleLabel.text = [NSString stringWithFormat:@"%@折",model.sales];
    } else {
        self.saleView.hidden = YES;
    }
}
@end
