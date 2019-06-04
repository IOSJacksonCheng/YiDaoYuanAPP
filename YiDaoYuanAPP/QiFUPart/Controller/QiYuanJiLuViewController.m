//
//  QiYuanJiLuViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QiYuanJiLuViewController.h"
#import "QiFuJiLuTableViewCell.h"
@interface QiYuanJiLuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation QiYuanJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(QiFuJiLuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(QiFuJiLuTableViewCell)];
    self.tableView.rowHeight = 70;
   
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"祈愿记录";
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QiFuJiLuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(QiFuJiLuTableViewCell)];
    if (indexPath.row == 0) {
        cell.topView.hidden = YES;
    } else {
        cell.topView.hidden = NO;
    }
    return cell;
}
@end
