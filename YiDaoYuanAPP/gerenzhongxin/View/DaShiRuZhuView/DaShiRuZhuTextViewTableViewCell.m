//
//  DaShiRuZhuTextViewTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuTextViewTableViewCell.h"
@interface DaShiRuZhuTextViewTableViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet ValuationTextView *csTextView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

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
    self.csTextView.placeholder = model.placeHolder;
    self.csTextView.placeholderColor = cs999999Color;
    self.titleLabel.text = model.title;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
     self.model.content = textView.text;
}

@end
