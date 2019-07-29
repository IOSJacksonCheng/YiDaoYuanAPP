//
//  XiaoXiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "XiaoXiTableViewCell.h"
#import "XiaoXiModel.h"
#import "ChatViewController.h"
@interface XiaoXiViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation XiaoXiViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.animationImageView startAnimating];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getNewData];
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(XiaoXiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(XiaoXiTableViewCell)];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
    self.tableview.rowHeight = 87.5;
}
- (void)configSubViews {
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"消息列表";
    
    F3f3f3NavigationBarColor
    
    
//    UIButton *rightButton = [[UIButton alloc] init];
//
//    [rightButton setTitle:@"论坛" forState:UIControlStateNormal];
//    [rightButton setTitleColor:csBlueColor forState:UIControlStateNormal];
//    rightButton.titleLabel.font = csCharacterFont_18;
//
//    [rightButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
//
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//
//
//    UIButton *rightButton1 = [[UIButton alloc] init];
//
//    [rightButton1 setImage:DotaImageName(@"icon_luntan") forState:UIControlStateNormal];
//
//
//    [rightButton1 addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
//
//    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:rightButton1];
//
//    self.navigationItem.rightBarButtonItems = @[rightItem, rightItem1];
    
    NSMutableArray *allImage = @[].mutableCopy;
    
    for (int i = 1; i < 6; i ++) {
        
        NSString *rightCellName = [NSString stringWithFormat:@"论坛动图_%d",i];
        
        UIImage *image = DotaImageName(rightCellName);
        
        [allImage addObject:image];
        
    }
    
    [self.animationImageView setAnimationImages:allImage];
    
    self.animationImageView.animationRepeatCount = HUGE;
    self.animationImageView.animationDuration = 2.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightButtonDone)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.animationImageView addGestureRecognizer:tap];
}
- (void)clickRightButtonDone {
    
    [self performSegueWithIdentifier:@"LunTanViewController" sender:self];
    
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiaoXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(XiaoXiTableViewCell)];
    XiaoXiModel *model = self.listArray[indexPath.row];

        cell.userTitle.text = model.user_nickname;
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
        cell.userContent.text = model.content;
        cell.tiXingImageView.hidden = model.status;
    
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        XiaoXiModel *model = self.listArray[indexPath.row];
        
        NSMutableDictionary *para = @{}.mutableCopy;
        
        para[@"msg_id"] = model.msg_id;
        
        [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_msg_del Pameters:para success:^(id  _Nonnull responseObject) {
            
            if (CSInternetRequestSuccessful) {
                [self.listArray removeObjectAtIndex:indexPath.row];
                [self.tableview reloadData];
                
            }else {
                CSShowWrongMessage
            }
        } failure:^(NSError * _Nonnull error) {
            CSInternetFailure
        }];
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ChatViewController *new = [ChatViewController new];
//    
//    [self.navigationController pushViewController:new animated:YES];
}

- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_msg_index Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getXiaoXiModellWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableview reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
}
- (void)GetMoreData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_msg_index Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getXiaoXiModellWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.tableview reloadData];
                
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
    if (self.tableview.mj_header.isRefreshing) {
        [self.tableview.mj_header endRefreshing];
    }
    if (self.tableview.mj_footer.isRefreshing) {
        [self.tableview.mj_footer endRefreshing];
    }
}
@end
