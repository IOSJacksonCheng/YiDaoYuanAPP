//
//  QingShengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QingShengViewController.h"

@interface QingShengViewController ()
- (IBAction)clickQingShengGongFengButtonDone:(id)sender;

@end

@implementation QingShengViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    //    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //
    //    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MindDengTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MindDengTableViewCell)];
    //    self.tableView.rowHeight = 80;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    self.title = @"神仙供养";
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickQingShengGongFengButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"MingDengViewController" sender:self];
}
@end
