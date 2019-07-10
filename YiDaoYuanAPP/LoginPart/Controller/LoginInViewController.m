//
//  LoginInViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LoginInViewController.h"

#import "WXApi.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
@interface LoginInViewController ()<WXApiDelegate, TencentSessionDelegate>
- (IBAction)ckickRegisterButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *secureTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)clickLoginButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showSecureButton;
- (IBAction)clickShowSecureButtonDone:(id)sender;
- (IBAction)clickForgetSecureNumberDone:(id)sender;
@property (nonatomic,strong) TencentOAuth *tencentOAuth;


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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoginCode:) name:@"WXLoginstatus_Notification" object:nil];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)configNavigationBar {
    
}
- (void)getLoginCode:(NSNotification *)info {


    [self sendPostRequestWithCodeInfo:info.object];
}

- (IBAction)ckickRegisterButtonDone:(id)sender {
    
   
    
}
- (IBAction)clickLoginButtonDone:(id)sender {

    
    [self sendPostRequest];
    
    
}
- (void)sendPostRequest {
//
//    if (csCharacterIsBlank(self.phoneTextField.text) || csCharacterIsBlank(self.secureTextField.text)) {
//
//        CustomWrongMessage(@"请填写完整信息")
//        return;
//    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"username"] = @"18320760679";
    para[@"password"] = @"123123";
//    para[@"username"] = self.phoneTextField.text;
//    para[@"password"] = self.secureTextField.text;
    para[@"device_type"] = @"iphone";
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Login Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            
            [self handleResult:CSGetResult];
            
        }else {
            
            CSShowWrongMessage
            
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
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

- (IBAction)clickWechatButtonDone:(UIButton *)sender {
    [self sendWXAuthReq];
    
    
    
    
}
- (void)sendWXAuthReq{
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        
        [WXApi sendReq:req];//发起微信授权请求
    }else{
        
        //提示：未安装微信应用或版本过低
    }
}


- (void)sendPostRequestWithCodeInfo:(NSString *)codeInfo {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"code"] = codeInfo;
    para[@"device_type"] = @"iphone";

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Login_wechat Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            [self handleResult:CSGetResult];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (IBAction)clickQQButtonDone:(id)sender {
    
    [self qqLogin];
    
}

- (void)qqLogin
{
    self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"1108888010" andDelegate:self];
    
    NSMutableArray *permission = [@[] mutableCopy];
    
    permission = [NSMutableArray arrayWithObjects:@"get_user_info",@"get_simple_userinfo",nil];
    
    [self.tencentOAuth authorize:permission inSafari:NO];
}

#pragma mark --------- qq登录状态回调  TencentSessionDelegate-------
- (void)tencentDidLogin{
    if (!_tencentOAuth.accessToken){
        CSLog(@"%@ == %@",_tencentOAuth.accessToken,_tencentOAuth.openId);
        [self.tencentOAuth getUserInfo];
        
    } else {
        
            CSLog(@"登录失败！没有获取到accessToken");
        
    }
    
}

- (void)tencentDidNotLogin:(BOOL)cancelled

{
    
    if (cancelled)
        
    {
        
        CSLog(@"用户取消登录");
        
    }
    
    else
        
    {
        
        CSLog(@"登录失败");
        
    }
    
}

- (void)tencentDidNotNetWork

{
    
    CSLog(@"没有网络，无法登录");
    
}
- (void)getUserInfoResponse:(APIResponse *)response

{
    
    CSLog(@"%@",response.jsonResponse);
    
}


- (void)handleResult:(id)result {
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"token"]] forKey:@"CSGetToken"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"id"]] forKey:@"CS_UserID"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"sex"]] forKey:@"CS_Sex"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"birthday"]] forKey:@"CS_Birthday"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"coin"]] forKey:@"CS_Coin"];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"balance"]] forKey:@"CS_Balance"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"user_nickname"]] forKey:@"CS_User_Nickname"];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"avatar"]] forKey:@"CS_Avatar"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user"][@"mobile"]] forKey:@"CS_Mobile"];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:[CSUtility handleNumber:result[@"user"][@"is_master"]] forKey:@"CS_UserIsMaster"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CSIsLogin"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
}
@end
