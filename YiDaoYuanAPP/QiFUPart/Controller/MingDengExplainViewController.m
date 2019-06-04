//
//  MingDengExplainViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MingDengExplainViewController.h"
#import "MingDengExplainTableViewCell.h"
@interface MingDengExplainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MingDengExplainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MingDengExplainTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MingDengExplainTableViewCell)];
    self.tableView.rowHeight = 190;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    self.title = @"供灯说明";
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MingDengExplainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MingDengExplainTableViewCell)];
    return cell;
}
@end
