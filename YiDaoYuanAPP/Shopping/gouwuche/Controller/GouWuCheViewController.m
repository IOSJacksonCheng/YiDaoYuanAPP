//
//  GouWuCheViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GouWuCheViewController.h"
#import "GouWuCheTableViewCell.h"
#import "ShopSureOrderViewController.h"
@interface GouWuCheViewController ()<UITableViewDelegate, UITableViewDataSource, GouWuCheTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;

- (IBAction)clickAllChooseButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (nonatomic, strong) NSString *recordOrderId;
@end

@implementation GouWuCheViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNewData];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.listArray = @[].mutableCopy;
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self getNewData];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;

    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_cart_list Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {

            self.listArray = [CSParseManager getGouWuCheModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            [self caculateMoney];

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
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_cart_list Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getGouWuCheModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.tableView reloadData];
                [self caculateMoney];

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
    
        [self.tableView registerNib:[UINib nibWithNibName:CSCellName(GouWuCheTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(GouWuCheTableViewCell)];

  
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
}

- (void)configSubViews {
    
    self.payButton.layer.cornerRadius = 5;
    self.payButton.layer.masksToBounds = YES;
    
    [self.payButton addTarget:self action:@selector(clickPayMoneyButton) forControlEvents:UIControlEventTouchDown];
}
- (void)clickPayMoneyButton {
    
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    NSMutableArray *array = @[].mutableCopy;
    
    for (GouWuCheModel *model in self.listArray) {
        if (model.choose) {
            [array addObject:model.cart_id];
        }
    }
    
    if (array.count == 0) {
        CustomWrongMessage(@"请先选择要购买的产品");
        return;
    }
    for (int i = 0 ; i < array.count; i ++) {
        para[[NSString stringWithFormat:@"shipp_cart[%d]",i]] = array[i];
    }
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Cart_Cart_creat_order Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
           self.recordOrderId = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            
            [self performSegueWithIdentifier:@"ShopSureOrderViewController" sender:self];

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
- (void)configNavigationBar {
    
    
    self.title = @"购物车";
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)clickLeftButtonDone {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GouWuCheTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(GouWuCheTableViewCell)];
    GouWuCheModel *model = self.listArray[indexPath.row];
    cell.model = model;
    cell.csDelegate = self;
    return cell;
}
- (void)refreshAllMoney {
    [self caculateMoney];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    GouWuCheModel *model = self.listArray[indexPath.row];
    
    model.choose = !model.choose;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    [self caculateMoney];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 126;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        NSMutableDictionary *para = @{}.mutableCopy;
        GouWuCheModel *model = self.listArray[indexPath.row];

        para[@"cart_id[0]"] = model.cart_id;
        [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_Delcart Pameters:para success:^(id  _Nonnull responseObject) {
            
            if (CSInternetRequestSuccessful) {
                [self.listArray removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
                [self caculateMoney];

            }else {
                CSShowWrongMessage
            }
        } failure:^(NSError * _Nonnull error) {
            CSInternetFailure
        }];
        
    }
    
}
- (IBAction)clickAllChooseButtonDone:(UIButton *)sender {
    
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        for (GouWuCheModel *model in self.listArray) {
        
            model.choose = YES;
            
        }
        
    } else {
    
        for (GouWuCheModel *model in self.listArray) {
            
            model.choose = NO;
            
        }
    }
    
    [self.tableView reloadData];
    
    [self caculateMoney];
    
}
- (void)caculateMoney {
    float total = 0;
    for (GouWuCheModel *model in self.listArray) {
        if (model.choose) {
            total += model.price.floatValue * model.willBuyNum.floatValue;

        }
        
    }
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",total];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShopSureOrderViewController"]) {
        ShopSureOrderViewController *new = segue.destinationViewController;
        new.passOrderId = self.recordOrderId;
    }
}
@end
