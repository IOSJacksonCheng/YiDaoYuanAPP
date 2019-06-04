//
//  ShoppingShouYeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingShouYeViewController.h"
#import "ShoppingShouYeTableViewCell.h"
#import "JieYuanJiaTableViewCell.h"
#import "ZJZXBannerTableViewCell.h"
#import "ZJZXFirstRowModel.h"
@interface ShoppingShouYeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ShoppingShouYeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingShouYeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingShouYeTableViewCell)];
      [self.tableView registerNib:[UINib nibWithNibName:CSCellName(JieYuanJiaTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(JieYuanJiaTableViewCell)];
    
       [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXBannerTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXBannerTableViewCell)];
}

- (void)configSubViews {
    
    
}

- (void)configNavigationBar {
    
    
    self.title = @"商城";
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];

    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)clickLeftButtonDone {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
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
            ZJZXBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXBannerTableViewCell)];
            ZJZXFirstRowModel *model = [ZJZXFirstRowModel new];
            NSMutableArray *array = @[].mutableCopy;
            [array addObject:model];
            cell.adImageArray = array;
            return cell;
        }
        
        ShoppingShouYeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingShouYeTableViewCell)];
          return cell;
    }
    
    JieYuanJiaTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(JieYuanJiaTableViewCell)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return  160;
        }
        return 195;
    }
    return 259;
}
@end
