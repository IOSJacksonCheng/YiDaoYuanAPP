//
//  GouWuCheTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GouWuCheTableViewCell.h"

@interface GouWuCheTableViewCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *featureLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
- (IBAction)clickSubNumberButtonDone:(UIButton *)sender;
- (IBAction)clickAddNumberButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;

@end
@implementation GouWuCheTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius = 5;
    
    self.inputTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(GouWuCheModel *)model {
    _model = model;
    
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    
    self.nameLabel.text = model.goods_name;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    
    if (model.choose) {
        self.chooseImageView.image = DotaImageName(@"icon_gouxuan");
    } else {
        self.chooseImageView.image = DotaImageName(@"icon_weigouxuan");

    }
    
    self.inputTextField.text = model.willBuyNum;
    self.featureLabel.text = [NSString stringWithFormat:@"%@%@",model.i, model.v];
}
- (IBAction)clickSubNumberButtonDone:(UIButton *)sender {
    
    int num = self.model.willBuyNum.intValue;
    
    int result = num - 1;
    
    if (result <= 0) {
        result = 0;
        
    }
    
     [self changeNum:[NSString stringWithFormat:@"%d",result]];
}

- (IBAction)clickAddNumberButtonDone:(UIButton *)sender {
    
    int num = self.model.willBuyNum.intValue;
    
    int result = num + 1;
    
    if (result <= 0) {
        result = 0;
        
    }
    [self changeNum:[NSString stringWithFormat:@"%d",result]];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self changeNum:textField.text];
    
}
- (void)changeNum:(NSString *)text {
   
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"quantity"] = text;
    
    para[@"cart_id"] = self.model.cart_id;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Cart_Modify Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.model.willBuyNum = text;
            self.inputTextField.text = text;
            [self.csDelegate refreshAllMoney];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
@end
