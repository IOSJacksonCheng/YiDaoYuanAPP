//
//  ZJZXFirstRowTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXFirstRowTableViewCell.h"
#import "YiDaoKeTangListViewController.h"
@interface ZJZXFirstRowTableViewCell()


@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *shiyecaiyunView;
@property (weak, nonatomic) IBOutlet UIView *mingyunxiangpiView;
@property (weak, nonatomic) IBOutlet UIView *zanbuduanshiViw;
@property (weak, nonatomic) IBOutlet UIView *hunlianqinggangView;
@property (weak, nonatomic) IBOutlet UIView *rightNowConsultView;
@property (weak, nonatomic) IBOutlet UIView *playContactView;
@property (weak, nonatomic) IBOutlet UIView *shoppingView;

@property (weak, nonatomic) IBOutlet UIView *jiankanyangshengView;

@property (weak, nonatomic) IBOutlet UIView *xingzuoyunshiView;
@property (weak, nonatomic) IBOutlet UIView *laohuanliView;

@property (weak, nonatomic) IBOutlet UIView *zhougongjiemengView;
@property (weak, nonatomic) IBOutlet UIView *haomayuceView;

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
    
    
    UITapGestureRecognizer *newsTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPlayContactViewDone)];
    
    newsTap6.numberOfTapsRequired = 1;
    
    newsTap6.numberOfTouchesRequired = 1;
    
    [self.playContactView addGestureRecognizer:newsTap6];
    
    UITapGestureRecognizer *newsTap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShoppingViewDone)];
    
    newsTap7.numberOfTapsRequired = 1;
    
    newsTap7.numberOfTouchesRequired = 1;
    
    [self.shoppingView addGestureRecognizer:newsTap7];
    
    
    UITapGestureRecognizer *newsTap8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickJianKangYangShengView)];
    
    newsTap8.numberOfTapsRequired = 1;
    
    newsTap8.numberOfTouchesRequired = 1;
    
    [self.jiankanyangshengView addGestureRecognizer:newsTap8];
    
    
    UITapGestureRecognizer *newsTap9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickZhouGongJieMengView)];
    
    newsTap9.numberOfTapsRequired = 1;
    
    newsTap9.numberOfTouchesRequired = 1;
    
    [self.zhougongjiemengView addGestureRecognizer:newsTap9];
    
    UITapGestureRecognizer *newsTap10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xingZuoYunShiView)];
    
    newsTap10.numberOfTapsRequired = 1;
    
    newsTap10.numberOfTouchesRequired = 1;
    
    [self.xingzuoyunshiView addGestureRecognizer:newsTap10];
    
    UITapGestureRecognizer *newsTap11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickhaomayuceView)];
    
    newsTap11.numberOfTapsRequired = 1;
    
    newsTap11.numberOfTouchesRequired = 1;
    
    [self.haomayuceView addGestureRecognizer:newsTap11];
    
    UITapGestureRecognizer *newsTap12 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicklaohuanliView)];
    
    newsTap12.numberOfTapsRequired = 1;
    
    newsTap12.numberOfTouchesRequired = 1;
    
    [self.laohuanliView addGestureRecognizer:newsTap12];
    
}

- (void)clicklaohuanliView {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner-1" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickhaomayuceView {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner-1" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)xingZuoYunShiView {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner-1" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickZhouGongJieMengView {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner-1" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}
- (void)clickJianKangYangShengView {
    [[NSUserDefaults standardUserDefaults] setValue:@"banner-1" forKey:@"imageString"];
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
}

- (void)clickShoppingViewDone {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"shoppingStoryboard"];
}
- (void)clickPlayContactViewDone {
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"PlayContactViewController" sender:self];
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
