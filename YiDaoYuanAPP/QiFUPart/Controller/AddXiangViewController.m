//
//  AddXiangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AddXiangViewController.h"
#import "AddXiangTableViewCell.h"

NSString * const xianGuoString = @"献果";
NSString * const xianXiangString = @"敬香";

NSString * const xianHuaString = @"献花";

@interface AddXiangViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *moneyView;
- (IBAction)clickCloseButtonDone:(id)sender;

@end

@implementation AddXiangViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
  
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(AddXiangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(AddXiangTableViewCell)];
    
    self.tableView.rowHeight = 270;
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = self.passString;
    
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddXiangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(AddXiangTableViewCell)];
    
    if ([self.passString isEqualToString:xianGuoString]) {
        cell.firstImageView.image = DotaImageName(@"img_pingan-1");
        cell.secondImageView.image = DotaImageName(@"img_pingguo");
        cell.thirdImageView.image = DotaImageName(@"img_xigua");
    } else if ([self.passString isEqualToString:xianHuaString]) {
         cell.firstImageView.image = DotaImageName(@"img_hua_1");
         cell.secondImageView.image = DotaImageName(@"img_hua_2");
         cell.thirdImageView.image = DotaImageName(@"8059a809e52f57c038e7364a0d0322e604fd0e6fce57-Yoccmn_fw658");
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFirstViewDone)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [cell.firstView addGestureRecognizer:tap];
    
    
    return cell;
}
- (void)clickFirstViewDone {
    self.moneyView.hidden = NO;
}
- (IBAction)clickCloseButtonDone:(id)sender {
    
    self.moneyView.hidden = YES;
    
}
@end
