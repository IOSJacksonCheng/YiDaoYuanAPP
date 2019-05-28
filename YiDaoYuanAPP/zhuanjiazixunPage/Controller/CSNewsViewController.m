//
//  CSNewsViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSNewsViewController.h"

@interface CSNewsViewController ()
@property (weak, nonatomic) IBOutlet UIView *shareView;

@end

@implementation CSNewsViewController

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
    self.title = @"行业资讯";
    
    F3f3f3NavigationBarColor
    
    
    
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
