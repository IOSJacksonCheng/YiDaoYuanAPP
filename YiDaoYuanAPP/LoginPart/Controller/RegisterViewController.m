//
//  RegisterViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
- (IBAction)ckickRegisterButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *secureTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *showSecureButton;
- (IBAction)clickShowSecureButtonDone:(id)sender;
- (IBAction)clickSecureNumberDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *secureNumberButton;
@property (weak, nonatomic) IBOutlet UIButton *agreenButton;
- (IBAction)clickAgreenButtonDone:(UIButton *)sender;
- (IBAction)clickWechatButtonDone:(UIButton *)sender;
- (IBAction)clickQQButtonDone:(id)sender;
- (IBAction)clickBackButtonDone:(id)sender;
//短信验证码
@property (weak, nonatomic) IBOutlet UITextField *secureCodeTextField;


@property (weak, nonatomic) IBOutlet UIView *successView;

- (IBAction)clickGoLoginButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *goLoginButton;
- (IBAction)clickCloseButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self configSubViews];
}

- (void)configSubViews {
    self.registerButton.layer.cornerRadius = 24;
    self.goLoginButton.layer.cornerRadius = 10;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}
- (IBAction)ckickRegisterButtonDone:(id)sender {
    
    self.successView.hidden = NO;
}
- (IBAction)clickSecureNumberDone:(id)sender {
    
    [self startTime];
    
}
- (IBAction)clickAgreenButtonDone:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)clickWechatButtonDone:(UIButton *)sender {
    
}

- (IBAction)clickQQButtonDone:(id)sender {
    
}

- (IBAction)clickBackButtonDone:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
                [self.secureNumberButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                self.secureNumberButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
- (IBAction)clickGoLoginButtonDone:(id)sender {
    self.successView.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickCloseButtonDone:(id)sender {
      self.successView.hidden = YES;
}
@end
