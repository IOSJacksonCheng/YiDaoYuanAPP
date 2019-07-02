//
//  DaShiRuZhuTextViewTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuTextViewTableViewCell.h"
@interface DaShiRuZhuTextViewTableViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *csTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end
@implementation DaShiRuZhuTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.csTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DaShiRuZhuModel *)model {
    _model = model;
    self.csTextView.text = model.content;
    self.titleLabel.text = model.title;
    self.placeholderLabel.text = model.placeHolder;
    if (csCharacterIsBlank(model.content)) {
        self.placeholderLabel.hidden = NO;
    } else {
        self.placeholderLabel.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
     self.model.content = textView.text;
}
- (void)textViewDidChange:(UITextView *)textView {
    if (csCharacterIsBlank(textView.text)) {
        self.placeholderLabel.hidden = NO;

    } else {
        self.placeholderLabel.hidden = YES;

    }
}
@end
