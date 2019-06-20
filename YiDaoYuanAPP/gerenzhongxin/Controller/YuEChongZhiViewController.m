//
//  YuEChongZhiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YuEChongZhiViewController.h"

@interface YuEChongZhiViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;
- (IBAction)clickMoneyButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *successView;
- (IBAction)clickSurePayButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *remindView;
@end

@implementation YuEChongZhiViewController

- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    
    
}

- (void)configSubViews {
    
    
    
    self.successView.hidden = YES;
    self.remindView.layer.cornerRadius = 5;
    self.remindView.layer.masksToBounds = YES;
    
    [self changeButtonStatus:1];
    
    
    self.surePayButton.layer.cornerRadius = 5;
    
    self.button1.layer.borderWidth = 1;
    self.button1.layer.borderColor = csBlueColor.CGColor;
    self.button1.layer.cornerRadius = 5;
    
    self.button2.layer.borderWidth = 1;
    self.button2.layer.borderColor = csBlueColor.CGColor;
    self.button2.layer.cornerRadius = 5;
    
    self.button3.layer.borderWidth = 1;
    self.button3.layer.borderColor = csBlueColor.CGColor;
    self.button3.layer.cornerRadius = 5;
    
    self.button4.layer.borderWidth = 1;
    self.button4.layer.borderColor = csBlueColor.CGColor;
    self.button4.layer.cornerRadius = 5;
    
    self.button5.layer.borderWidth = 1;
    self.button5.layer.borderColor = csBlueColor.CGColor;
    self.button5.layer.cornerRadius = 5;
    
    self.button6.layer.borderWidth = 1;
    self.button6.layer.borderColor = csBlueColor.CGColor;
    self.button6.layer.cornerRadius = 5;
    
    self.button7.layer.borderWidth = 1;
    self.button7.layer.borderColor = csBlueColor.CGColor;
    self.button7.layer.cornerRadius = 5;
    
    self.button8.layer.borderWidth = 1;
    self.button8.layer.borderColor = csBlueColor.CGColor;
    self.button8.layer.cornerRadius = 5;
    
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"充值";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (IBAction)clickMoneyButtonDone:(UIButton *)sender {
    
    [self changeButtonStatus:sender.tag];
    
}

- (IBAction)clickSurePayButtonDone:(UIButton *)sender {
    
    self.successView.hidden = NO;
    
}
- (void)changeButtonStatus:(NSInteger)tag {
    if (tag == 1) {
        self.button1.backgroundColor = csBlueColor;
        [self.button1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button1.backgroundColor = UIColor.whiteColor;
        [self.button1 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 2) {
        self.button2.backgroundColor = csBlueColor;
        [self.button2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button2.backgroundColor = UIColor.whiteColor;
        [self.button2 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 3) {
        self.button3.backgroundColor = csBlueColor;
        [self.button3 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button3.backgroundColor = UIColor.whiteColor;
        [self.button3 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 4) {
        self.button4.backgroundColor = csBlueColor;
        [self.button4 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button4.backgroundColor = UIColor.whiteColor;
        [self.button4 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 5) {
        self.button5.backgroundColor = csBlueColor;
        [self.button5 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button5.backgroundColor = UIColor.whiteColor;
        [self.button5 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 6) {
        self.button6.backgroundColor = csBlueColor;
        [self.button6 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button6.backgroundColor = UIColor.whiteColor;
        [self.button6 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 7) {
        self.button7.backgroundColor = csBlueColor;
        [self.button7 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button7.backgroundColor = UIColor.whiteColor;
        [self.button7 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 8) {
        self.button8.backgroundColor = csBlueColor;
        [self.button8 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button8.backgroundColor = UIColor.whiteColor;
        [self.button8 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
}

@end
