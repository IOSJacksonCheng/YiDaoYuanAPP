//
//  EasyUIChatViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "EasyUIChatViewController.h"

#import "IQKeyboardManager.h"

#import "GoToJudgeViewController.h"
@interface EasyUIChatViewController ()<EaseMessageViewControllerDataSource>

@end

@implementation EasyUIChatViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
        [[IQKeyboardManager sharedManager] setEnable:YES];
        [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   
    
}
    
   
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configNavigationBar];
    
    
    self.dataSource = self;
//
//    self.showRefreshHeader = YES;
//    //首次进入加载数据
////    [self tableViewDidTriggerHeaderRefresh];
//
  [self configSubViews];
    
}

- (void)configSubViews {
    
    
    [self.chatBarMoreView removeItematIndex:1];
    [self.chatBarMoreView removeItematIndex:3];
    [self.chatBarMoreView removeItematIndex:4];

    
    if (!CS_UserIsMaster && !self.isDaShi) {
        
        
        UIButton *button = [[UIButton alloc] init];
        
        [self.view addSubview:button];
        [button addTarget:self action:@selector(clickEndConsult) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"结束咨询" forState:UIControlStateNormal];
        
        button.titleLabel.font = csCharacterFont_15;
        
        [button setTitleColor:csBlueColor forState:UIControlStateNormal];
        
        
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
    }
  
}

- (void)clickEndConsult {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_consult_finish Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            GoToJudgeViewController *new = [GoToJudgeViewController new];
            
            new.order_id = self.order_id;
            
            new.typestring = @"1";
            
            new.fromChatView = YES;

            [self.navigationController pushViewController:new animated:YES];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)clickLeftItem {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)configNavigationBar {
    
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickLeftItem) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    
    self.navigationItem.leftBarButtonItem = backItem;
    WhiteNavigationBarColor
    
    self.title = self.name;
   
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark -- delegate
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    
    //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    if (message.direction == EMMessageDirectionSend) {
        model.avatarImage = CSUserImagePlaceHolder;//默认头像
        model.avatarURLPath = CS_Avatar;//头像网络地址
//        model.nickname = CS_User_Nickname;//用户昵称
        model.nickname = @"";

    } else {
        model.avatarImage = CSUserImagePlaceHolder;//默认头像
        model.avatarURLPath = self.avater;//头像网络地址
//        model.nickname = self.name;//用户昵称
        model.nickname = @"";
    }
    
    return model;
}
- (void)sendVoiceMessageWithLocalPath:(NSString *)localPath duration:(NSInteger)duration {
    [super sendVoiceMessageWithLocalPath:localPath duration:duration];

    [CSUtility sendVoiceMessageWithLocalPath:localPath duration:duration WithOrderId:self.order_id];
}
- (void)sendTextMessage:(NSString *)text {
    [super sendTextMessage:text];
    [CSUtility sendTextMessage:text WithOrderId:self.order_id];
}

- (void)sendImageMessageWithData:(NSData *)imageData {
    
//    [super sendImageMessageWithData:imageData];
    
    [super sendImageMessage:[UIImage imageWithData:imageData]];
    
    [CSUtility sendImageMessage:[UIImage imageWithData:imageData] WithOrderId:self.order_id];

    
}
- (void)sendImageMessage:(UIImage *)image {
    [super sendImageMessage:image];
    [CSUtility sendImageMessage:image WithOrderId:self.order_id];

}

@end
