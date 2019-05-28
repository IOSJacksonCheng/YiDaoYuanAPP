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
@property (weak, nonatomic) IBOutlet UIButton *consultButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation CSSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.masksToBounds = YES;
    
    self.consultButton.layer.cornerRadius = 5;
    self.consultButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setShowButton:(BOOL)showButton {
    _showButton = showButton;
    self.consultButton.hidden = !showButton;
    if (showButton) {
        self.priceLabel.text = @"免费";
    }
}
@end
