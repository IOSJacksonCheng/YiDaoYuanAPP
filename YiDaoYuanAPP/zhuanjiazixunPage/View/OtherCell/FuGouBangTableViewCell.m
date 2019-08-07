//
//  FuGouBangTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FuGouBangTableViewCell.h"
@interface FuGouBangTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gaojirenzhengImageView;
@property (weak, nonatomic) IBOutlet UILabel *danshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *renshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingfenLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;
@end
@implementation FuGouBangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(FuGouBangModel *)model {
   
    _model = model;
   
    if (model.is_auth) {
        self.gaojirenzhengImageView.hidden = NO;
    } else {
        self.gaojirenzhengImageView.hidden = YES;
    }
    self.nameLabel.text = model.name;
    
    self.renshuLabel.text = [NSString stringWithFormat:@"%@人",model.keep_num];
   
    self.danshuLabel.text = [NSString stringWithFormat:@"%@单",model.order_num];
    
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
    
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.pingfenLabel.text = model.grade;
    
    if (model.grade.intValue == 0) {
        self.oneXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.twoXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.threeXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fourXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fiveXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        
    } else if (model.grade.intValue == 1) {
        self.oneXingImageView.image = DotaImageName(@"icon_shoucang");
        self.twoXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.threeXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fourXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fiveXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        
        
    }else if (model.grade.intValue == 2) {
        self.oneXingImageView.image = DotaImageName(@"icon_shoucang");
        self.twoXingImageView.image = DotaImageName(@"icon_shoucang");
        self.threeXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fourXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fiveXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        
        
    }else if (model.grade.intValue == 3) {
        self.oneXingImageView.image = DotaImageName(@"icon_shoucang");
        self.twoXingImageView.image = DotaImageName(@"icon_shoucang");
        self.threeXingImageView.image = DotaImageName(@"icon_shoucang");
        self.fourXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        self.fiveXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        
        
    }else if (model.grade.intValue == 4) {
        self.oneXingImageView.image = DotaImageName(@"icon_shoucang");
        self.twoXingImageView.image = DotaImageName(@"icon_shoucang");
        self.threeXingImageView.image = DotaImageName(@"icon_shoucang");
        self.fourXingImageView.image = DotaImageName(@"icon_shoucang");
        self.fiveXingImageView.image = DotaImageName(@"icon_shoucang_kong");
        
        
    }else if (model.grade.intValue == 5) {
        self.oneXingImageView.image = DotaImageName(@"icon_shoucang");
        self.twoXingImageView.image = DotaImageName(@"icon_shoucang");
        self.threeXingImageView.image = DotaImageName(@"icon_shoucang");
        self.fourXingImageView.image = DotaImageName(@"icon_shoucang");
        self.fiveXingImageView.image = DotaImageName(@"icon_shoucang");
        
        
    }
    
}
@end
