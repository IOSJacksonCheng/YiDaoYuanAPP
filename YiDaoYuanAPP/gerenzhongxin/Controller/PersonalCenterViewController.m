//
//  PersonalCenterViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalCenterViewController.h"

@interface PersonalCenterViewController ()
@property (weak, nonatomic) IBOutlet UIView *redCircleView;
@property (weak, nonatomic) IBOutlet UIView *consultView;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *myCollectView;
@property (weak, nonatomic) IBOutlet UIView *myJudgeView;
@property (weak, nonatomic) IBOutlet UIView *spendMoneyView;

@end

@implementation PersonalCenterViewController
- (void)viewWillAppear:(BOOL)animated {
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    
    BlueNavigationBarColor
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidAppear:(BOOL)animated {
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];

    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];

    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    [super viewDidAppear:animated];
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
    
    self.redCircleView.layer.cornerRadius = 4;
    
    self.redCircleView.layer.masksToBounds = YES;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickConsultViewDone)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [self.consultView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMyCollectViewDone)];
    
    tap1.numberOfTapsRequired = 1;
    
    tap1.numberOfTouchesRequired = 1;
    
    [self.myCollectView addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAnswerViewDone)];
    
    tap2.numberOfTapsRequired = 1;
    
    tap2.numberOfTouchesRequired = 1;
    
    [self.answerView addGestureRecognizer:tap2];
    
    
}
- (void)clickAnswerViewDone {
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"AnswerMyQuestionViewController" sender:self];
}
- (void)clickMyCollectViewDone {
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"MyCollectViewController" sender:self];
}
- (void)clickConsultViewDone {
    
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"ConsultOrderViewController" sender:self];
    
}
- (void)configNavigationBar {
    
    self.title = @"个人中心";
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_shezhi") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickLocationButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickLocationButtonDone {
   
    [self performSegueWithIdentifier:@"PersonalSetViewController" sender:self];
    
}

@end
