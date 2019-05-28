//
//  YiDaoKeTangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangViewController.h"

@interface YiDaoKeTangViewController ()
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation YiDaoKeTangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
//    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(XiaoXiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(XiaoXiTableViewCell)];
    
    self.tableview.rowHeight = 87.5;
}
- (void)configSubViews {
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"易道课堂";
    
    F3f3f3NavigationBarColor
    

    
}
- (void)clickRightButtonDone {
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    XiaoXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(XiaoXiTableViewCell)];
//    if (indexPath.row == 0) {
//        cell.userTitle.text = @"易道源客服";
//        cell.userImageView.image = DotaImageName(@"img_kefu");
//        cell.userContent.text = @"新用户赠送您100易道元";
//    }
//    return cell;
//}

@end
