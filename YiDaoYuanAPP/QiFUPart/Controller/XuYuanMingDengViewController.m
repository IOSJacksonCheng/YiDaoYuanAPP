//
//  XuYuanMingDengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "XuYuanMingDengViewController.h"

@interface XuYuanMingDengViewController ()
- (IBAction)goNextButtonDone:(id)sender;

@end

@implementation XuYuanMingDengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"明灯许愿";
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self getRightButton];
    
}
- (void)getRightButton {
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"icon_more-2") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.rightBarButtonItem = leftItem;
}
- (void)clickRightButtonDone {
    
     [self performSegueWithIdentifier:@"MingDengExplainViewController" sender:self];
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goNextButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"MingDengViewController" sender:self];
}
@end
