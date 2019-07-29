//
//  ShoppingAllOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAllOrderViewController.h"

#import "ShoppingAllOrderTableViewCell.h"
#import "ShoppingAllOrderTitleTableViewCell.h"
#import "ShoppingAllOrderButtonTableViewCell.h"

#import "ShopSureOrderPayMoneyWayViewController.h"
#import "ShoppingHaveFinishedViewController.h"
#import "ShoppingWaitReceiveGoodsViewController.h"
#import "EasyUIChatViewController.h"
typedef NS_ENUM(NSInteger, CSCellType) {
    DaiFuKuanCSCellType = 0,
    DaiFaHuoCSCellType = 1,
    DaiShouHuoCSCellType = 2,
    YiWanChengCSCellType = 10,
    AllCSCellType = 100
};
@interface ShoppingAllOrderViewController ()<UITableViewDelegate, UITableViewDataSource,ShoppingAllOrderButtonTableViewCellDelegate, ShopSureOrderPayMoneyWayViewControllerDelegate>
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

@property (nonatomic, assign) int recordFirstPage;
@property (nonatomic, assign) int recordSecondPage;

@property (nonatomic, assign) int recordThirdPage;

@property (nonatomic, assign) int recordFourthPage;

@property (nonatomic, assign) int recordFifthPage;

@property (nonatomic, strong) NSString *recordOrderId;

@property (nonatomic, strong) NSString *recordStatus;

- (IBAction)clickKefuButtonDone:(id)sender;

@end

@implementation ShoppingAllOrderViewController
- (NSMutableArray *)yiwanchengArray {
    if (!_yiwanchengArray) {
        _yiwanchengArray = @[].mutableCopy;

    }
    return _yiwanchengArray;
}
- (NSMutableArray *)daishouhuoArray {
    if (!_daishouhuoArray) {
        _daishouhuoArray = @[].mutableCopy;

    }
    return _daishouhuoArray;
}
- (NSMutableArray *)daifahuoArray {
    if (!_daifahuoArray) {
        _daifahuoArray = @[].mutableCopy;
        
    }
    return _daifahuoArray;
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sendGetRequestForInfomation:self.currentCSCellType];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
   
    self.currentCSCellType = self.passTag;
    
    [self sendGetRequestForInfomation:self.currentCSCellType];
    [self changeButtonStatusWithTag:self.currentCSCellType];
}

- (void)configTableView {
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAllOrderTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAllOrderTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAllOrderTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAllOrderTitleTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAllOrderButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAllOrderButtonTableViewCell)];

    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
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


