//
//  KefuChatViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "KefuChatViewController.h"
#import "IQKeyboardManager.h"

@interface KefuChatViewController ()<EaseMessageViewControllerDataSource>

@end

@implementation KefuChatViewController

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

    [self configSubViews];
    
}

- (void)configSubViews {
    
    
    [self.chatBarMoreView removeItematIndex:1];
    [self.chatBarMoreView removeItematIndex:3];
    [self.chatBarMoreView removeItematIndex:4];
    
    
    
    
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
    
    self.title = @"客服";
    
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
        model.avatarImage = DotaImageName(@"icon_kefu-1");//默认头像
        model.avatarURLPath = @"";//头像网络地址
        //        model.nickname = self.name;//用户昵称
        model.nickname = @"";
    }
    
    return model;
}


@end
