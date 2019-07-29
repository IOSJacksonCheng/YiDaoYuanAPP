//
//  DaShiDuanDaiHuiFuViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/6.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDuanDaiHuiFuViewController.h"
#import "DaShiDuanYiWanChengDetailTableViewCell.h"
#import "DaShiDuanYiWanChengInfoTableViewCell.h"

#import "DaShiOrderInfoModel.h"
#import "EasyUIChatViewController.h"
@interface DaShiDuanDaiHuiFuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *rightNowButton;
@property (nonatomic, strong) DaShiOrderInfoModel *infoModel;
- (IBAction)rebackButtonDone:(id)sender;

@end

@implementation DaShiDuanDaiHuiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self sendGetRequest];
}
- (void)sendGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.orderId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_mcenter_consultinfo Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.infoModel = [CSParseManager getSingleDaShiOrderInfoModellWithResponseObject:CSGetResult];
            
            
            [self.tableView reloadData];
            
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanYiWanChengDetailTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanYiWanChengDetailTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanYiWanChengInfoTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    self.rightNowButton.layer.cornerRadius = 5;
    self.rightNowButton.layer.masksToBounds = YES;
    
   
    
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"确认订单";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DaShiDuanYiWanChengDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengDetailTableViewCell)];
        cell.model = self.infoModel;

        return cell;
    }
    if (indexPath.row == 1) {
       
        DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
        cell.csTitleLabel.text = @"姓名：";
        cell.csContentLabel.text = self.infoModel.name;
       
        return cell;
        
    }
    
    if (indexPath.row == 2) {
        
        DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
        
        cell.csTitleLabel.text = @"生日：";
        cell.csContentLabel.text = self.infoModel.birthday;
        
        
        return cell;
    }
    
        
    
    DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
        cell.csTitleLabel.text = @"性别：";
        cell.csContentLabel.text = self.infoModel.sex;
        
    
    return cell;
    
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 139;
    }
   
    
    return 50;
}

- (IBAction)rebackButtonDone:(id)sender {
    if (![EMClient sharedClient].isLoggedIn) {
        [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"m%@",CS_UserID] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
            if (aError) {
                CSLog(@"环信登录失败:%@",aError.errorDescription);
                CustomWrongMessage(@"发送错误，请稍后再试");
            } else {
                [self goToChatView];
                CSLog(@"环信登录成功！");
            }
        }];
        
        
    }
    
}

- (void)goToChatView {
        
        EasyUIChatViewController *new = [[EasyUIChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"o%@",self.infoModel.order_id] conversationType:EMConversationTypeChat];
        
        new.name = self.infoModel.user_nickname;
    
    new.avater = self.infoModel.avatar;
    new.isDaShi = YES;
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
        

}

@end
