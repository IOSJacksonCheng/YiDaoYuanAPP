//
//  DaShiDetailTitlleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDetailTitlleTableViewCell.h"
@interface DaShiDetailTitlleTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *dashiHeadImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *dingdanshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *guanzhushuLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingjunhuifuLabel;

@property (weak, nonatomic) IBOutlet UILabel *pingFenLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;
@end
@implementation DaShiDetailTitlleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ManyDaShiModel *)model {
    
    _model = model;
    
    
    [self.dashiHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.nameLabel.text = model.user_name;
    
    if (self.model.is_new) {
        self.rightLabel.hidden = NO;
        self.rightImageView.hidden = NO;
    } else {
        self.rightLabel.hidden = YES;
        self.rightImageView.hidden = YES;
    }
    
    if (self.model.is_auth) {
        self.leftLabel.hidden = NO;
        self.leftImageView.hidden = NO;
    } else {
        self.leftLabel.hidden = YES;
        self.leftImageView.hidden = YES;
    }
    
    self.dingdanshuLabel.text = self.model.order_num;
    self.guanzhushuLabel.text = self.model.keep_num;
    self.pingjunhuifuLabel.text = [NSString stringWithFormat:@"%@分钟",self.model.avg_return];
    
    
    if (model.skille.count == 0) {
        
        self.firstShanChangLabel.text = @"";
        
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
        
    }
    
    if (model.skille.count >= 1) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else {
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 2) {
        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
    }else {
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 3) {
        self.thirdShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
    }
    
   
    
    
    
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
    
}
@end
