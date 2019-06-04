//
//  ChengShiHeHuoRenViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChengShiHeHuoRenViewController.h"

@interface ChengShiHeHuoRenViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation ChengShiHeHuoRenViewController

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
    
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
    
    self.nameTextField.layer.cornerRadius = 5;
    self.nameTextField.layer.borderWidth = 1;
    self.nameTextField.layer.borderColor = [UIColor colorWithHexString:@"#B2B2B2"].CGColor;
    
    self.phoneTextField.layer.cornerRadius = 5;
    self.phoneTextField.layer.borderWidth = 1;
    self.phoneTextField.layer.borderColor = [UIColor colorWithHexString:@"#B2B2B2"].CGColor;
    
    
    self.cityTextField.layer.cornerRadius = 5;
    self.cityTextField.layer.borderWidth = 1;
    self.cityTextField.layer.borderColor = [UIColor colorWithHexString:@"#B2B2B2"].CGColor;
}

- (void)configNavigationBar {
    
    
    self.title = @"城市合伙人";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}


@end
