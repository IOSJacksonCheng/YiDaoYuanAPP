//
//  CSCommonNavigationController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSCommonNavigationController.h"

@interface CSCommonNavigationController ()

@end

@implementation CSCommonNavigationController
+ (void)initialize {
    //使用Appearance对导航栏统一外观设置
//    UINavigationBar *bar = [UINavigationBar appearance];
    //1.设置背景图
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarbackground"] forBarMetrics:UIBarMetricsDefault];
    //2.设置导航栏的样式（设置为black色系时，影响状态栏为白色字）
//    [bar setBarStyle:UIBarStyleBlack];
    //3.设置左右按钮的渲染颜色
//    [bar setTintColor:[UIColor whiteColor]];
    //5.设置导航栏中标题文字的样式
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    //添加文字颜色的设置
//    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:20];
//    [bar setTitleTextAttributes:attributes];
//    UIBarButtonItem *navBarButtonAppearance = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]];
//
//    [navBarButtonAppearance setTitleTextAttributes:@{
//                                                     NSFontAttributeName:            [UIFont systemFontOfSize:0.1],
//                                                     NSForegroundColorAttributeName: [UIColor clearColor] }
//                                          forState:UIControlStateNormal];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
