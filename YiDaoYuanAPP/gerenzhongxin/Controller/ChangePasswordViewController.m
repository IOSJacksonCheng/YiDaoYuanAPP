//
//  ChangePasswordViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
}
- (void)configNavigationBar {
    
    F3f3f3NavigationBarColor
    
    self.title = @"修改密码";
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
    
    rightButton.titleLabel.font = csCharacterFont_18;
    
    [rightButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(clickSaveDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickSaveDone {
    
}



@end
