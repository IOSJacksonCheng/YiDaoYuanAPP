//
//  PersonalFirstRowTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/18.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalFirstRowTableViewCell.h"
@interface PersonalFirstRowTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *whiteBgView;
@property (weak, nonatomic) IBOutlet UIImageView *greenImageView;
@property (weak, nonatomic) IBOutlet UIView *redCircleView;



@end
@implementation PersonalFirstRowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.greenImageView.image = [CSUtility createImageWithColor:[UIColor colorWithHexString:@"0D71C8"]];
    self.whiteBgView.layer.cornerRadius = 10;
    self.whiteBgView.layer.masksToBounds = YES;
    
    self.redCircleView.layer.cornerRadius = 4;
    
    self.redCircleView.layer.masksToBounds = YES;
    
    self.headImageView.layer.cornerRadius = 68 * 0.5;
    self.headImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