- (IBAction)clickTopViewButtonDone:(UIButton *)sender {
    
    
    [self sendGetRequestForInfomation:sender.tag];
    [self changeButtonStatusWithTag:sender.tag];
    
}
- (void)changeButtonStatusWithTag:(NSUInteger)tag {
    
    self.currentCSCellType = tag;
    if (tag == AllCSCellType) {
        //全部付款
        [self.firstButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    } else {
        [self.firstButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    if (tag == DaiFuKuanCSCellType) {
        //待付款
        [self.secondButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.secondButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    
    
    if (tag == DaiFaHuoCSCellType) {
        //进行中
        [self.thirdButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.thirdButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    if (tag == DaiShouHuoCSCellType) {
        //已完成
        [self.fourthButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.fourthButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    
    if (tag == YiWanChengCSCellType) {
        //退款
        [self.fifthButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.fifthButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        CGFloat width = MainScreenWidth * 0.2;
        
        if (tag == AllCSCellType) {
            
            self.lineViewWidth.constant = 60;
            
            self.lineViewLeftConstraint.constant = width * 0 + width * 0.5 - 60 * 0.5;
            
            
        } else if (tag == YiWanChengCSCellType) {
            
            self.lineViewWidth.constant = 30;
            self.lineViewLeftConstraint.constant = width * 4 + width * 0.5 - 30 * 0.5;
        }  else if (tag == DaiFuKuanCSCellType) {
            self.lineViewWidth.constant = 45;
            self.lineViewLeftConstraint.constant = width * 1 + width * 0.5 - 45 * 0.5;
        } else if (tag == DaiFaHuoCSCellType) {
            self.lineViewWidth.constant = 45;
            self.lineViewLeftConstraint.constant = width * 2 + width * 0.5 - 45* 0.5;
        }  else if (tag == DaiShouHuoCSCellType) {
            
            self.lineViewLeftConstraint.constant = self.lineViewWidth.constant = 45;
            self.lineViewLeftConstraint.constant = width * 3 + width * 0.5 - 45 * 0.5;
            
        }
        [self.view layoutIfNeeded];
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self getCurrentArray].count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    AllOrderModel *model = [self getCurrentModel:section];
    
    return model.goods.count + 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllOrderModel *model = [self getCurrentModel:indexPath.section];
    if (indexPath.row == 0) {
        ShoppingAllOrderTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAllOrderTitleTableViewCell)];
       
        cell.model = model;
        return cell;
    }
    if (indexPath.row == model.goods.count + 2 - 1) {
        ShoppingAllOrderButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAllOrderButtonTableViewCell)];
        cell.csDelegate = self;
        cell.model = model;
        return cell;
    }
    
    ShoppingAllOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAllOrderTableViewCell)];
    
    if (indexPath.row - 1 >= 0 && indexPath.row - 1 < model.goods.count) {
        AllOrderModel *subModel = model.goods[indexPath.row - 1];
        
        cell.model = subModel;

    }
        return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 48;
    }
    AllOrderModel *model = [self getCurrentModel:indexPath.section];
    if (indexPath.row == model.goods.count + 2 - 1) {
        if (model.status.integerValue == YiWanChengCSCellType || [model.status isEqualToString:@"-2"] || [model.status isEqualToString:@"-1"] || [model.status isEqualToString:@"-3"] || [model.status isEqualToString:@"1"]) {
            return 36;
        }
        return 82;
    }
   
    
    return 99;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllOrderModel *model = [self getCurrentModel:indexPath.section];
//    if (model.status.intValue == YiWanChengCSCellType) {
//        self.recordOrderId = model.order_id;
//         [self performSegueWithIdentifier:@"ShoppingHaveFinishedViewController" sender:self];
//    } else if (model.status.intValue == DaiShouHuoCSCellType) {
//        self.recordOrderId = model.order_id;
//         [self performSegueWithIdentifier:@"ShoppingWaitReceiveGoodsViewController" sender:self];
//    }
    self.recordOrderId = model.order_id;
    self.recordStatus = model.status;
             [self performSegueWithIdentifier:@"ShoppingWaitReceiveGoodsViewController" sender:self];
}
- (AllOrderModel *)getCurrentModel:(NSInteger)row {
    NSMutableArray *array = [self getCurrentArray];
    if (array.count == 0 || row >= array.count) {
        return [AllOrderModel new];
    }
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

- (void)sendGetRequestForInfomation:(NSInteger)tag {
    
    self.currentCSCellType = tag;
    
   [self getNewData];
    
}

- (void)endRefresh {
    if (self.listTableView.mj_header.isRefreshing) {
        [self.listTableView.mj_header endRefreshing];
    }
    if (self.listTableView.mj_footer.isRefreshing) {
        [self.listTableView.mj_footer endRefreshing];
    }
}

- (void)setCurrentPages {
    
    NSInteger tag = self.currentCSCellType;
    
    if (tag == AllCSCellType) {
        self.recordFirstPage = 1;
        
    } else if (tag == DaiFuKuanCSCellType) {
        self.recordSecondPage = 1;
        
    }else if (tag == DaiFaHuoCSCellType) {
        self.recordThirdPage = 1;
        
    }else if (tag == DaiShouHuoCSCellType) {
        self.recordFourthPage = 1;
        
    }
    self.recordFifthPage = 1;
}
- (void)addCurrentPages {
    NSInteger tag = self.currentCSCellType;
    
    if (tag == AllCSCellType) {
        self.recordFirstPage ++;
        
    } else if (tag == DaiFuKuanCSCellType) {
        self.recordSecondPage ++;
        
    }else if (tag == DaiFaHuoCSCellType) {
        self.recordThirdPage ++;
        
    }else if (tag == DaiShouHuoCSCellType) {
        self.recordFourthPage ++;
        
    }
    self.recordFifthPage ++;
}
- (int)getCurrentPages {
    
    NSInteger tag = self.currentCSCellType;
    
    if (tag == AllCSCellType) {
        return self.recordFirstPage;
        
    } else if (tag == DaiFuKuanCSCellType) {
        return self.recordSecondPage;
        
    }else if (tag == DaiFaHuoCSCellType) {
        return self.recordThirdPage;
        
    }else if (tag == DaiShouHuoCSCellType) {
        return self.recordFourthPage;
        
    }
    return self.recordFifthPage;
}
- (void)getNewData {
    [self setCurrentPages];
    NSMutableDictionary *para = @{}.mutableCopy;
    if (self.currentCSCellType != AllCSCellType) {
        para[@"status"] = [NSString stringWithFormat:@"%ld",self.currentCSCellType];
    }
    
    
    para[@"page"] = [NSString stringWithFormat:@"%d",[self getCurrentPages]];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_order_list Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            [self handleNewDataWithArray:[CSParseManager getAllOrderModelArrayWithResponseObject:CSGetResult[@"lists"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)handleNewDataWithArray:(NSMutableArray *)array {
    
    NSInteger tag = self.currentCSCellType;
    
    if (tag == DaiFuKuanCSCellType) {
        self.daifukuanArray = array;
        
    } else if (tag == DaiFaHuoCSCellType) {
        self.daifahuoArray = array;
        
    }else if (tag == DaiShouHuoCSCellType) {
        self.daishouhuoArray = array;
        
    }else if (tag == YiWanChengCSCellType) {
        self.yiwanchengArray = array;
        
    } else {
        self.allArray = array;
        
    }
    
    
    [self.listTableView reloadData];
    
}
- (void)handleMoreDataWithArray:(NSMutableArray *)array {
    
    if (array.count == 0) {
        CustomWrongMessage(@"下面没有更多数据了");
        return;
    }
    
    NSInteger tag = self.currentCSCellType;
    
    if (tag == DaiFuKuanCSCellType) {
        [self.daifukuanArray addObjectsFromArray:array];;
        
    } else if (tag == DaiFaHuoCSCellType) {
        [self.daifahuoArray addObjectsFromArray:array];
        
    }else if (tag == DaiShouHuoCSCellType) {
        [self.daishouhuoArray addObjectsFromArray:array];
        
    }else if (tag == YiWanChengCSCellType) {
        [self.yiwanchengArray addObjectsFromArray:array];
        
    } else {
        [self.allArray addObjectsFromArray:array];
        
    }
    
    [self.listTableView reloadData];
    
}
- (void)getMoreData {
    
    [self addCurrentPages];
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    if (self.currentCSCellType != AllCSCellType) {
        para[@"status"] = [NSString stringWithFormat:@"%ld",self.currentCSCellType];
    }
    
    para[@"page"] = [NSString stringWithFormat:@"%d",[self getCurrentPages]];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_order_list Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            [self handleMoreDataWithArray:[CSParseManager getAllOrderModelArrayWithResponseObject:CSGetResult[@"lists"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
#pragma mark -- ShoppingAllOrderButtonTableViewCellDelegate
- (void)clickCheckWuLiu {
    
}
- (void)clickCancelOrderDone {
    [self sendGetRequestForInfomation:self.currentCSCellType];
}
- (void)passOrderId:(NSString *)orderID {
    self.recordOrderId = orderID;
    [self performSegueWithIdentifier:@"ShopSureOrderPayMoneyWayViewController" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShopSureOrderPayMoneyWayViewController"]) {
        ShopSureOrderPayMoneyWayViewController *new = segue.destinationViewController;
        new.passOrderId = self.recordOrderId;
        new.passOrderType = @"4";
        new.csDelegate = self;
    } else if ([segue.identifier isEqualToString:@"ShoppingWaitReceiveGoodsViewController"]){
        ShoppingWaitReceiveGoodsViewController *new = segue.destinationViewController;
        new.passOrderId = self.recordOrderId;
        new.passStatus = self.recordStatus;
    }
    /**else if ([segue.identifier isEqualToString:@"ShoppingHaveFinishedViewController"]) {
     ShoppingHaveFinishedViewController *new = segue.destinationViewController;
     new.passOrderId = self.recordOrderId;
     }*/
}
- (void)successGoBack {
    [self sendGetRequestForInfomation:self.currentCSCellType];

}
- (IBAction)clickKefuButtonDone:(id)sender {
    
    [CSUtility shoppingGoToKefuController];
    
    
}



@end
