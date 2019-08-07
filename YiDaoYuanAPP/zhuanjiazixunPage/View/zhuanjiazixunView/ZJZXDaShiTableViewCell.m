//
//  ZJZXDaShiTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXDaShiTableViewCell.h"
#import "FirstPageModel.h"
@interface ZJZXDaShiTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *topFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *topSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *topThirdLabel;
@property (weak, nonatomic) IBOutlet UIView *topDaShiView;

@property (weak, nonatomic) IBOutlet UILabel *topNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topFirstXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topSecondXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topThirdXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topFourthXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topFifthImageView;
@property (weak, nonatomic) IBOutlet UILabel *topPingFengLabel;






@property (weak, nonatomic) IBOutlet UIView *firstDaShiView;

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





@property (weak, nonatomic) IBOutlet UIView *secondDaShiView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstImageView2;

@property (weak, nonatomic) IBOutlet UILabel *bottomFirstLabel2;

@property (weak, nonatomic) IBOutlet UILabel *bottomSecondLabel2;

@property (weak, nonatomic) IBOutlet UILabel *bottomThirdLabel2;

@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSecondXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *bottomtopThirdXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFourthXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFifthImageView2;
@property (weak, nonatomic) IBOutlet UILabel *bottom1NameLabel2;




@property (weak, nonatomic) IBOutlet UIView *thirdDaShiView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstImageView3;

@property (weak, nonatomic) IBOutlet UILabel *bottomFirstLabel3;

@property (weak, nonatomic) IBOutlet UILabel *bottomSecondLabel3;

@property (weak, nonatomic) IBOutlet UILabel *bottomThirdLabel3;

@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSecondXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *bottomtopThirdXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFourthXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFifthImageView3;
@property (weak, nonatomic) IBOutlet UILabel *bottom1NameLabel3;


@end
@implementation ZJZXDaShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.topFirstLabel.layer.cornerRadius = 3;
    self.topFirstLabel.layer.borderColor = csBlueColor.CGColor;
    self.topFirstLabel.layer.borderWidth = 1;
    
    self.topSecondLabel.layer.cornerRadius = 3;
    self.topSecondLabel.layer.borderColor = csBlueColor.CGColor;
    self.topSecondLabel.layer.borderWidth = 1;
    
    self.topThirdLabel.layer.cornerRadius = 3;
    self.topThirdLabel.layer.borderColor = csBlueColor.CGColor;
    self.topThirdLabel.layer.borderWidth = 1;
    
    
    UITapGestureRecognizer *newsTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicktopDaShiViewDone)];
    
    newsTap1.numberOfTapsRequired = 1;
    
    newsTap1.numberOfTouchesRequired = 1;
    
    [self.topDaShiView addGestureRecognizer:newsTap1];
    
    
    UITapGestureRecognizer *newsTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickfirstDaShiViewDone)];
    
    newsTap2.numberOfTapsRequired = 1;
    
    newsTap2.numberOfTouchesRequired = 1;
    
    [self.firstDaShiView addGestureRecognizer:newsTap2];
    
    
    UITapGestureRecognizer *newsTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicksecondDaShiViewDone)];
    
    newsTap3.numberOfTapsRequired = 1;
    
    newsTap3.numberOfTouchesRequired = 1;
    
    [self.secondDaShiView addGestureRecognizer:newsTap3];
    
    
    UITapGestureRecognizer *newsTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickthirdDaShiViewDone)];
    
    newsTap4.numberOfTapsRequired = 1;
    
    newsTap4.numberOfTouchesRequired = 1;
    
    [self.thirdDaShiView addGestureRecognizer:newsTap4];
    
}

