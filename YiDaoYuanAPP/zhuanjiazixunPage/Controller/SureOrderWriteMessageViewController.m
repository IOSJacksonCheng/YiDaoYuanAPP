//
//  SureOrderWriteMessageViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "SureOrderWriteMessageViewController.h"
#import "SureOrderCourseTableViewCell.h"
#import "EasyUIChatViewController.h"

@interface SureOrderWriteMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;

- (IBAction)clickContactButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTF;
@property (weak, nonatomic) IBOutlet UITextField *genderTF;

@end

@implementation SureOrderWriteMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)submitInfo {
    [self.view endEditing:YES];
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.infoModel.order_id;
    para[@"name"] = self.nameTextField.text;

    para[@"birthday"] = self.birthdayTF.text;

    para[@"sex"] = self.genderTF.text;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_consult_fillorder Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
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
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)goToChatView {
    EasyUIChatViewController *new = [[EasyUIChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"m%@",self.infoModel.master_id] conversationType:EMConversationTypeChat];
    
    new.avater = self.infoModel.avatar;
    new.name = self.infoModel.master_name;
    new.order_id = self.infoModel.order_id;
    [self.navigationController pushViewController:new animated:YES];
    
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderCourseTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 73;
}
- (void)configSubViews {
    self.surePayButton.layer.cornerRadius = 5;
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"填写信息";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    SureOrderCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderCourseTableViewCell)];
    cell.secondLabel.textColor = csBlueColor;
    cell.secondImageView.image = DotaImageName(@"icon_2_zhifu_pre");
    return cell;
}
- (IBAction)clickContactButtonDone:(id)sender {
    [self submitInfo];
}
@end
