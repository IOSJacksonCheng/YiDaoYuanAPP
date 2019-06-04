//
//  DaShiDuanZiXunViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//


#import "DaShiDuanZiXunViewController.h"
#import "DaShiDuanZiXunTableViewCell.h"


typedef NS_ENUM(NSInteger, DaShiCellType) {
    AllDaShiCellType = 0,
    DaiHuiFuDaShiCellType,
    JinXingZhongDaShiCellType,
    YiWanChengDaShiCellType
};
@interface DaShiDuanZiXunViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
- (IBAction)clickTopViewButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewWidth;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *daihuifuArray;
@property (nonatomic, strong) NSMutableArray *jinxingzhongArray;
@property (nonatomic, strong) NSMutableArray *yiwanchengArray;
@property (nonatomic, assign) DaShiCellType currentDaShiCellType;
@end

@implementation DaShiDuanZiXunViewController
- (NSMutableArray *)yiwanchengArray {
    if (!_yiwanchengArray) {
        _yiwanchengArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"3";
        model1.statTitle = @"已完成";
        [_yiwanchengArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"3";
        model2.statTitle = @"已完成";
        [_yiwanchengArray addObject:model2];
    }
    return _yiwanchengArray;
}
- (NSMutableArray *)jinxingzhongArray {
    if (!_jinxingzhongArray) {
        _jinxingzhongArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"2";
        model1.statTitle = @"进行中";
        [_jinxingzhongArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"2";
        model2.statTitle = @"进行中";
        [_jinxingzhongArray addObject:model2];
    }
    return _jinxingzhongArray;
}
- (NSMutableArray *)daihuifuArray {
    if (!_daihuifuArray) {
        _daihuifuArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"1";
        model1.statTitle = @"待回复";
        
        [_daihuifuArray addObject:model1];
        
        AllOrderModel *model2 = [AllOrderModel new];
        model2.state = @"1";
        model2.statTitle = @"待回复";
        
        [_daihuifuArray addObject:model2];
    }
    return _daihuifuArray;
}


- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = @[].mutableCopy;
        
        AllOrderModel *model1 = [AllOrderModel new];
        model1.state = @"1";
        model1.statTitle = @"待回复";
        
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
    [self changeButtonStatusWithTag:0];
}

- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanZiXunTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanZiXunTableViewCell)];
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
    
    self.currentDaShiCellType = tag;
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
    
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        CGFloat width = MainScreenWidth * 0.25;
        
        if (tag == 0) {
            
            self.lineViewWidth.constant = 60;
            
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 60 * 0.5;
            
            
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
    
    
    DaShiDuanZiXunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanZiXunTableViewCell)];
    
    AllOrderModel *model = [self getCurrentModel:indexPath.row];
    cell.model = model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllOrderModel *model = [self getCurrentModel:indexPath.row];
    if (model.state.integerValue == YiWanChengDaShiCellType) {
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
    if (self.currentDaShiCellType == AllDaShiCellType) {
        return self.allArray;
    }
    if (self.currentDaShiCellType == DaiHuiFuDaShiCellType) {
        return self.daihuifuArray;
    }
    
    if (self.currentDaShiCellType == JinXingZhongDaShiCellType) {
        return self.jinxingzhongArray;
    }
   
    return self.yiwanchengArray;
}


@end
