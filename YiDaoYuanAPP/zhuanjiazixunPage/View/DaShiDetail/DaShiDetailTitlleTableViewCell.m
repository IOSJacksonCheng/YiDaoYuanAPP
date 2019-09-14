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
@property (weak, nonatomic) IBOutlet UILabel *shanchangLabel;
@property (weak, nonatomic) IBOutlet UIView *firstLineView;
@property (weak, nonatomic) IBOutlet UIView *secondLineView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pingtairenzhengLabelLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xinjidashiRightLabelConstraint;

@end
@implementation DaShiDetailTitlleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
    
    self.dashiHeadImageView.layer.cornerRadius = 75 * 0.5;
    
    self.dashiHeadImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ManyDaShiModel *)model {
    
    _model = model;
    
    
    [self.dashiHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.nameLabel.text = model.user_name;
    
    self.shanchangLabel.text = model.speciality;
    
   
    if ((!model.is_new && model.is_auth) || (model.is_new && !model.is_auth)) {
       
        if (model.is_new) {
        
            self.xinjidashiRightLabelConstraint.constant = -20;
            
        } else {
            self.pingtairenzhengLabelLeftConstraint.constant = -20;
            
        }
        
    }
    
    
    if (model.is_new) {
        
        self.rightLabel.hidden = NO;
        
        self.rightImageView.hidden = NO;
        
    } else {
        
        self.rightLabel.hidden = YES;
        
        self.rightImageView.hidden = YES;
        
    }
    
    if (model.is_auth) {
        
        self.leftLabel.hidden = NO;
        
        self.leftImageView.hidden = NO;
        
    } else {
        
        self.leftLabel.hidden = YES;
        
        self.leftImageView.hidden = YES;
        
    }
    
    self.dingdanshuLabel.text = self.model.order_num;
    self.guanzhushuLabel.text = self.model.keep_num;
    self.pingjunhuifuLabel.text = [NSString stringWithFormat:@"%@分钟",self.model.avg_return];
    
    
    self.firstShanChangLabel.text = @"";
    
    self.secondShanChangLabel.text = @"";
    
    self.thirdShanChangLabel.text = @"";
    
    self.firstLineView.hidden = YES;
    self.secondLineView.hidden = YES;
    
    if (model.skille.count == 1) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else if (model.skille.count == 2) {
        self.firstLineView.hidden = NO;
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];

        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
    }else if (model.skille.count == 3) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
        
        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
        self.thirdShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
        self.firstLineView.hidden = NO;
        self.secondLineView.hidden = NO;
    }
    
    self.pingFenLabel.text = [NSString stringWithFormat:@"%.1f",model.grade.floatValue];
    
    
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
