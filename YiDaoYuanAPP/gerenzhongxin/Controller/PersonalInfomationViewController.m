//
//  PersonalInfomationViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalInfomationViewController.h"
#import "PersonalSetTableViewCell.h"

#import "DaShiWorkTableViewCell.h"
@interface PersonalInfomationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) NSInteger tag;
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
    self.tag = [[NSUserDefaults standardUserDefaults] integerForKey:@"workstatus"];
     [self.tableView reloadData];
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PersonalSetTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PersonalSetTableViewCell)];
      [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiWorkTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiWorkTableViewCell)];
    
    
}

- (void)configSubViews {
    
   
}

- (void)configNavigationBar {
    
    F3f3f3NavigationBarColor
    
    self.title = @"个人信息";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (CS_UserIsMaster) {
        return 3;
    }
   return self.listArray.count;
}
- (void)clickWorkStatus:(UIButton *)sender {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    
    para[@"work_status"] = [NSString stringWithFormat:@"%ld",self.tag];
   
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Profile_Masterinfo Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            self.tag = sender.tag;
            [[NSUserDefaults standardUserDefaults] setInteger:sender.tag forKey:@"workstatus"];
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        DaShiWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiWorkTableViewCell)];
        [cell.firstButton addTarget:self action:@selector(clickWorkStatus:) forControlEvents:UIControlEventTouchDown];
        
        [cell.secondButton addTarget:self action:@selector(clickWorkStatus:) forControlEvents:UIControlEventTouchDown];
        [cell.thirdButton addTarget:self action:@selector(clickWorkStatus:) forControlEvents:UIControlEventTouchDown];
        cell.firstButton.selected = (self.tag == cell.firstButton.tag);
        cell.secondButton.selected = (self.tag == cell.secondButton.tag);
        cell.thirdButton.selected = (self.tag == cell.thirdButton.tag);
        return cell;
        
    }
    PersonalSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PersonalSetTableViewCell)];
    
    NSString *title = self.listArray[indexPath.row];
    
     cell.csTitleLabel.text = title;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        return;
    }
    NSString *title = self.listArray[indexPath.row];
    
    if ([title isEqualToString:@"个人信息"]) {
        [self performSegueWithIdentifier:@"ChangePersonalInfomationViewController" sender:self];
    } else if ([title isEqualToString:@"修改密码"]) {
        [self performSegueWithIdentifier:@"ChangePasswordViewController" sender:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 123;
    }
    return 66;
}
@end
