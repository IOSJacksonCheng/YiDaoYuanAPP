//
//  ZJZXFirstRowTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXFirstRowTableViewCell.h"
@interface ZJZXFirstRowTableViewCell()


@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *shiyecaiyunView;
@property (weak, nonatomic) IBOutlet UIView *mingyunxiangpiView;
@property (weak, nonatomic) IBOutlet UIView *zanbuduanshiViw;
@property (weak, nonatomic) IBOutlet UIView *hunlianqinggangView;
@property (weak, nonatomic) IBOutlet UIView *rightNowConsultView;

@end
@implementation ZJZXFirstRowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNewsButtonDone)];
    
    newsTap.numberOfTapsRequired = 1;
    
    newsTap.numberOfTouchesRequired = 1;
    
    [self.newsView addGestureRecognizer:newsTap];
    
    UITapGestureRecognizer *newsTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickshiyecaiyunViewDone)];
    
    newsTap1.numberOfTapsRequired = 1;
    
    newsTap1.numberOfTouchesRequired = 1;
    
    [self.shiyecaiyunView addGestureRecognizer:newsTap1];
    
    
    UITapGestureRecognizer *newsTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickmingyunxiangpiViewDone)];
    
    newsTap2.numberOfTapsRequired = 1;
    
    newsTap2.numberOfTouchesRequired = 1;
    
    [self.mingyunxiangpiView addGestureRecognizer:newsTap2];
    
    
    UITapGestureRecognizer *newsTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickzanbuduanshiViwDone)];
    
    newsTap3.numberOfTapsRequired = 1;
    
    newsTap3.numberOfTouchesRequired = 1;
    
    [self.zanbuduanshiViw addGestureRecognizer:newsTap3];
    
    
    UITapGestureRecognizer *newsTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhunlianqinggangViewDone)];
    
    newsTap4.numberOfTapsRequired = 1;
    
    newsTap4.numberOfTouchesRequired = 1;
    
    [self.hunlianqinggangView addGestureRecognizer:newsTap4];
    

    
    UITapGestureRecognizer *newsTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightNowConsultViewDone)];
    
    newsTap5.numberOfTapsRequired = 1;
    
    newsTap5.numberOfTouchesRequired = 1;
    
    [self.rightNowConsultView addGestureRecognizer:newsTap5];
}
- (void)clickRightNowConsultViewDone {
    
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"RightNowConsultViewController" sender:self];
}
- (void)clickhunlianqinggangViewDone {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner-1" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickzanbuduanshiViwDone {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner4" forKey:@"imageString"];
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickmingyunxiangpiViewDone {
        [[NSUserDefaults standardUserDefaults] setValue:@"banner3" forKey:@"imageString"];
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickshiyecaiyunViewDone {
        [[NSUserDefaults standardUserDefaults] setValue:@"banner2" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickNewsButtonDone {
    
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"IndustryNewsViewController" sender:self];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
