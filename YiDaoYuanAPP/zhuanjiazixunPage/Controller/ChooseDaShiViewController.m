//
//  ChooseDaShiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChooseDaShiViewController.h"

#import "ChooseDaShiTableViewCell.h"
#import "ChooseDaShiPersonalTableViewCell.h"
@interface ChooseDaShiViewController ()<UITableViewDelegate, UITableViewDataSource>
- (IBAction)clickSureButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChooseDaShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
}

- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChooseDaShiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChooseDaShiTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChooseDaShiPersonalTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChooseDaShiPersonalTableViewCell)];
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"选择大师";
}

- (IBAction)clickSureButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"PlaySurePayMoneyViewController" sender:self];
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ChooseDaShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChooseDaShiTableViewCell)];
        
        return cell;
    }
    
    ChooseDaShiPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChooseDaShiPersonalTableViewCell)];
  
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 137;
    }
    return 107;
}
@end
