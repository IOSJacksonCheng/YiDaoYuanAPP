//
//  YiDaoKeTangContentViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangContentViewController.h"

@interface YiDaoKeTangContentViewController ()
@property (weak, nonatomic) IBOutlet UIView *shareView;

@end

@implementation YiDaoKeTangContentViewController

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
    self.title = @"详情内容";
    
    F3f3f3NavigationBarColor
    
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    UIButton *rightButton = [[UIButton alloc] init];
    
    
    [rightButton setImage:DotaImageName(@"icon_fenxiang") forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(clickButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
}

- (void)clickButtonDone {
    self.shareView.hidden = NO;
}

@end
