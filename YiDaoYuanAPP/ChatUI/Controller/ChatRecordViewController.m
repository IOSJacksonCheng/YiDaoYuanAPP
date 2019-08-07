//
//  ChatRecordViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/5.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ChatRecordViewController.h"

#import "ChatLeftTableViewCell.h"
#import "ChatLeftImageTableViewCell.h"
#import "ChatRightTableViewCell.h"
#import "ChatRightImageTableViewCell.h"
#import "ChatVoiceLeftTableViewCell.h"
#import "ChatVoiceRightTableViewCell.h"


@interface ChatRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation ChatRecordViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];

    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChatLeftTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatLeftTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChatLeftImageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatLeftImageTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChatRightTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatRightTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChatRightImageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatRightImageTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChatVoiceLeftTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatVoiceLeftTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ChatVoiceRightTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ChatVoiceRightTableViewCell)];
    
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
 
    WhiteNavigationBarColor
    
    self.title = @"聊天记录";
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page += 1;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"order_id"] = self.orderId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_chat_msg Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getCSChatModelWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                
                CustomWrongMessage(@"下面没有数据了");
                
            }else {
                
                
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
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"order_id"] = self.orderId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_chat_msg Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
           
            self.listArray = [CSParseManager getCSChatModelWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(@"")];
    return cell;
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
        
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
@end
