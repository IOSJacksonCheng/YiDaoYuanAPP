//
//  ConsultYiWanChengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultYiWanChengViewController.h"
#import "SureOrderDaShiInfomationTableViewCell.h"
#import "SureOrderCourseTableViewCell.h"
@interface ConsultYiWanChengViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end

@implementation ConsultYiWanChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderDaShiInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderCourseTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.cornerRadius = 25;
    
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.cornerRadius = 25;
    self.leftButton.layer.borderWidth = 1;
    self.leftButton.layer.borderColor = cs999999Color.CGColor;
}
- (void)configNavigationBar {
    self.title = @"在线咨询";
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        SureOrderDaShiInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
        return cell;
    }
    
    SureOrderCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    cell.thirdImageView.image = DotaImageName(@"img_3_xinxi-1");
    cell.fourthImageView.image = DotaImageName(@"img_4_zixun-1");
    cell.thirdLabel.textColor = csBlueColor;
    cell.fourthLabel.textColor = csBlueColor;
    cell.secondLabel.textColor = csBlueColor;
    cell.secondImageView.image = DotaImageName(@"img_2_queren-1");
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        return 73;
    }
    return 227.5;
    
}

@end
