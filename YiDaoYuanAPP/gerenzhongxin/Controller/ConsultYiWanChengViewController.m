//
//  ConsultYiWanChengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultYiWanChengViewController.h"
#import "SureOrderDaShiInfomationTableViewCell.h"
#import "SureOrderCourseTableViewCell.h"
#import "GoToJudgeViewController.h"
#import "EasyUIChatViewController.h"
@interface ConsultYiWanChengViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic, strong) DaShiOrderInfoModel *infoModel;

- (IBAction)checkLiaoTianJiLuButtonDone:(id)sender;

- (IBAction)clickJudgeButtonDone:(id)sender;

@end

@implementation ConsultYiWanChengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getDashiInfomation];
}
- (void)getDashiInfomation {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_order_msg Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.infoModel = [CSParseManager getSingleDaShiOrderInfoModellWithResponseObject:CSGetResult];
            [self.listTableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderDaShiInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderCourseTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.cornerRadius = 25;
    
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.cornerRadius = 25;
    self.leftButton.layer.borderWidth = 1;
    self.leftButton.layer.borderColor = cs999999Color.CGColor;
}
- (void)configNavigationBar {
    self.title = @"在线咨询";
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        SureOrderDaShiInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
        cell.model = self.infoModel;
        return cell;
    }
    
    SureOrderCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    cell.thirdImageView.image = DotaImageName(@"img_3_xinxi-1");
    cell.fourthImageView.image = DotaImageName(@"img_4_zixun-1");
    cell.thirdLabel.textColor = csBlueColor;
    cell.fourthLabel.textColor = csBlueColor;
    cell.secondLabel.textColor = csBlueColor;
    cell.secondImageView.image = DotaImageName(@"img_2_queren-1");
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        return 73;
    }
    return 237;
    
}

- (IBAction)checkLiaoTianJiLuButtonDone:(id)sender {
    if (![EMClient sharedClient].isLoggedIn) {
        [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"o%@",self.infoModel.order_id] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
            if (aError) {
                CSLog(@"环信登录失败:%@",aError.errorDescription);
                CustomWrongMessage(@"发送错误，请稍后再试");
            } else {
                [self goToChatView];
                CSLog(@"环信登录成功！");
            }
        }];
    } else {
        [self goToChatView];
        
    }
    
    
    
    
    
}
- (void)goToChatView {
    
    EasyUIChatViewController *new = [[EasyUIChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"m%@",self.infoModel.master_id] conversationType:EMConversationTypeChat];
    
    new.name = self.infoModel.master_name;
    new.order_id = self.infoModel.order_id;
    [self.navigationController pushViewController:new animated:YES];
    
}

- (IBAction)clickJudgeButtonDone:(id)sender {
    
    GoToJudgeViewController *new = [GoToJudgeViewController new];
   
    new.order_id = self.infoModel.order_id;
    
        new.typestring = @"1";
        

    
    [self.navigationController pushViewController:new animated:YES];
}
@end
