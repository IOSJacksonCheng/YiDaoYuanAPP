//
//  ShoppingAddPersonalAddressTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAddPersonalAddressTableViewCell.h"
@interface ShoppingAddPersonalAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *personLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
@implementation ShoppingAddPersonalAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AddressModel *)model {
    _model = model;
    self.addressLabel.text = model.shipp_address;
    self.phoneLabel.text = model.shipp_phone;
    self.personLabel.text = model.shipp_name;
}
@end
