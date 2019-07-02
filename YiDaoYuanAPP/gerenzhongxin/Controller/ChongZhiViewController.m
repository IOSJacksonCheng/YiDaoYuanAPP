//
//  ChongZhiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChongZhiViewController.h"

@interface ChongZhiViewController ()
@property (weak, nonatomic) IBOutlet UIButton *yuEButton;
@property (weak, nonatomic) IBOutlet UIButton *yidaoYuanButton;
- (IBAction)clickChongZhiButtonDone:(UIButton *)sender;

@end

@implementation ChongZhiViewController

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
    
    self.yuEButton.layer.cornerRadius = 5;
    
    self.yidaoYuanButton.layer.cornerRadius = 5;

}

- (void)configNavigationBar {
    
    
    self.title = @"充值";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (IBAction)clickChongZhiButtonDone:(UIButton *)sender {
    if (sender.tag == 0) {
        //yu e chongzhi
        [self performSegueWithIdentifier:@"YuEChongZhiViewController" sender:self];
    } else if (sender.tag == 1) {
        //yidaoyuan chongzhi
        
         [self performSegueWithIdentifier:@"YiDaoYuanChongZhiViewController" sender:self];
    }
}
@end