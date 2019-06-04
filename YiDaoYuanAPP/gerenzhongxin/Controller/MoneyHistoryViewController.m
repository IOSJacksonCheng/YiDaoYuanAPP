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

NSString * const YUE = @"余额";
NSString * const YIDAOYUAN = @"易道元";
@interface MoneyHistoryViewController ()<UITableViewDelegate, UITableViewDataSource>
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
@end

@implementation MoneyHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self showLeftButtonStatus];
    
}

- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MoneyHistoryFourTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MoneyHistoryFourTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MoneyHistoryTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MoneyHistoryTableViewCell)];
    self.tableView.rowHeight = 50;
}
- (void)configSubViews {
    
    
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
    
    self.title = self.passString;
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_gengduo") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickMoreDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickMoreDone {
    
}
- (IBAction)clickConditionButtonDone:(UIButton *)sender {
    if (sender.tag == 0) {
        [self showLeftButtonStatus];
        return;
    }
    [self showRightButtonStatus];
}

- (IBAction)clickGetMoneyButton:(id)sender {
    
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
    [self.tableView reloadData];
    
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
    [self.tableView reloadData];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.passString isEqualToString:YIDAOYUAN] && !self.clickLeftButton) {
        MoneyHistoryFourTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MoneyHistoryFourTableViewCell)];
        return cell;
    }
    MoneyHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MoneyHistoryTableViewCell)];
    return cell;
}
- (IBAction)clickCloseButtonDone:(id)sender {
    self.successView.hidden = YES;
}
@end
