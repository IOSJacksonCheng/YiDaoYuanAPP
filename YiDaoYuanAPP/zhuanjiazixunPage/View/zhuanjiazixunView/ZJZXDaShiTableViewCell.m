//
//  ZJZXDaShiTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXDaShiTableViewCell.h"
@interface ZJZXDaShiTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *baziLabel;
@property (weak, nonatomic) IBOutlet UILabel *qumingLabel;
@property (weak, nonatomic) IBOutlet UILabel *fengshuiLabel;
@property (weak, nonatomic) IBOutlet UIView *topDaShiView;
@property (weak, nonatomic) IBOutlet UIView *firstDaShiView;
@property (weak, nonatomic) IBOutlet UIView *secondDaShiView;
@property (weak, nonatomic) IBOutlet UIView *thirdDaShiView;


@end
@implementation ZJZXDaShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.baziLabel.layer.cornerRadius = 3;
    self.baziLabel.layer.borderColor = csBlueColor.CGColor;
    self.baziLabel.layer.borderWidth = 1;
    
    self.qumingLabel.layer.cornerRadius = 3;
    self.qumingLabel.layer.borderColor = csBlueColor.CGColor;
    self.qumingLabel.layer.borderWidth = 1;
    
    self.fengshuiLabel.layer.cornerRadius = 3;
    self.fengshuiLabel.layer.borderColor = csBlueColor.CGColor;
    self.fengshuiLabel.layer.borderWidth = 1;
    
    
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
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
}
- (void)clicksecondDaShiViewDone {
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
}
- (void)clickfirstDaShiViewDone {
    
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];

}
- (void)clicktopDaShiViewDone {
    
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];

}
@end
