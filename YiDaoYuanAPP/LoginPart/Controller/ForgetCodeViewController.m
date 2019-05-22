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
    
    [self startTime];
    
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
                [self.secureNumberButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
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
@end
