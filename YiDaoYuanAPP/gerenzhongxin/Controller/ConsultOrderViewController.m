//
//  ConsultOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultOrderViewController.h"

#import "ConsultTableViewCell.h"

typedef NS_ENUM(NSInteger, CellType) {
    AllCellType = 0,
    DaiFuKuanCellType,
    JinXinZhongCellType,
    YiWanChengCellType,
    TuiKuanCellType
};
@interface ConsultOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
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
@property (nonatomic, strong) NSMutableArray *jinxinzhongArray;
@property (nonatomic, strong) NSMutableArray *yiwanchengArray;
@property (nonatomic, strong) NSMutableArray *tuikuanArray;
@property (nonatomic, assign) CellType currentCellType;
@end

@implementation ConsultOrderViewController

- (NSMutableArray *)tuikuanArray {
    if (!_tuikuanArray) {
        _tuikuanArray = @[].mutableCopy;
        
        ConsultModel *model1 = [ConsultModel new];
        model1.state = @"4";
        model1.statTitle = @"退款";
        [_tuikuanArray addObject:model1];
        
        ConsultModel *model2 = [ConsultModel new];
        model2.state = @"4";
        model2.statTitle = @"退款";
        [_tuikuanArray addObject:model2];
    }
    return _tuikuanArray;
}
- (NSMutableArray *)yiwanchengArray {
    if (!_yiwanchengArray) {
        _yiwanchengArray = @[].mutableCopy;
        
        ConsultModel *model1 = [ConsultModel new];
        model1.state = @"3";
         model1.statTitle = @"已完成";
        [_yiwanchengArray addObject:model1];
        
        ConsultModel *model2 = [ConsultModel new];
        model2.state = @"3";
         model2.statTitle = @"已完成";
        [_yiwanchengArray addObject:model2];
    }
    return _yiwanchengArray;
}
- (NSMutableArray *)jinxinzhongArray {
    if (!_jinxinzhongArray) {
        _jinxinzhongArray = @[].mutableCopy;
        
        ConsultModel *model1 = [ConsultModel new];
        model1.state = @"2";
        model1.statTitle = @"进行中";

        [_jinxinzhongArray addObject:model1];
        
        ConsultModel *model2 = [ConsultModel new];
        model2.state = @"2";
        model2.statTitle = @"进行中";

        [_jinxinzhongArray addObject:model2];
    }
    return _jinxinzhongArray;
}

- (NSMutableArray *)daifukuanArray {
    if (!_daifukuanArray) {
        _daifukuanArray = @[].mutableCopy;
        
        ConsultModel *model1 = [ConsultModel new];
        model1.state = @"1";
        model1.statTitle = @"待付款";

        [_daifukuanArray addObject:model1];
        
        ConsultModel *model2 = [ConsultModel new];
        model2.state = @"1";
        model2.statTitle = @"待付款";

        [_daifukuanArray addObject:model2];
    }
    return _daifukuanArray;
}
- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = @[].mutableCopy;
        
        ConsultModel *model1 = [ConsultModel new];
        model1.state = @"2";
        model1.statTitle = @"进行中";

        [_allArray addObject:model1];
        
        ConsultModel *model2 = [ConsultModel new];
        model2.state = @"3";
        model2.statTitle = @"已完成";

        [_allArray addObject:model2];
        
        ConsultModel *model3 = [ConsultModel new];
        model3.state = @"4";
        model3.statTitle = @"退款";

        [_allArray addObject:model3];
        
        
        ConsultModel *model5 = [ConsultModel new];
        model5.state = @"1";
        model5.statTitle = @"待付款";

        [_allArray addObject:model5];
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
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ConsultTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultTableViewCell)];
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"咨询订单";
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
    
    self.currentCellType = tag;
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
    

    ConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultTableViewCell)];
    
    ConsultModel *model = [self getCurrentModel:indexPath.row];
    cell.model = model;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsultModel *model = [self getCurrentModel:indexPath.row];
    if (model.state.integerValue == TuiKuanCellType) {
        return 181;
    }
    
    return 209;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConsultModel *model = [self getCurrentModel:indexPath.row];
     if (model.state.integerValue == JinXinZhongCellType) {
      
          [self performSegueWithIdentifier:@"ConsultJinXinZhongViewController" sender:self];
     } else if (model.state.integerValue == TuiKuanCellType) {
         
         [self performSegueWithIdentifier:@"ConsultTuiKuanViewController" sender:self];
     }else if (model.state.integerValue == YiWanChengCellType) {
         
         [self performSegueWithIdentifier:@"ConsultYiWanChengViewController" sender:self];
     }
}
- (ConsultModel *)getCurrentModel:(NSInteger)row {
    NSMutableArray *array = [self getCurrentArray];
    
    return array[row];
}
- (NSMutableArray *)getCurrentArray {
    if (self.currentCellType == AllCellType) {
        return self.allArray;
    }
    if (self.currentCellType == DaiFuKuanCellType) {
        return self.daifukuanArray;
    }
    
    if (self.currentCellType == JinXinZhongCellType) {
        return self.jinxinzhongArray;
    }
    if (self.currentCellType == YiWanChengCellType) {
        return self.yiwanchengArray;
    }
    return self.tuikuanArray;
}

@end
