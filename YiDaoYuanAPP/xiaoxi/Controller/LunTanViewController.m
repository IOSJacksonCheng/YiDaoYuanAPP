//
//  LunTanViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanViewController.h"
#import "LunTanTitleTableViewCell.h"
#import "LunTanButtonTableViewCell.h"
@interface LunTanViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LunTanViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanTitleTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanButtonTableViewCell)];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)configSubViews {
    
    
}

- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"论坛";
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
            
            return cell;
        }
        
        LunTanButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanButtonTableViewCell)];
        
        cell.historyMoreLabel.hidden = YES;
        cell.hitstoryTitleLabel.hidden = YES;
        cell.historyBottomView.hidden = YES;
        cell.nowLabel.hidden = NO;
        cell.nowImageView.hidden = NO;
        
        return cell;
    }
    if (indexPath.row == 0) {
        LunTanButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanButtonTableViewCell)];
        
        cell.historyMoreLabel.hidden = NO;
        cell.hitstoryTitleLabel.hidden = NO;
        cell.historyBottomView.hidden = NO;
        cell.nowLabel.hidden = YES;
        cell.nowImageView.hidden = YES;
        
        return cell;
    }
    
    LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            
            return 240;
        }
        
       
        
        return 50;
    }
    if (indexPath.row == 0) {
        
        
        return 50;
    }
    
    return 240;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"LunTanMoreViewController" sender:self];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    
    view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 5;
}
@end
