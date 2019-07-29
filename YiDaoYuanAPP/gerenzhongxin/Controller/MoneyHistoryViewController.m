//
//  MoneyHistoryViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MoneyHistoryViewController.h"

#import "MoneyHistoryFourTableViewCell.h"
#import "MoneyHistoryTableViewCell.h"
#import "TiXianViewController.h"

NSString * const YUE = @"余额";
NSString * const YIDAOYUAN = @"易道元";
@interface MoneyHistoryViewController ()<UITableViewDelegate, UITableViewDataSource, TiXianViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *getMoneyButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *litterViewLeftConstraint;
- (IBAction)clickConditionButtonDone:(UIButton *)sender;
- (IBAction)clickGetMoneyButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *threeView;

@property (weak, nonatomic) IBOutlet UILabel *threeOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *three2Label;
@property (weak, nonatomic) IBOutlet UILabel *three3Label;

@property (weak, nonatomic) IBOutlet UIView *successView;

@property (weak, nonatomic) IBOutlet UIView *fourthView;
@property (weak, nonatomic) IBOutlet UILabel *fourOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *four2Label;
@property (weak, nonatomic) IBOutlet UILabel *four3Label;
@property (weak, nonatomic) IBOutlet UILabel *four4Label;

- (IBAction)clickCloseButtonDone:(id)sender;
@property (nonatomic, assign) BOOL clickLeftButton;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSString *recordUrl;

@property (nonatomic, assign) int page;

@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@end

@implementation MoneyHistoryViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self showLeftButtonStatus];
    
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    if (self.clickLeftButton) {
        para[@"type"] = @"2";

    } else {
        para[@"type"] = @"1";

    }
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:self.recordUrl Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getMoneyHistoryModelWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)GetMoreData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    if (self.clickLeftButton) {
        para[@"type"] = @"2";
        
    } else {
        para[@"type"] = @"1";
        
    }
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:self.recordUrl Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getMoneyHistoryModelWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.tableView reloadData];
                
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MoneyHistoryFourTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MoneyHistoryFourTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MoneyHistoryTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MoneyHistoryTableViewCell)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
    self.tableView.rowHeight = 50;
}
- (void)configSubViews {
    if (self.currentType == YuEMoneyType) {
        self.totalMoneyLabel.text = CS_Balance;
        self.recordUrl = CSURL_Portal_balance_logs;
    }else {
        self.totalMoneyLabel.text = CS_Coin;
        self.recordUrl = CSURL_Portal_coin_logs;

    }
    self.getMoneyButton.hidden = YES;
    self.getMoneyButton.layer.cornerRadius = 24;
    self.getMoneyButton.layer.masksToBounds = YES;
    UIView *topBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 130)];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    
    gradient.endPoint = CGPointMake(1, 0);
    
    gradient.frame =topBackgroundView.frame;
    
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"0D71C8"].CGColor,(id)[UIColor colorWithHexString:@"549DDD"].CGColor,nil];
    
    [self.topView.layer insertSublayer:gradient atIndex:0];
    
    
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 305, 48);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
    [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"0D71C8"] CGColor],(id)[[UIColor colorWithHexString:@"549DDD"] CGColor]]];//渐变数组
    [self.getMoneyButton.layer addSublayer:gradientLayer];
    
}
- (void)configNavigationBar {
    
    BlueNavigationBarColor
   
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    self.title = self.passString;
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_gengduo") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickMoreDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickMoreDone {
    
}
- (IBAction)clickConditionButtonDone:(UIButton *)sender {
    if (sender.tag == 0) {
        [self showLeftButtonStatus];
        self.getMoneyButton.hidden = YES;

    } else {
        if (self.currentType == YuEMoneyType) {
            self.getMoneyButton.hidden = NO;
        }
        [self showRightButtonStatus];

    }
    [self getNewData];
}

- (IBAction)clickGetMoneyButton:(id)sender {
    [self performSegueWithIdentifier:@"TiXianViewController" sender:self];
}
- (void)showLeftButtonStatus {
   
    self.clickLeftButton = YES;
   
    [self.leftButton setTitleColor:csBlueColor forState:UIControlStateNormal];
   
    [self.rightButton setTitleColor:cs333333Color forState:UIControlStateNormal];
   
    self.litterViewLeftConstraint.constant = 0;
   
    [self.view layoutIfNeeded];
    
    self.threeView.hidden = NO;
    
    self.fourthView.hidden = YES;
        

    self.threeOneLabel.text = @"金额";
    
    self.three2Label.text = @"项目";

    self.three3Label.text = @"日期";
    
    
}
- (void)showRightButtonStatus {
    self.clickLeftButton = NO;
    [self.rightButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    [self.leftButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    self.litterViewLeftConstraint.constant = MainScreenWidth * 0.5;
    [self.view layoutIfNeeded];
    
    
    if ([self.passString isEqualToString:YUE]) {
        self.threeView.hidden = NO;
        self.fourthView.hidden = YES;
        
        self.threeOneLabel.text = @"金额";
        self.three2Label.text = @"充值方式";
        self.three3Label.text = @"日期";
        
    } else {
        self.threeView.hidden = YES;
        self.fourthView.hidden = NO;
        
        self.four2Label.text = @"金额";
        self.four3Label.text = @"项目";
        self.four4Label.text = @"日期";
        self.fourOneLabel.text = @"易道元";

    }
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoneyHistoryModel *model = self.listArray[indexPath.row];
    if ([self.passString isEqualToString:YIDAOYUAN] && !self.clickLeftButton) {
        MoneyHistoryFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MoneyHistoryFourTableViewCell)];
        cell.model = model;
        return cell;
    }
    MoneyHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MoneyHistoryTableViewCell)];
    cell.model = model;

    return cell;
}
- (IBAction)clickCloseButtonDone:(id)sender {
    self.successView.hidden = YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TiXianViewController"]) {
        TiXianViewController *new = segue.destinationViewController;
        new.simpleDelegate = self;
    }
}
- (void)successback {
    self.successView.hidden = NO;

}
@end
