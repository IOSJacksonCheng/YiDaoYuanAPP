//
//  LoginInViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LoginInViewController.h"

@interface LoginInViewController ()
- (IBAction)ckickRegisterButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *secureTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)clickLoginButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showSecureButton;
- (IBAction)clickShowSecureButtonDone:(id)sender;
- (IBAction)clickForgetSecureNumberDone:(id)sender;

@end

@implementation LoginInViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
 
}

- (void)configSubViews {
    self.loginButton.layer.cornerRadius = 24;
}
- (void)configNavigationBar {
    
}


- (IBAction)ckickRegisterButtonDone:(id)sender {
    
   
    
}
- (IBAction)clickLoginButtonDone:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
                [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
//    if (csCharacterIsBlank(self.phoneTextField.text) || csCharacterIsBlank(self.secureTextField.text)) {
//
//        CustomWrongMessage(@"请填写完整信息")
//        return;
//    }
//
//    NSMutableDictionary *para = @{}.mutableCopy;
//    para[@"cspameter"] = self.phoneTextField.text;
//    para[@"password"] = self.secureTextField.text;
//    para[@"device_type"] = @"iphone";
//    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Login Pameters:para success:^(id  _Nonnull responseObject) {
//
//        if (CSInternetRequestSuccessful) {
//
//
//            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"token"]] forKey:@"CSGetToken"];
//
//              [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"token"]] forKey:@"CSGetToken"];
//
//            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//            [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
//        }else {
//
//            CSShowWrongMessage
//
//        }
//    } failure:^(NSError * _Nonnull error) {
//        CSInternetFailure
//    }];
    
    
}
- (IBAction)clickShowSecureButtonDone:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        //show code
        self.secureTextField.secureTextEntry = NO;
        
        NSString *str  = self.secureTextField.text;
        
        self.secureTextField.text = @"";
        self.secureTextField.text = str;
        
    } else {
        self.secureTextField.secureTextEntry = YES;
    }
}

- (IBAction)clickForgetSecureNumberDone:(id)sender {
    
}
@end
