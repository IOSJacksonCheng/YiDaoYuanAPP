//
//  DaShiDetailJudgeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDetailJudgeTableViewCell.h"
@interface DaShiDetailJudgeTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthLabel;

@property (weak, nonatomic) IBOutlet UILabel *pingfenLabel;

@property (weak, nonatomic) IBOutlet UILabel *judgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;
@property (weak, nonatomic) IBOutlet UILabel *payMoneyItemLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
@implementation DaShiDetailJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firstLabel.layer.cornerRadius = 5;
    self.firstLabel.layer.borderColor = csBlueColor.CGColor;
    self.firstLabel.layer.borderWidth = 1;
    
    self.secondLabel.layer.cornerRadius = 5;
    self.secondLabel.layer.borderColor = csBlueColor.CGColor;
    self.secondLabel.layer.borderWidth = 1;
    
    self.thirdLabel.layer.cornerRadius = 5;
    self.thirdLabel.layer.borderColor = csBlueColor.CGColor;
    self.thirdLabel.layer.borderWidth = 1;
    
    self.fourthLabel.layer.cornerRadius = 5;
    self.fourthLabel.layer.borderColor = csBlueColor.CGColor;
    self.fourthLabel.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UserJudgeArray *)model {
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.nameLabel.text = model.user_nickname;
    
    self.timeLabel.text = model.ctime;
    
    self.payMoneyItemLabel.text = model.item_title;
    
    self.judgeLabel.text = model.content;
    
    self.pingfenLabel.text = model.avg;
    
    if (model.avg.intValue == 0) {
        self.oneXingImageView.image = DotaImageName(@"icon_weishou");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
    } else if (model.avg.intValue == 1) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.avg.intValue == 2) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.avg.intValue == 3) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.avg.intValue == 4) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.avg.intValue == 5) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect");
        
        
    }
    self.firstLabel.hidden = YES;
    self.secondLabel.hidden = YES;
    self.thirdLabel.hidden = YES;
    self.fourthLabel.hidden = YES;
    if (self.model.tags.count >= 1) {
        self.firstLabel.hidden = NO;
        self.secondLabel.hidden = YES;
        self.thirdLabel.hidden = YES;
        self.fourthLabel.hidden = YES;
        self.firstLabel.text = [NSString stringWithFormat:@"%@",self.model.tags[0]];
    }
    
    if (self.model.tags.count >= 2) {
        self.firstLabel.hidden = NO;
        self.secondLabel.hidden = NO;
        self.thirdLabel.hidden = YES;
        self.fourthLabel.hidden = YES;
        self.secondLabel.text = [NSString stringWithFormat:@"%@",self.model.tags[1]];
    }
    if (self.model.tags.count >= 3) {
        self.firstLabel.hidden = NO;
        self.secondLabel.hidden = NO;
        self.thirdLabel.hidden = NO;
        self.fourthLabel.hidden = YES;
        self.thirdLabel.text = [NSString stringWithFormat:@"%@",self.model.tags[2]];
    }
    if (self.model.tags.count >= 4) {
        self.firstLabel.hidden = NO;
        self.secondLabel.hidden = NO;
        self.thirdLabel.hidden = NO;
        self.fourthLabel.hidden = NO;
        self.fourthLabel.text = [NSString stringWithFormat:@"%@",self.model.tags[3]];
    }
}
@end
