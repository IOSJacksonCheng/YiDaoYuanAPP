//
//  UserJudgeListDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserJudgeListDetailViewController.h"

#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
#import "UserJudgeDetailImageTableViewCell.h"
@interface UserJudgeListDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation UserJudgeListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(UserJudgeDetailImageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(UserJudgeDetailImageTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"晒单列表";
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        
        return cell;
    }
    if (indexPath.row == 1) {
        UserJudgeDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(UserJudgeDetailImageTableViewCell)];
        
        return cell;
    }
    PlayContactSamplesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    cell.subTitleLabel.hidden = YES;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"UserJudgeListDetailViewController" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        return 100;
    }
    if (indexPath.row == 1) {
        return 116;
    }
    return 100;
    
}

@end
