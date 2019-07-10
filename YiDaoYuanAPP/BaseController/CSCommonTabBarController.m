//
//  CSCommonTabBarController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSCommonTabBarController.h"
#import "CSTabBar.h"
@interface CSCommonTabBarController ()<UITabBarControllerDelegate, CSTabBarDelegate>
@property (nonatomic, strong) CSTabBar *myTabBar;
@end

@implementation CSCommonTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotationAnimation) name:@"cswillenterForeground" object:nil];
    self.delegate = self;
    for (UIViewController *vc in self.viewControllers)
    {
        UIImage *selectedImage = vc.tabBarItem.selectedImage;
        vc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    
    //获取UITabbarItem的样品实例
    UITabBarItem *barItem = [UITabBarItem appearance];
    
    //保存正常状态下的文本属性
    NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
    normalAttributes[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size: 10];
    normalAttributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [barItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
    
    //保存选中状态下的文本属性
    NSMutableDictionary *selectedAttributes = [NSMutableDictionary dictionary];
    selectedAttributes[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size: 10];
    selectedAttributes[NSForegroundColorAttributeName] = [UIColor colorWithRed:13/255.0 green:113/255.0 blue:200/255.0 alpha:1.0];
    
    [barItem setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    
    
    self.myTabBar = [[CSTabBar alloc]init];
    
    self.myTabBar.delegate = self;
    
    [self setValue:self.myTabBar forKey:@"tabBar"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self rotationAnimation];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)rotationAnimation{
    if ([@"key" isEqualToString:[self.myTabBar.centerButton.layer animationKeys].firstObject]){
        return;
    }
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 3.0;
    rotationAnimation.repeatCount = HUGE;
    [self.myTabBar.centerButton.layer addAnimation:rotationAnimation forKey:@"key"];
}
- (void)tabBarDidClickCenterButton:(CSTabBar *)tabBar
{
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QiFu" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QiFuStoryboard"];
    
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    //判断用户是否登陆
    
//    if (csCharacterIsBlank(CSGetToken) && [viewController.tabBarItem.title isEqualToString:@"我的"]) {
//        [CSUtility showLoginViewController];
//        return NO;
//
//    }
    
//    if ([viewController.tabBarItem.title isEqualToString:@"祈福"]) {
//        
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"QiFu" bundle:nil];
//        
//        [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QiFuStoryboard"];
//        
//        
//        return NO;
//    }
    return YES;
}

@end
