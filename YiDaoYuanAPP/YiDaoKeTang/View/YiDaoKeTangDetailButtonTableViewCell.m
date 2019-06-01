//
//  YiDaoKeTangDetailButtonTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangDetailButtonTableViewCell.h"

@interface YiDaoKeTangDetailButtonTableViewCell()

- (IBAction)clickIntroduceButtonDone:(id)sender;
- (IBAction)clickJudgeButtonDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *litterView;
@property (weak, nonatomic) IBOutlet UIButton *introduceButton;
@property (weak, nonatomic) IBOutlet UIButton *judgeButton;

@end
@implementation YiDaoKeTangDetailButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickIntroduceButtonDone:(id)sender {
    
    CGPoint point = self.litterView.center;
    
    CGFloat x = self.introduceButton.center.x;
    
    point.x = x;
    
    self.litterView.center = point;
    
    
    [self layoutIfNeeded];
    
    [self.csDelegate clickIntroduceButtonDone];
}

- (IBAction)clickJudgeButtonDone:(id)sender {
   
    CGPoint point = self.litterView.center;
    
    CGFloat x = self.judgeButton.center.x;
    
    point.x = x;
    
    self.litterView.center = point;
    
    
    [self layoutIfNeeded];
     [self.csDelegate clickJudgeButtonDone];
}
@end
