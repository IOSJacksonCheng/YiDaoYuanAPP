//
//  LunTanMoreViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanMoreViewController.h"

#import "LunTanTitleTableViewCell.h"
#import "LunTanMoreDetailViewController.h"
@interface LunTanMoreViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) LunTanModel *recordId;

@property (nonatomic, assign) int page;
@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchIcon;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) NSString *recordKey;

@end

@implementation LunTanMoreViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)GetMoreData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"keyword"] = self.recordKey;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_forum_index Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getGouWuCheModelArrayWithResponseObject:CSGetResult[@"lists"]];
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
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"keyword"] = self.recordKey;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_forum_index Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];

        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getLunTanModellWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanTitleTableViewCell)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
}
- (void)configSubViews {
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeKey:) name:UITextFieldTextDidChangeNotification object:self.searchTextField];
}
- (void)changeKey:(NSNotification *)notification {
    
    UITextField *text = (UITextField *)notification.object;
    
    NSString *key = text.text;
    
    if (csCharacterIsBlank(key)) {
        self.searchIcon.hidden = NO;
        self.searchLabel.hidden = NO;
        return;
    }
    self.recordKey = key;
    self.searchIcon.hidden = YES;
    self.searchLabel.hidden = YES;
    [self getNewData];
}
- (void)configNavigationBar {
    
    self.title = @"论坛";
    
    F3f3f3NavigationBarColor
    
    
    
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
    LunTanModel *model = self.listArray[indexPath.section];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LunTanModel *model = self.listArray[indexPath.section];
    self.recordId = model;
    [self performSegueWithIdentifier:@"LunTanMoreDetailViewController" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LunTanMoreDetailViewController"]) {
        LunTanMoreDetailViewController *new = segue.destinationViewController;
        new.passModel = self.recordId;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    view.backgroundColor = csf5f5f5Color;
    
    return view;
}


@end
