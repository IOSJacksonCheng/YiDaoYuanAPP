//
//  ConsultTuiKuanViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultTuiKuanViewController.h"
#import "ConsultYiWanChengTableViewCell.h"
@interface ConsultTuiKuanViewController ()
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ConsultTuiKuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ConsultYiWanChengTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultYiWanChengTableViewCell)];
    
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"退款";
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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        ConsultYiWanChengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultYiWanChengTableViewCell)];
        return cell;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    return 237;
    
}

@end
