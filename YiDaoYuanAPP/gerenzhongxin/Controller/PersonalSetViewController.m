//
//  PersonalSetViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalSetViewController.h"

#import "PersonalSetTableViewCell.h"
#import "WkWebViewViewController.h"

@interface PersonalSetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *shareView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSString *recordTitle;
@property (nonatomic, strong) NSString *recordUrl;

@property (weak, nonatomic) IBOutlet UIView *disappearView;

@end

@implementation PersonalSetViewController
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"个人信息",@"新手指南",@"分享APP"].mutableCopy;
    }
    return _listArray;
}
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
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PersonalSetTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PersonalSetTableViewCell)];
   
    self.tableView.rowHeight = 66;
    
}

- (void)clickdisappearView {
    self.shareView.hidden = YES;
}

- (void)configSubViews {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickdisappearView)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [self.disappearView addGestureRecognizer:tap];
}

- (void)configNavigationBar {
    
    
    self.title = @"设置";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
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
        [self performSegueWithIdentifier:@"PersonalInfomationViewController" sender:self];
    } else if ([title isEqualToString:@"新手指南"]) {
        self.recordUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_New_Fish];
        self.recordTitle = @"新手指南";
          [self performSegueWithIdentifier:@"WkWebViewViewController" sender:self];
    }else if ([title isEqualToString:@"关于我们"]) {
        
        self.recordUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_About_Us];
        self.recordTitle = @"关于我们";
        
 [self performSegueWithIdentifier:@"WkWebViewViewController" sender:self];
        
    }else if ([title isEqualToString:@"分享APP"]) {
        self.shareView.hidden = NO;
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WkWebViewViewController"]) {
        WkWebViewViewController *new = segue.destinationViewController;
        new.passTitle = self.recordTitle;
        new.passUrl = self.recordUrl;

    }
}
@end
