//
//  TiXianDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "TiXianDetailViewController.h"

@interface TiXianDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *zhanghaoTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickSureButtonDone:(id)sender;
@end

@implementation TiXianDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    
    
}

- (void)configSubViews {
    
    self.sureButton.layer.cornerRadius = 5;
    
    
}

- (void)configNavigationBar {
    
    
    self.title = @"支付宝提现";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}



- (IBAction)clickSureButtonDone:(id)sender {
    
    if (csCharacterIsBlank(self.nameTextField.text)||csCharacterIsBlank(self.zhanghaoTextField.text)) {
        CustomWrongMessage(@"请填写信息");
        return;
    }
    [self.simpleDelegate passname:self.nameTextField.text WithOrder:self.zhanghaoTextField.text];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
