//
//  DaShiRuZhuButtonTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuButtonTableViewCell.h"
@interface DaShiRuZhuButtonTableViewCell ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cardTextField;

@end
@implementation DaShiRuZhuButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.leftButton addTarget:self action:@selector(clickLeftDone) forControlEvents:UIControlEventTouchDown];
    
    [self.rightButton addTarget:self action:@selector(clickRightDone) forControlEvents:UIControlEventTouchDown];
}
- (void)clickRightDone {
    self.leftButton.selected = NO;
    self.rightButton.selected = YES;
    self.model.chooseLeft = NO;
    self.model.alipayName = @"银行卡姓名：";
    self.model.alipayCard = @"银行卡账号：";
     [self setModel:self.model];
}
- (void)clickLeftDone {
    self.leftButton.selected = YES;
    self.rightButton.selected = NO;
    self.model.chooseLeft = YES;
    self.model.alipayName = @"支付宝姓名：";
    self.model.alipayCard = @"支付宝账号：";
    [self setModel:self.model];
}
- (void)setModel:(DaShiRuZhuModel *)model {
    _model = model;
    self.cardNumberLabel.text = model.alipayName;
    self.cardNameLabel.text = model.alipayCard;
    self.cardTextField.text = model.Card;
    self.nameTextField.text = model.Name;
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.model.Name = textField.text;
    }else {
        self.model.Card = textField.text;
    }
}
@end
