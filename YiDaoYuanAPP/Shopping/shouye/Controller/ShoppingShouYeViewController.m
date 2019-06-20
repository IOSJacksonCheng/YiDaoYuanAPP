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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = UIView.new;
    
    view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = [UILabel new];
    
    
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
    }];
    
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"热门推荐" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        label.attributedText = string;
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(2);
    }];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
         [self performSegueWithIdentifier:@"ShopManyProductViewController" sender:self];
        return;
    }
    
    [self performSegueWithIdentifier:@"ShopProductDetailViewController" sender:self];
}
@end
