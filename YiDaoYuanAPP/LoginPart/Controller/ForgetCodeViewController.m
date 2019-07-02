//
//  ForgetCodeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ForgetCodeViewController.h"

@interface ForgetCodeViewController ()

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

- (IBAction)clickBackButtonDone:(id)sender;

- (IBAction)clickSecureNumberDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *secureNumberButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *secureTextField;
@property (weak, nonatomic) IBOutlet UITextField *secureTwoTextField;

- (IBAction)clickShowCodeButtonDone:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *secureCodeTextField;
- (IBAction)clickSureButtonDone:(id)sender;
@end

@implementation ForgetCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
}

- (void)configSubViews {
    self.sureButton.layer.cornerRadius = 24;
}

- (IBAction)clickSecureNumberDone:(id)sender {
    if (csCharacterIsBlank(self.phoneTextField.text)) {
        CustomWrongMessage(@"填写手机号码");
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"username"] = self.phoneTextField.text;
    [CSNetManager sendPostRequestWithNeedToken:NO Url:CSURL_Verification_code Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"验证码已经发送到你手机");
            [self startTime];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];

    
}




- (IBAction)clickBackButtonDone:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//发送验证码显示按钮时间
- (void)startTime {
    __block int timeout = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.secureNumberButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.secureNumberButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            if (timeout == 60) {
                seconds = 60;
            }
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.secureNumberButton setTitle:[NSString stringWithFormat:@"%@秒重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.secureNumberButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)clickShowCodeButtonDone:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.tag == 1) {
        if (sender.selected) {
            //show code
            self.secureTwoTextField.secureTextEntry = NO;
            
            NSString *str  = self.secureTwoTextField.text;
            
            self.secureTwoTextField.text = @"";
            self.secureTwoTextField.text = str;
            
        } else {
            self.secureTwoTextField.secureTextEntry = YES;
        }
    } else {
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
    
}
- (IBAction)clickSureButtonDone:(id)sender {
    
    if (csCharacterIsBlank(self.phoneTextField.text) || csCharacterIsBlank(self.secureTextField.text) || csCharacterIsBlank(self.secureCodeTextField.text) || csCharacterIsBlank(self.secureTwoTextField.text)) {
        CustomWrongMessage(@"填写完整信息");
        return;
    }
    if (![self.secureTextField.text isEqualToString:self.secureTwoTextField.text]) {
        CustomWrongMessage(@"两次输入密码不一致!");
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"username"] = self.phoneTextField.text;
    para[@"password"] = self.secureTextField.text;
    para[@"verification_code"] = self.secureCodeTextField.text;
    
    [CSNetManager sendPostRequestWithNeedToken:NO Url:CSURL_PasswordReset Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"密码重置成功，请重新登录");
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
@end
