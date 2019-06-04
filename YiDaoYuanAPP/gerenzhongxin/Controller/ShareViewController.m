//
//  ShareViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *moneyView;

- (IBAction)clickDealButtonDone:(id)sender;

- (IBAction)clickIntroduceButtonDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *csCopyButton;

@end

@implementation ShareViewController

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
    
    
    UIView *topBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 165)];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    
    gradient.endPoint = CGPointMake(1, 0);
    
    gradient.frame =topBackgroundView.frame;
    
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"0D71C8"].CGColor,(id)[UIColor colorWithHexString:@"549DDD"].CGColor,nil];
    
    
    [self.topView.layer insertSublayer:gradient atIndex:0];
    
    self.csCopyButton.layer.cornerRadius = 5;
    self.csCopyButton.layer.borderWidth = 1;
    self.csCopyButton.layer.borderColor = cs999999Color.CGColor;
    
    
    self.moneyView.layer.cornerRadius = 5;
    
}

- (void)configNavigationBar {
    
    
    self.title = @"邀请分享";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_share-2") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickShareButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)clickShareButtonDone {
    
}


- (IBAction)clickDealButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"ZhangDanViewController" sender:self];
    
}

- (IBAction)clickIntroduceButtonDone:(id)sender {
    
    
     [self performSegueWithIdentifier:@"FengXiangZhuangViewController" sender:self];
}
@end
