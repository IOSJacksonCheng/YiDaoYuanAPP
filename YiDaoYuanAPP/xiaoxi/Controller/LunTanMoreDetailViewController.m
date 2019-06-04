//
//  LunTanMoreDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanMoreDetailViewController.h"

#import "LunTanTitleTableViewCell.h"
#import "LunTanMoreDetailCountTableViewCell.h"
#import "LunTanUserJudgeTableViewCell.h"
@interface LunTanMoreDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *csInputTextField;
@property (weak, nonatomic) IBOutlet UIView *remindView;

- (IBAction)clickCancelButtonDone:(id)sender;
@end

@implementation LunTanMoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanTitleTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanMoreDetailCountTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanMoreDetailCountTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanUserJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanUserJudgeTableViewCell)];
    
}
- (void)configSubViews {
    self.csInputTextField.layer.cornerRadius = 15;
    self.csInputTextField.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"论坛详情";
    
    WhiteNavigationBarColor
    
    
    
    
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
        LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
        
        return cell;
    }
    if (indexPath.row == 1) {
        LunTanMoreDetailCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanMoreDetailCountTableViewCell)];
        
        return cell;
    }
    LunTanUserJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanUserJudgeTableViewCell)];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 240;
    }
    
    if (indexPath.row == 2) {
        return 140;
    }
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

- (IBAction)clickCancelButtonDone:(id)sender {
    self.remindView.hidden = YES;
}
@end
