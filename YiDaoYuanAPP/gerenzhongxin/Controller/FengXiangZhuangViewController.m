//
//  FengXiangZhuangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FengXiangZhuangViewController.h"

@interface FengXiangZhuangViewController ()
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)clickSaveButtonDone:(id)sender;

@end

@implementation FengXiangZhuangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];}

- (void)configTableView {
    
}
- (void)configSubViews {
    self.saveButton.layer.cornerRadius = 5;
    self.saveButton.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    self.title = @"分享赚";
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

- (IBAction)clickSaveButtonDone:(id)sender {
}
@end
