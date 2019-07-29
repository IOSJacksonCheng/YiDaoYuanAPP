//
//  CSSearchTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSSearchTableViewCell.h"
@interface CSSearchTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIButton *consultButton;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)clickConsultButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *touxianLabel;
@property (weak, nonatomic) IBOutlet UIView *xinjindashiView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xinjindashiLeft68Constranint;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *pingFenLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *danLabel;

@property (weak, nonatomic) IBOutlet UILabel *renLabel;
@property (weak, nonatomic) IBOutlet UILabel *huifuLabel;
@end
@implementation CSSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.searchView.layer.cornerRadius = 5;
    self.searchView.layer.masksToBounds = YES;
    
    self.consultButton.layer.cornerRadius = 5;
    self.consultButton.layer.masksToBounds = YES;
    
    self.touxianLabel.layer.cornerRadius = 7;
    self.touxianLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)clickConsultButtonDone:(id)sender {
    
    
    [[CSUtility getCurrentViewController] performSegueWithIdentifier:@"AfterPayMoneyChatViewController" sender:self];
}
- (void)setModel:(ManyDaShiModel *)model {
    
    _model = model;
    
    self.nameLabel.text = model.name;
    
    self.touxianLabel.text = model.level;
    
    if (csCharacterIsBlank(model.level)) {
        self.xinjindashiLeft68Constranint.constant = 10;
        self.touxianLabel.hidden = YES;
    } else {
        self.xinjindashiLeft68Constranint.constant = 68;
        self.touxianLabel.hidden = NO;
    }
    
    if (model.is_new) {
        self.xinjindashiView.hidden = NO;
    } else {
        self.xinjindashiView.hidden = YES;
    }
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@",model.speciality];
    
    self.danLabel.text = [NSString stringWithFormat:@"%@单",model.order_num];
    
    self.renLabel.text = [NSString stringWithFormat:@"%@人",model.keep_num];

    self.huifuLabel.text = [NSString stringWithFormat:@"平均%@min回复",model.avg_return];

    if (csCharacterIsBlank(model.price)) {
        self.priceLabel.text = @"";
        self.consultButton.hidden = YES;
    } else {
        if (model.price.floatValue <= 0) {
            self.priceLabel.text = @"免费";
            self.consultButton.hidden = NO;
        }else {
            self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
            self.consultButton.hidden = YES;
        }
    }
   
    
    if (model.skille.count == 0) {
        
        self.firstShanChangLabel.text = @"";
        
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
        
    }
    
    if (model.skille.count >= 1) {
        self.firstShanChangLabel.text = model.skille[0];
    } else {
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 2) {
        self.secondShanChangLabel.text = model.skille[1];
    }else {
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 3) {
        self.thirdShanChangLabel.text = model.skille[2];
    }
    
  
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    
    
    self.pingFenLabel.text = [NSString stringWithFormat:@"评分%@",model.grade];
    
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
