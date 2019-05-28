//
//  IndustryNewsViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "IndustryNewsViewController.h"
#import "IndustryNewsTableViewCell.h"
@interface IndustryNewsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *newsTabelView;

@end

@implementation IndustryNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    self.newsTabelView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.newsTabelView registerNib:[UINib nibWithNibName:CSCellName(IndustryNewsTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(IndustryNewsTableViewCell)];
    self.newsTabelView.rowHeight = 133.5;
}

- (void)configSubViews {
    
}

- (void)configNavigationBar {
   
    self.title = @"行业资讯";
    
    F3f3f3NavigationBarColor
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    IndustryNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(IndustryNewsTableViewCell)];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self  performSegueWithIdentifier:@"CSNewsViewController" sender:self];
}
@end
