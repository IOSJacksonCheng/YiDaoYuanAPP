//
//  UserMineJudgeListTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserMineJudgeListTableViewCell.h"
@interface UserMineJudgeListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *pingFenLabel;

@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;

@property (weak, nonatomic) IBOutlet UILabel *qaLabel;
@property (weak, nonatomic) IBOutlet UIView *firstView;

@end
@implementation UserMineJudgeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UserJudgeListModel *)model {
    
    _model = model;
  
    self.pingFenLabel.text = model.grade;
    
    if (model.grade.intValue == 0) {
        self.oneXingImageView.image = DotaImageName(@"icon_weishou");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
    } else if (model.grade.intValue == 1) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 2) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 3) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 4) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 5) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect");
        
        
    }
    self.qaLabel.text = model.content;
    self.nameLabel.text = model.master_name;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.firstView.hidden = YES;
    self.secondView.hidden = YES;
        
        self.firstShanChangLabel.text = @"";
        
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
        
    
    
    if (model.skille.count == 1) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else if (model.skille.count == 2) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];

        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
        self.firstView.hidden = NO;
    }else if (model.skille.count == 3) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
        
        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
        self.thirdShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
        self.firstView.hidden = NO;
        self.secondView.hidden = NO;

    }
    
    
    
}
@end
