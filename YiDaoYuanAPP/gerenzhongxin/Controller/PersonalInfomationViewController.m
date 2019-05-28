//
//  PersonalInfomationViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalInfomationViewController.h"
#import "PersonalSetTableViewCell.h"
@interface PersonalInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation PersonalInfomationViewController
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"个人信息",@"修改密码"].mutableCopy;
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PersonalSetTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PersonalSetTableViewCell)];
    
    self.tableView.rowHeight = 66;
    
}

- (void)configSubViews {
    
    
}

- (void)configNavigationBar {
    
    F3f3f3NavigationBarColor
    
    self.title = @"个人信息";
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PersonalSetTableViewCell)];
     cell.csTitleLabel.text = self.listArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.listArray[indexPath.row];
    
    if ([title isEqualToString:@"个人信息"]) {
        [self performSegueWithIdentifier:@"ChangePersonalInfomationViewController" sender:self];
    } else if ([title isEqualToString:@"修改密码"]) {
        [self performSegueWithIdentifier:@"ChangePasswordViewController" sender:self];
    }
}

@end
