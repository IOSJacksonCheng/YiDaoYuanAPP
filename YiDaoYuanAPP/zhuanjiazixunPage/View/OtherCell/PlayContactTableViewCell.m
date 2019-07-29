//
//  PlayContactTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactTableViewCell.h"

@implementation PlayContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.askButton.layer.cornerRadius = 5;
    
    [self.askButton addTarget:self action:@selector(clickAskButtonDone) forControlEvents:UIControlEventTouchDown];
}
- (void)clickAskButtonDone {
    [self.csDelegate passContactModelId:self.model];
    [[CSUtility getCurrentViewController] performSegueWithIdentifier:@"PlayContactStepThreeViewController" sender:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FirstPageManyItemModel *)model {
    _model = model;
}
@end
