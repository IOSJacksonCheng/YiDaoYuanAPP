//
//  UserJudgeListViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserJudgeListViewController.h"

#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
@interface UserJudgeListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserJudgeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];
    
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
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if (indexPath.row % 2 == 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        
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
    
    
    if (indexPath.row % 2 == 0) {
        return 100;
    }
    return 100;
    
}

@end
