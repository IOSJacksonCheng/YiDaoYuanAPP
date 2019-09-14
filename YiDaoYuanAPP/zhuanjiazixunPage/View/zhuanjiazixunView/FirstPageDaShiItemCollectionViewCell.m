//
//  FirstPageDaShiItemCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FirstPageDaShiItemCollectionViewCell.h"
@interface FirstPageDaShiItemCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstImageView;

@property (weak, nonatomic) IBOutlet UILabel *bottomFirstLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomSecondLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomThirdLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSecondXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomtopThirdXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFourthXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFifthImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottom1NameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authImageView;

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UIView *secondView;


@end
@implementation FirstPageDaShiItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(DaShiFirstPageModel *)model {
    
    _model = model;
    
    
    [self.bottomFirstImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    
    self.bottom1NameLabel.text = model.master_name;
    
        
    self.bottomFirstLabel.text = @"";
        
    self.bottomSecondLabel.text = @"";
        
    self.bottomThirdLabel.text = @"";
    
    self.firstView.hidden = YES;
    
    self.secondView.hidden = YES;
    
    if (model.is_auth) {
        
        self.authImageView.hidden = NO;
        
    } else {
        
        self.authImageView.hidden = YES;
    }
    
    
    if (model.skille.count == 1) {
    
        self.bottomFirstLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    
    }else if (model.skille.count == 2) {
        self.bottomFirstLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];

        self.bottomSecondLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
        self.firstView.hidden = NO;
    }else if (model.skille.count == 3) {
        self.bottomFirstLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
        self.bottomSecondLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];

        self.bottomThirdLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
        self.firstView.hidden = NO;

        self.secondView.hidden = NO;
        
    }
    
    
    
    if (model.grade.intValue == 0) {
        self.bottomFirstXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomSecondXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomtopThirdXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView.image = DotaImageName(@"icon_weishou");
        
    } else if (model.grade.intValue == 1) {
        self.bottomFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomtopThirdXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 2) {
        self.bottomFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 3) {
        self.bottomFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 4) {
        self.bottomFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 5) {
        self.bottomFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView.image = DotaImageName(@"icon_collect");
        self.bottomFifthImageView.image = DotaImageName(@"icon_collect");
        
        
    }
    
    
}
@end
