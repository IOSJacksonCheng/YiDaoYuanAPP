//
//  NewAddressViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "NewAddressViewController.h"

@interface NewAddressViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation NewAddressViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}
- (void)configTableView {
    
    
    
    
    
    
}

- (void)configSubViews {
    
    self.sureButton.layer.cornerRadius = 7;
}

- (void)configNavigationBar {
    
    
    self.title = @"收货地址";
    
    WhiteNavigationBarColor
    
}


@end
