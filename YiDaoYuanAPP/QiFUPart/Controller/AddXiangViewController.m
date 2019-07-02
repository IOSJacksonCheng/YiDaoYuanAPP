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
NSString * const jingShiString = @"敬食";
@interface AddXiangViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *moneyView;
- (IBAction)clickCloseButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *otherFuFeiImageView;
@property (weak, nonatomic) IBOutlet UILabel *otherFuFeiTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *otherFuFeiButton;
@property (weak, nonatomic) IBOutlet UILabel *otherFuFeiSubLabel;

@end

@implementation AddXiangViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
}
- (void)getMoreData {
    
    
}
- (void)getNewData {
    
    
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
    
    
    
    if ([self.passString isEqualToString:xianGuoString]) {
        self.otherFuFeiImageView.image = DotaImageName(@"img_pingan-1");
        
    } else if ([self.passString isEqualToString:xianHuaString]) {
        self.otherFuFeiImageView.image = DotaImageName(@"img_huaping");
       
    } else if ([self.passString isEqualToString:jingShiString]){
        self.otherFuFeiImageView.image = DotaImageName(@"img_1_hongguo");
        
    }
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
    } else if ([self.passString isEqualToString:jingShiString]){
        cell.firstImageView.image = DotaImageName(@"img_1_hongguo");
        cell.secondImageView.image = DotaImageName(@"img_2_huangguo");
        cell.thirdImageView.image = DotaImageName(@"img_3_baiguo");
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFirstViewDone)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [cell.firstView addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSecondViewDone)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [cell.secondView addGestureRecognizer:tap1];
    
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickThirdViewDone)];
    tap2.numberOfTapsRequired = 1;
    tap2.numberOfTouchesRequired = 1;
    
    [cell.thirdView addGestureRecognizer:tap2];
    return cell;
}
- (void)clickFirstViewDone {
    self.moneyView.hidden = NO;
    [self.otherFuFeiButton setTitle:@"确定" forState:UIControlStateNormal];
    
    self.otherFuFeiTitleLabel.text = @"平安吉祥";
}
- (void)clickSecondViewDone {
    self.moneyView.hidden = NO;
    
    [self.otherFuFeiButton setTitle:@"立即请购" forState:UIControlStateNormal];
    
    self.otherFuFeiTitleLabel.text = @"平安吉祥\n20易道元/10个";
    
}
- (void)clickThirdViewDone {
    self.moneyView.hidden = NO;
    [self.otherFuFeiButton setTitle:@"立即请购" forState:UIControlStateNormal];
    
    self.otherFuFeiTitleLabel.text = @"平安吉祥\n20易道元/10个";
    
    
}
- (IBAction)clickCloseButtonDone:(id)sender {
    
    self.moneyView.hidden = YES;
    
}
@end
