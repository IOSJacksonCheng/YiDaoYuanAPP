//
//  BaseViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    //主要是以下两个图片设置
    UIImage *iconImage = [DotaImageName(@"icon_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = iconImage;
    
 self.navigationController.navigationBar.backIndicatorTransitionMaskImage = iconImage;
    
    self.navigationItem.backBarButtonItem = backItem;
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
