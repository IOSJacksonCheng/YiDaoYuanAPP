//
//  ChooseDaShiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChooseDaShiViewController.h"

#import "ChooseDaShiTableViewCell.h"
#import "ChooseDaShiPersonalTableViewCell.h"

#import "PlaySurePayMoneyViewController.h"
@interface ChooseDaShiViewController ()<UITableViewDelegate, UITableViewDataSource>
- (IBAction)clickSureButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSString *recordMasterId;
@end

@implementation ChooseDaShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.listArray = @[].mutableCopy;
    [self getNewData];
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    self.page ++;
    para[@"cat_id"] = self.passCat_id;

    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Master_Qa Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getChooseDaShiModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！");            } else {
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
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    self.page = 1;
    para[@"cat_id"] = self.passCat_id;

    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Master_Qa Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getChooseDaShiModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChooseDaShiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChooseDaShiTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChooseDaShiPersonalTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChooseDaShiPersonalTableViewCell)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"选择大师";
}

- (IBAction)clickSureButtonDone:(id)sender {
    
    BOOL goOn = NO;
    
    ChooseDaShiModel *newModel = [ChooseDaShiModel new];
    for (ChooseDaShiModel *model in self.listArray) {
        if (model.choose) {
            newModel = model;
            goOn = YES;
            break;
        }
    }
    if (!goOn) {
        CustomWrongMessage(@"选择一位大师");
        return;
    }
    self.recordMasterId = newModel.master_id;
    [self performSegueWithIdentifier:@"PlaySurePayMoneyViewController" sender:self];
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChooseDaShiModel *model = self.listArray[indexPath.row];
    
    if ([model.master_id isEqualToString:@"0"]) {
        ChooseDaShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChooseDaShiTableViewCell)];
        cell.model = model;
        return cell;
    }
   
    ChooseDaShiPersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ChooseDaShiPersonalTableViewCell)];
    cell.model = model;

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (ChooseDaShiModel *model in self.listArray) {
        model.choose = NO;
    }
    
     ChooseDaShiModel *model = self.listArray[indexPath.row];
    model.choose = YES;
    
    [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 137;
    }
    return 107;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlaySurePayMoneyViewController"]) {
        PlaySurePayMoneyViewController *new = segue.destinationViewController;
        new.dashiID = self.recordMasterId;
        new.csCat_id = self.passCat_id;
        new.passQuestion_id = self.passQuestion_id;
        new.personalQuestion = self.personalQuestion;
    }
}
@end
