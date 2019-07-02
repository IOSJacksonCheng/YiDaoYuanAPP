//
//  ChangePasswordViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldTextField;

@property (weak, nonatomic) IBOutlet UITextField *CSnewTextField;
@property (weak, nonatomic) IBOutlet UITextField *againTF;

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
}
- (void)configNavigationBar {
    
    F3f3f3NavigationBarColor
    
    self.title = @"修改密码";
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    rightButton.titleLabel.font = csCharacterFont_18;
    
    [rightButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(clickSaveDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickSaveDone {
    
    if (csCharacterIsBlank(self.CSnewTextField.text) || csCharacterIsBlank(self.oldTextField.text) || csCharacterIsBlank(self.againTF.text)) {
        CustomWrongMessage(@"请填写完整信息");
        return;
    }
    if ([self.CSnewTextField.text isEqualToString:self.againTF.text]) {
        CustomWrongMessage(@"两次密码输入不一致");
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定修改信息吗" preferredStyle:UIAlertControllerStyleAlert];
    //2.创建界面上的按钮
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary *para = @{}.mutableCopy;
        
        para[@"old_password"] = self.oldTextField.text;
        
        para[@"password"] = self.CSnewTextField.text;
        
        para[@"confirm_password"] = self.againTF.text;
        
        [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_ChangePassword Pameters:para success:^(id  _Nonnull responseObject) {
            if (CSInternetRequestSuccessful) {
                CustomWrongMessage(@"修改成功!");
            }else {
                CSShowWrongMessage
            }
        } failure:^(NSError * _Nonnull error) {
            CSInternetFailure
        }];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //3.将按钮添加到AlertController中
    [alert addAction:actionNo];
    [alert addAction:actionYes];
    //5.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
}



@end
