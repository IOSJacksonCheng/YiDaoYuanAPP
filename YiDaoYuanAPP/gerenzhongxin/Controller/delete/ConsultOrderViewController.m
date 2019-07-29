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

@property (nonatomic, assign) int recordFirstPage;
@property (nonatomic, assign) int recordSecondPage;

@property (nonatomic, assign) int recordThirdPage;

@property (nonatomic, assign) int recordFourthPage;

@property (nonatomic, assign) int recordFifthPage;

@end

@implementation ConsultOrderViewController

- (NSMutableArray *)tuikuanArray {
    if (!_tuikuanArray) {
        _tuikuanArray = @[].mutableCopy;
        
    }
    return _tuikuanArray;
}
- (NSMutableArray *)yiwanchengArray {
    if (!_yiwanchengArray) {
        _yiwanchengArray = @[].mutableCopy;
        
    }
    return _yiwanchengArray;
}
- (NSMutableArray *)jinxinzhongArray {
    if (!_jinxinzhongArray) {
        _jinxinzhongArray = @[].mutableCopy;
        

    }
    return _jinxinzhongArray;
}

- (NSMutableArray *)daifukuanArray {
    if (!_daifukuanArray) {
        _daifukuanArray = @[].mutableCopy;
        
      
    }
    return _daifukuanArray;
}
- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = @[].mutableCopy;
        
        
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
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
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
    
    self.currentCellType = tag;
    
    if ([self getCurrentArray].count == 0) {
        [self getNewData];
    } else {
        [self.listTableView reloadData];
    }
    
    
    
}
- (void)endRefresh {
    if (self.listTableView.mj_header.isRefreshing) {
        [self.listTableView.mj_header endRefreshing];
    }
    if (self.listTableView.mj_footer.isRefreshing) {
        [self.listTableView.mj_footer endRefreshing];
    }
}
- (NSString *)getCurrentStatus {
    
    NSInteger tag = self.currentCellType;
    
    if (tag == 1) {
        return @"0";
        
    } else if (tag == 2) {
        return @"2";
        
    }else if (tag == 3) {
        return @"10";
        
    }else if (tag == 4) {
        return @"-2";
        
    }
    return @"";
}
- (void)setCurrentPages {
    
    NSInteger tag = self.currentCellType;
    
    if (tag == 0) {
        self.recordFirstPage = 1;
        
    } else if (tag == 1) {
        self.recordSecondPage = 1;
        
    }else if (tag == 2) {
        self.recordThirdPage = 1;
        
    }else if (tag == 3) {
        self.recordFourthPage = 1;
        
    }
    self.recordFifthPage = 1;
}
- (void)addCurrentPages {
    NSInteger tag = self.currentCellType;
    
    if (tag == 0) {
        self.recordFirstPage ++;
        
    } else if (tag == 1) {
         self.recordSecondPage ++;
        
    }else if (tag == 2) {
         self.recordThirdPage ++;
        
    }else if (tag == 3) {
         self.recordFourthPage ++;
        
    }
     self.recordFifthPage ++;
}
- (int)getCurrentPages {
    
    NSInteger tag = self.currentCellType;
    
    if (tag == 0) {
        return self.recordFirstPage;
        
    } else if (tag == 1) {
        return self.recordSecondPage;
        
    }else if (tag == 2) {
        return self.recordThirdPage;
        
    }else if (tag == 3) {
        return self.recordFourthPage;
        
    }
    return self.recordFifthPage;
}
- (void)getNewData {
    [self setCurrentPages];
    NSMutableDictionary *para = @{}.mutableCopy;
     para[@"status"] = [self getCurrentStatus];
    
    para[@"page"] = [NSString stringWithFormat:@"%d",[self getCurrentPages]];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_User_Consult Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            [self handleNewDataWithArray:[CSParseManager getConsultModelArrayWithResponseObject:CSGetResult[@"lists"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)handleNewDataWithArray:(NSMutableArray *)array {
    
    NSInteger tag = self.currentCellType;
    
    if (tag == 0) {
       self.allArray = array;
        
    } else if (tag == 1) {
        self.daifukuanArray = array;

    }else if (tag == 2) {
        self.jinxinzhongArray = array;

    }else if (tag == 3) {
        self.yiwanchengArray = array;

    } else {
        self.tuikuanArray = array;

    }

    
    [self.listTableView reloadData];

}
- (void)handleMoreDataWithArray:(NSMutableArray *)array {
    
    if (array.count == 0) {
        CustomWrongMessage(@"下面没有更多数据了");
        return;
    }
    
    NSInteger tag = self.currentCellType;
    
    if (tag == 0) {
        [self.allArray addObjectsFromArray:array];;
        
    } else if (tag == 1) {
        [self.daifukuanArray addObjectsFromArray:array];
        
    }else if (tag == 2) {
        [self.jinxinzhongArray addObjectsFromArray:array];
        
    }else if (tag == 3) {
        [self.yiwanchengArray addObjectsFromArray:array];
        
    } else {
        [self.tuikuanArray addObjectsFromArray:array];
        
    }
    
    [self.listTableView reloadData];

}
- (void)getMoreData {
    
    [self addCurrentPages];
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"status"] = [self getCurrentStatus];
    
    para[@"page"] = [NSString stringWithFormat:@"%d",[self getCurrentPages]];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_User_Consult Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            [self handleMoreDataWithArray:[CSParseManager getConsultModelArrayWithResponseObject:CSGetResult[@"lists"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
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
    if (model.status.integerValue == TuiKuanCellType) {
        return 181;
    }
    
    return 209;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ConsultModel *model = [self getCurrentModel:indexPath.row];
     if (model.status.integerValue == JinXinZhongCellType) {
      
          [self performSegueWithIdentifier:@"ConsultJinXinZhongViewController" sender:self];
     } else if (model.status.integerValue == TuiKuanCellType) {
         
         [self performSegueWithIdentifier:@"ConsultTuiKuanViewController" sender:self];
     }else if (model.status.integerValue == YiWanChengCellType) {
         
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
