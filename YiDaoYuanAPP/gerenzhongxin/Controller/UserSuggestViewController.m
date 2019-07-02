//
//  UserSuggestViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserSuggestViewController.h"

@interface UserSuggestViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@property (weak, nonatomic) IBOutlet UILabel *remindLabel;

@property (weak, nonatomic) IBOutlet UILabel *zishuLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)clickSubmitButtonDone:(id)sender;

@end

@implementation UserSuggestViewController

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
    
 
    
}

- (void)configNavigationBar {
    
    
    self.title = @"意见反馈";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length >= 200) {
        
        textView.text = [textView.text substringToIndex:200];
        
        self.zishuLabel.text = @"200";
        return;
    }
    if (textView.text.length > 0) {
        self.remindLabel.hidden = YES;
    } else {
        self.remindLabel.hidden = NO;
    }
    self.zishuLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)textView.text.length];
}
- (IBAction)clickSubmitButtonDone:(id)sender {
    
    if (csCharacterIsBlank(self.inputTextView.text)) {
        CustomWrongMessage(@"请填写要反馈的内容");
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"contact"] = self.inputTextField.text;
    para[@"describe"] = self.inputTextView.text;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_User_Feedback Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"提交成功");
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
@end
