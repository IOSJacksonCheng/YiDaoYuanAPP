//
//  SureOrderWriteMessageViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "SureOrderWriteMessageViewController.h"
#import "SureOrderCourseTableViewCell.h"
@interface SureOrderWriteMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;

@end

@implementation SureOrderWriteMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderCourseTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 73;
}
- (void)configSubViews {
    self.surePayButton.layer.cornerRadius = 5;
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"填写信息";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SureOrderCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    cell.secondLabel.textColor = csBlueColor;
    cell.secondImageView.image = DotaImageName(@"icon_2_zhifu_pre");
    return cell;
}
@end
