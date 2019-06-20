//
//  DaShiListViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiListViewController.h"
#import "CSSearchTableViewCell.h"
#import "DaShiListItemView.h"
#import "AfterPayMoneyChatViewController.h"
@interface DaShiListViewController ()<UITableViewDelegate, UITableViewDataSource, DaShiListItemViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (weak, nonatomic) IBOutlet UIView *typeView;
- (IBAction)clickChooseButtonDone:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (nonatomic, strong) DaShiListItemView *itemCollectionView;
- (IBAction)clickConsultButtonDone:(UIButton *)sender;
- (IBAction)clickAllSelectionButtonDone:(id)sender;

@end

@implementation DaShiListViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewDidAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.searchTableView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [self.searchTableView registerNib:[UINib nibWithNibName:CSCellName(CSSearchTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(CSSearchTableViewCell)];
    self.searchTableView.rowHeight = 156;
}
- (void)configSubViews {

    self.itemCollectionView = [[DaShiListItemView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight)];
    self.itemCollectionView.csDelegate = self;
    [self.tabBarController.view addSubview:self.itemCollectionView];

//    [self.itemCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//    }];
    self.itemCollectionView.hidden = YES;
NSString *imageString = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageString"];
    if (!csCharacterIsBlank(imageString)) {
        self.titleImageView.image = DotaImageName(imageString);
    }
    
    
}
- (void)configNavigationBar {
    self.title = @"大师列表";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    WhiteNavigationBarColor
}
#pragma mark -- DaShiListItemViewDelegate
- (void)clickCloseViewDone {
    self.itemCollectionView.hidden = YES;
}
#pragma mark --UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(CSSearchTableViewCell)];
    cell.showButton = YES;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     [self  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
    
}
- (IBAction)clickChooseButtonDone:(UIButton *)sender {
    self.itemCollectionView.hidden = NO;
}
- (IBAction)clickConsultButtonDone:(UIButton *)sender {
    self.typeView.hidden = NO;
}

- (IBAction)clickAllSelectionButtonDone:(id)sender {
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AfterPayMoneyChatViewController"]) {
       
        AfterPayMoneyChatViewController *new = segue.destinationViewController;
        
        new.showTopView = YES;
    }
    
}
@end
