//
//  ShopTabBarController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/14.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopTabBarController.h"

@interface ShopTabBarController ()

@end

@implementation ShopTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
