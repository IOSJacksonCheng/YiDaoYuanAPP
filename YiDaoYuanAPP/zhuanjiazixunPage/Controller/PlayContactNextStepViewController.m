//
//  PlayContactNextStepViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactNextStepViewController.h"

#import "ZJZXMoreTableViewCell.h"
#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
@interface PlayContactNextStepViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickNextButtonDone:(id)sender;

@end

@implementation PlayContactNextStepViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"婚恋情感";
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"精选案例";
        cell.moreTitleLabel.hidden = YES;
        return cell;
    }
   
    if (indexPath.row % 2 != 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        
        return cell;
    }
    
    PlayContactSamplesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    cell.subTitleLabel.hidden = YES;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 54;
    }
    if (indexPath.row % 2 != 0) {
        return 80;
    }
    
        return 98;
    
}
- (IBAction)clickNextButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"PlayContactStepThreeViewController" sender:self];
}
@end
