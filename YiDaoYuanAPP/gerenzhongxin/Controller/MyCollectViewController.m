//
//  MyCollectViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MyCollectViewController.h"

#import "DaShiDetailViewController.h"
#import "YiDaoKeTangContentViewController.h"
#import "MyCollectTableViewCell.h"
@interface MyCollectViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation MyCollectViewController
- (void)viewWillAppear:(BOOL)animated {
   
    [super viewWillAppear:animated];
   
    [self configNavigationBar];
}
- (void)viewDidLoad {
  
    [super viewDidLoad];
  
    self.listArray = @[].mutableCopy;
   
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self sendGetRequest];
    
}

- (void)sendGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Favorites_My Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.listArray =  [CSParseManager getMyCollectModelArrayWithResponseObject:CSGetResult[@"lists"]];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MyCollectTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MyCollectTableViewCell)];
    
    self.tableView.rowHeight = 134;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
  
    self.title = @"我的收藏";
    
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MyCollectTableViewCell)];
    MyCollectModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectModel *model = self.listArray[indexPath.row];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if ([model.table_name isEqualToString:@"master"]) {
        DaShiDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"DaShiDetailViewController"];
        new.passMasterID = model.object_id;
        [self.navigationController pushViewController:new animated:YES];
    } else {
        YiDaoKeTangContentViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"YiDaoKeTangContentViewController"];
        
        new.passUrl = [NSString stringWithFormat:@"%@%@&&id=%@", BASE_URL,CSURL_Portal_Site_course_detail,model.object_id];
        new.showBottomView = YES;
        new.passTitle = @"视频详情";
        new.idstring = model.object_id;
        [self.navigationController pushViewController:new animated:YES];
    }
    
    
   
}
@end
