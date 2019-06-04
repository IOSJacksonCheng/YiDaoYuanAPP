//
//  ShoppingAllOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAllOrderViewController.h"
#import "ShoppingAllOrderTableViewCell.h"
typedef NS_ENUM(NSInteger, CSCellType) {
    AllCSCellType = 0,
    DaiFuKuanCSCellType,
    DaiFaHuoCSCellType,
    DaiShouHuoCSCellType,
    YiWanChengCSCellType
};
@interface ShoppingAllOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthButton;
- (IBAction)clickTopViewButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewWidth;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *daifukuanArray;
@property (nonatomic, strong) NSMutableArray *daifahuoArray;
@property (nonatomic, strong) NSMutableArray *daishouhuoArray;
@property (nonatomic, strong) NSMutableArray *yiwanchengArray;
@property (nonatomic, assign) CSCellType currentCSCellType;
@end

@implementation ShoppingAllOrderViewController
- (NSMutableArray *)yiwanchengArray {
    if (!_yiwanchengArray) {
        _yiwanchengArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"4";
        
        [_yiwanchengArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"4";
        [_yiwanchengArray addObject:model2];
    }
    return _yiwanchengArray;
}
- (NSMutableArray *)daishouhuoArray {
    if (!_daishouhuoArray) {
        _daishouhuoArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"3";
        model1.statTitle = @"待收货";
        [_daishouhuoArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"3";
        model2.statTitle = @"待收货";
        [_daishouhuoArray addObject:model2];
    }
    return _daishouhuoArray;
}
- (NSMutableArray *)daifahuoArray {
    if (!_daifahuoArray) {
        _daifahuoArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"2";
        model1.statTitle = @"待发货";
        
        [_daifahuoArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"2";
        model2.statTitle = @"待发货";
        
        [_daifahuoArray addObject:model2];
    }
    return _daifahuoArray;
}

- (NSMutableArray *)daifukuanArray {
    if (!_daifukuanArray) {
        _daifukuanArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"1";
        model1.statTitle = @"待付款";
        
        [_daifukuanArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"1";
        model2.statTitle = @"待付款";
        
        [_daifukuanArray addObject:model2];
    }
    return _daifukuanArray;
}
- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"1";
        model1.statTitle = @"待付款";
        
        [_allArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"3";
        model2.statTitle = @"待收货";
        
        [_allArray addObject:model2];
        
    }
    return _allArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.currentCSCellType = self.passTag;
    [self changeButtonStatusWithTag:self.currentCSCellType];
}

- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAllOrderTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAllOrderTableViewCell)];
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"我的订单";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (void)sendGetRequestForInfomation:(NSInteger)tag {
    
}
- (IBAction)clickTopViewButtonDone:(UIButton *)sender {
    
    
    [self sendGetRequestForInfomation:sender.tag];
    [self changeButtonStatusWithTag:sender.tag];
    
}
- (void)changeButtonStatusWithTag:(NSUInteger)tag {
    
    self.currentCSCellType = tag;
    if (tag == 0) {
        //全部付款
        [self.firstButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    } else {
        [self.firstButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    if (tag == 1) {
        //待付款
        [self.secondButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.secondButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    
    
    if (tag == 2) {
        //进行中
        [self.thirdButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.thirdButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    if (tag == 3) {
        //已完成
        [self.fourthButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.fourthButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    
    if (tag == 4) {
        //退款
        [self.fifthButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.fifthButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        CGFloat width = MainScreenWidth * 0.2;
        
        if (tag == 0) {
            
            self.lineViewWidth.constant = 60;
            
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 60 * 0.5;
            
            
        } else if (tag == 4) {
            
            self.lineViewWidth.constant = 30;
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 30 * 0.5;
        }  else if (tag == 1) {
            self.lineViewWidth.constant = 45;
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 45 * 0.5;
        } else if (tag == 2) {
            self.lineViewWidth.constant = 45;
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 45* 0.5;
        }  else if (tag == 3) {
            
            self.lineViewLeftConstraint.constant = self.lineViewWidth.constant = 45;
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 45 * 0.5;
            
        }
        [self.view layoutIfNeeded];
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self.listTableView reloadData];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self getCurrentArray].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ShoppingAllOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAllOrderTableViewCell)];
    
    AllOrderModel *model = [self getCurrentModel:indexPath.row];
    cell.model = model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllOrderModel *model = [self getCurrentModel:indexPath.row];
    if (model.state.integerValue == YiWanChengCSCellType) {
        return 181;
    }
    
    return 209;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    AllOrderModel *model = [self getCurrentModel:indexPath.row];
    
}
- (AllOrderModel *)getCurrentModel:(NSInteger)row {
    NSMutableArray *array = [self getCurrentArray];
    
    return array[row];
}
- (NSMutableArray *)getCurrentArray {
    if (self.currentCSCellType == AllCSCellType) {
        return self.allArray;
    }
    if (self.currentCSCellType == DaiFuKuanCSCellType) {
        return self.daifukuanArray;
    }
    
    if (self.currentCSCellType == DaiFaHuoCSCellType) {
        return self.daifahuoArray;
    }
    if (self.currentCSCellType == YiWanChengCSCellType) {
        return self.yiwanchengArray;
    }
    return self.daishouhuoArray;
}



@end
