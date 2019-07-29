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
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UISwitch *morenSwitch;
- (IBAction)clickChangeOrAddButton:(UIButton *)sender;

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
    
    if (!csCharacterIsBlank(self.passModel.shipp_id)) {
        self.nameTextField.text = self.passModel.shipp_name;
        self.phoneTextField.text = self.passModel.shipp_phone;
        self.addressTextField.text = self.passModel.shipp_address;
        if (self.passModel.status) {
            self.morenSwitch.on = YES;
        } else {
            self.morenSwitch.on = NO;
        }
    }
}

- (void)configNavigationBar {
    
    
    self.title = @"收货地址";
    
    WhiteNavigationBarColor
    
}


- (IBAction)clickChangeOrAddButton:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if (!csCharacterIsBlank(self.passModel.shipp_id)) {
        //change
        NSMutableDictionary *para = @{}.mutableCopy;
        
        para[@"shipp_id"] = self.passModel.shipp_id;
        para[@"shipp_name"] = self.nameTextField.text;
        para[@"shipp_phone"] = self.phoneTextField.text;
        para[@"shipp_address"] = self.addressTextField.text;
        if (self.morenSwitch.isOn) {
            para[@"status"] = @"1";

        } else {
            para[@"status"] = @"0";

        }
        [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_User_Setaddress Pameters:para success:^(id  _Nonnull responseObject) {
            if (CSInternetRequestSuccessful) {
                CustomWrongMessage(@"修改成功!");
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                CSShowWrongMessage
            }
        } failure:^(NSError * _Nonnull error) {
            CSInternetFailure
        }];
        
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"shipp_name"] = self.nameTextField.text;
    para[@"shipp_phone"] = self.phoneTextField.text;
    para[@"shipp_address"] = self.addressTextField.text;
    if (self.morenSwitch.isOn) {
        para[@"status"] = @"1";
        
    } else {
        para[@"status"] = @"0";
        
    }
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_User_address Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"添加成功!");
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
    
}
@end
