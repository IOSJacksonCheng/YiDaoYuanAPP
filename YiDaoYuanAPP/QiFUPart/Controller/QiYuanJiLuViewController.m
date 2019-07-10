//
//  QiYuanJiLuViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QiYuanJiLuViewController.h"
#import "QiFuJiLuTableViewCell.h"
#import "DaShiListItemModel.h"
@interface QiYuanJiLuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation QiYuanJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}

- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"supplication_id"] = self.pass_ID;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_History Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getGongPingDetailArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(QiFuJiLuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(QiFuJiLuTableViewCell)];
    self.tableView.rowHeight = 70;
   
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"祈愿记录";
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
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QiFuJiLuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(QiFuJiLuTableViewCell)];
    if (indexPath.row == 0) {
        cell.topView.hidden = YES;
    } else {
        cell.topView.hidden = NO;
    }
    DaShiListItemModel *model = self.listArray[indexPath.row];
    cell.titleLabel.text = model.idString;
    cell.contentLabel.text = model.title;
    return cell;
}
@end
