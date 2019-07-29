//
//  ShoppingAddressTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/13.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAddressTableViewCell.h"
@interface ShoppingAddressTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
- (IBAction)clickChangeAddressButtonDone:(id)sender;
- (IBAction)clickMoRenButtonDone:(id)sender;

@end
@implementation ShoppingAddressTableViewCell

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
    self.nameLabel.text = model.shipp_name;
    self.phoneLabel.text = model.shipp_phone;
    self.addressLabel.text = model.shipp_address;
    self.selectButton.selected = model.status;
    
}
- (IBAction)clickChangeAddressButtonDone:(id)sender {
    [self.csDelegate modifyAddres:self.model];
   
}

- (IBAction)clickMoRenButtonDone:(id)sender {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"shipp_id"] = self.model.shipp_id;
    para[@"shipp_name"] = self.model.shipp_name;
    para[@"shipp_phone"] = self.model.shipp_phone;
    para[@"shipp_address"] = self.model.shipp_address;
    para[@"status"] = @"1";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_User_Setaddress Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            [self.csDelegate changeAddressMoRenButton:self.model];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
@end
