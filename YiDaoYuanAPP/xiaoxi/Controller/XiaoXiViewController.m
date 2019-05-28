//
//  XiaoXiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "XiaoXiTableViewCell.h"
@interface XiaoXiViewController ()
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation XiaoXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(XiaoXiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(XiaoXiTableViewCell)];
    
    self.tableview.rowHeight = 87.5;
}
- (void)configSubViews {
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"消息列表";
    
    F3f3f3NavigationBarColor
    
    
    UIButton *rightButton = [[UIButton alloc] init];

    
    [rightButton setImage:DotaImageName(@"icon_weixin-1") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)clickRightButtonDone {
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiaoXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(XiaoXiTableViewCell)];
    if (indexPath.row == 0) {
        cell.userTitle.text = @"易道源客服";
        cell.userImageView.image = DotaImageName(@"img_kefu");
        cell.userContent.text = @"新用户赠送您100易道元";
    }
    return cell;
}
@end