- (void)clickthirdDaShiViewDone {
    FirstPageModel *model = self.daShiArray[3];
    
    [self.csDelegate passDaShiMasterId:model.master_id];
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
}
- (void)clicksecondDaShiViewDone {
    FirstPageModel *model = self.daShiArray[2];
    
    [self.csDelegate passDaShiMasterId:model.master_id];
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
}
- (void)clickfirstDaShiViewDone {
    
    FirstPageModel *model = self.daShiArray[1];
    
    [self.csDelegate passDaShiMasterId:model.master_id];
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
    

}
- (void)clicktopDaShiViewDone {
    
    FirstPageModel *model = self.daShiArray[0];
    
    [self.csDelegate passDaShiMasterId:model.master_id];
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];

}
- (void)setDaShiArray:(NSMutableArray *)daShiArray {
    
    _daShiArray = daShiArray;
    
    if (daShiArray.count == 0) {
    
        return;
    
    }
    
    FirstPageModel *model = daShiArray[0];
    
    self.topNameLabel.text = model.name;
    
    self.topPingFengLabel.text = [NSString stringWithFormat:@"评分:%@",model.grade];
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    if (model.skille.count == 0) {
        
        self.topFirstLabel.text = @"";
        
        self.topSecondLabel.text = @"";
        
        self.topThirdLabel.text = @"";
        
    }
    
    if (model.skille.count >= 1) {
        self.topFirstLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else {
        self.topSecondLabel.text = @"";
        
        self.topThirdLabel.text = @"";
    }
    if (model.skille.count >= 2) {
        self.topSecondLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
    }else {
        
        self.topThirdLabel.text = @"";
    }
    
    if (model.skille.count >= 3) {
        self.topThirdLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
    }
    
    
    
    if (model.grade.intValue == 0) {
        self.topFirstXingImageView.image = DotaImageName(@"icon_weishou");
        self.topSecondXingImageView.image = DotaImageName(@"icon_weishou");
        self.topThirdXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFifthImageView.image = DotaImageName(@"icon_weishou");
        
    } else if (model.grade.intValue == 1) {
        self.topFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.topSecondXingImageView.image = DotaImageName(@"icon_weishou");
        self.topThirdXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 2) {
        self.topFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.topSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.topThirdXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 3) {
        self.topFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.topSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.topThirdXingImageView.image = DotaImageName(@"icon_collect");
        self.topFourthXingImageView.image = DotaImageName(@"icon_weishou");
        self.topFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 4) {
        self.topFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.topSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.topThirdXingImageView.image = DotaImageName(@"icon_collect");
        self.topFourthXingImageView.image = DotaImageName(@"icon_collect");
        self.topFifthImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 5) {
        self.topFirstXingImageView.image = DotaImageName(@"icon_collect");
        self.topSecondXingImageView.image = DotaImageName(@"icon_collect");
        self.topThirdXingImageView.image = DotaImageName(@"icon_collect");
        self.topFourthXingImageView.image = DotaImageName(@"icon_collect");
        self.topFifthImageView.image = DotaImageName(@"icon_collect");
        
        
    }
   
    
    
    
    if (daShiArray.count <= 1) {
        self.firstDaShiView.hidden = YES;
        self.secondDaShiView.hidden = YES;
        self.thirdDaShiView.hidden = YES;
        return;
    }
     FirstPageModel *model1 = daShiArray[1];
    
    [self.bottomFirstImageView sd_setImageWithURL:[NSURL URLWithString:model1.avatar] placeholderImage:CSUserImagePlaceHolder];
    self.bottom1NameLabel.text = model1.name;
    if (model1.skille.count == 0) {
        
        self.bottomFirstLabel.text = @"";
        
        self.bottomSecondLabel.text = @"";
        
        self.bottomThirdLabel.text = @"";
        
    }
    
    if (model.skille.count >= 1) {
        self.bottomFirstLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else {
        self.bottomSecondLabel.text = @"";
        
        self.bottomThirdLabel.text = @"";
    }
    if (model.skille.count >= 2) {
        self.bottomSecondLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
    }else {
        
        self.bottomThirdLabel.text = @"";
    }
    
    if (model.skille.count >= 3) {
        self.bottomThirdLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
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
    
    
    
    
    
    if (daShiArray.count <= 2) {
        self.firstDaShiView.hidden = NO;
        self.secondDaShiView.hidden = YES;
        self.thirdDaShiView.hidden = YES;
        return;
    }
    FirstPageModel *model2 = daShiArray[2];
    
    [self.bottomFirstImageView2 sd_setImageWithURL:[NSURL URLWithString:model2.avatar] placeholderImage:CSUserImagePlaceHolder];
    self.bottom1NameLabel2.text = model2.name;
    if (model2.skille.count == 0) {
        
        self.bottomFirstLabel2.text = @"";
        
        self.bottomSecondLabel2.text = @"";
        
        self.bottomThirdLabel2.text = @"";
        
    }
    
    if (model2.skille.count >= 1) {
        self.bottomFirstLabel2.text = model2.skille[0];
    } else {
        self.bottomSecondLabel2.text = @"";
        
        self.bottomThirdLabel2.text = @"";
    }
    if (model2.skille.count >= 2) {
        self.bottomSecondLabel2.text = model2.skille[1];
    }else {
        
        self.bottomThirdLabel2.text = @"";
    }
    
    if (model2.skille.count >= 3) {
        self.bottomThirdLabel2.text = model2.skille[2];
    }
    
    
    
    if (model2.grade.intValue == 0) {
        self.bottomFirstXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomSecondXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomtopThirdXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView2.image = DotaImageName(@"icon_weishou");
        
    } else if (model2.grade.intValue == 1) {
        self.bottomFirstXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomtopThirdXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model2.grade.intValue == 2) {
        self.bottomFirstXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model2.grade.intValue == 3) {
        self.bottomFirstXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView2.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model2.grade.intValue == 4) {
        self.bottomFirstXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomFifthImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model2.grade.intValue == 54) {
        self.bottomFirstXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView2.image = DotaImageName(@"icon_collect");
        self.bottomFifthImageView2.image = DotaImageName(@"icon_collect");
        
        
    }
    
    
    if (daShiArray.count <= 3) {
        self.firstDaShiView.hidden = NO;
        self.secondDaShiView.hidden = NO;
        self.thirdDaShiView.hidden = YES;
        return;
    }
    FirstPageModel *model3 = daShiArray[3];
    
    [self.bottomFirstImageView3 sd_setImageWithURL:[NSURL URLWithString:model3.avatar] placeholderImage:CSUserImagePlaceHolder];
    self.bottom1NameLabel3.text = model3.name;
    if (model3.skille.count == 0) {
        
        self.bottomFirstLabel3.text = @"";
        
        self.bottomSecondLabel3.text = @"";
        
        self.bottomThirdLabel3.text = @"";
        
    }
    
    if (model3.skille.count >= 1) {
        self.bottomFirstLabel3.text = model3.skille[0];
    } else {
        self.bottomSecondLabel3.text = @"";
        
        self.bottomThirdLabel3.text = @"";
    }
    if (model3.skille.count >= 2) {
        self.bottomSecondLabel3.text = model3.skille[1];
    }else {
        
        self.bottomThirdLabel3.text = @"";
    }
    
    if (model3.skille.count >= 3) {
        self.bottomThirdLabel3.text = model3.skille[2];
    }
    
    
    
    if (model3.grade.intValue == 0) {
        self.bottomFirstXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomSecondXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomtopThirdXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView3.image = DotaImageName(@"icon_weishou");
        
    } else if (model3.grade.intValue == 1) {
        self.bottomFirstXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomtopThirdXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model3.grade.intValue == 2) {
        self.bottomFirstXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFourthXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model3.grade.intValue == 3) {
        self.bottomFirstXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView3.image = DotaImageName(@"icon_weishou");
        self.bottomFifthImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model3.grade.intValue == 4) {
        self.bottomFirstXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomFifthImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model3.grade.intValue == 54) {
        self.bottomFirstXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomSecondXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomtopThirdXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomFourthXingImageView3.image = DotaImageName(@"icon_collect");
        self.bottomFifthImageView3.image = DotaImageName(@"icon_collect");
        
        
    }
}

@end
