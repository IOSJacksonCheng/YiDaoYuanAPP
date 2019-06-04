//
//  DaShiRuZhuTextFieldTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuTextFieldTableViewCell.h"
@interface DaShiRuZhuTextFieldTableViewCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titelLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;


@end
@implementation DaShiRuZhuTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleTextField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DaShiRuZhuModel *)model {
    _model = model;
    self.titleTextField.text = model.content;
    self.titleTextField.placeholder = model.placeHolder;
    self.titelLabel.text = model.title;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.model.content = textField.text;
}
@end
