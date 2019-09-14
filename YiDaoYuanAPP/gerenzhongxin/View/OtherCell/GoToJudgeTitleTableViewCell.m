//
//  GoToJudgeTitleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GoToJudgeTitleTableViewCell.h"
@interface GoToJudgeTitleTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
@implementation GoToJudgeTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DaShiOrderInfoModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.master_name;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
   
    
    self.firstShanChangLabel.text = @"";
    
    self.secondShanChangLabel.text = @"";
    
    self.thirdShanChangLabel.text = @"";
    
    self.firstView.hidden = YES;
    self.secondView.hidden = YES;
    
    if (model.skille.count == 1) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else if (model.skille.count == 2) {
        self.firstView.hidden = NO;
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];

        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
    }else if (model.skille.count == 3) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
        
        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
        self.thirdShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
        self.firstView.hidden = NO;
        self.secondView.hidden = NO;
    }
    
    
}

@end
