//
//  JinXinZhongDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "JinXinZhongDetailViewController.h"

#import "ConsultJinXingZhongTableViewCell.h"
#import "ConsultMyHuiFuTableViewCell.h"
#import "ConsultHuiFuTableViewCell.h"
#import "SureOrderDaShiInfomationTableViewCell.h"

#import "DaShiOrderInfoModel.h"
#import "ReplyDetailModel.h"

#import "GoToJudgeViewController.h"

#import "DaShiOrderInfoModel.h"
@interface JinXinZhongDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickSendButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *rebackTextField;
@property (nonatomic, strong) DaShiOrderInfoModel *infomodel;

@property (nonatomic, strong) NSMutableArray *listArray;


@end

@implementation JinXinZhongDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.listArray = @[].mutableCopy;
    [self sendGetRequest];
}
- (void)clickEndConsult {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_qa_finish Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            GoToJudgeViewController *new = [GoToJudgeViewController new];
            new.typestring = @"3";

            new.order_id = self.order_id;
            [self.navigationController pushViewController:new animated:YES];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}


- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_QA_detail Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.infomodel = [CSParseManager getSingleDaShiOrderInfoModellWithResponseObject:CSGetResult];
            self.listArray = [CSParseManager getReplyDetailModelWithResponseObject:CSGetResult[@"reply"]];
            
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(SureOrderDaShiInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultMyHuiFuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultMyHuiFuTableViewCell)];
 [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultHuiFuTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultHuiFuTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultJinXingZhongTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultJinXingZhongTableViewCell)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)configSubViews {
    if (CS_UserIsMaster) {
        self.rebackTextField.placeholder = @"回复用户";
    }
}
- (void)configNavigationBar {
   
    self.title = @"咨询详情";
    
    F3f3f3NavigationBarColor
   
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];

    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];

    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    if (!CS_UserIsMaster) {
        
        
        UIButton *button = [[UIButton alloc] init];
        
        [self.view addSubview:button];
        [button addTarget:self action:@selector(clickEndConsult) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"结束咨询" forState:UIControlStateNormal];
        
        button.titleLabel.font = csCharacterFont_15;
        
        [button setTitleColor:csBlueColor forState:UIControlStateNormal];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 1;
    }
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0)) {
        ConsultJinXingZhongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultJinXingZhongTableViewCell)];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:self.infomodel.user_avatar] placeholderImage:CSUserImagePlaceHolder];
        cell.nameLabel.text = self.infomodel.user_name;
        cell.qaLabel.text = self.infomodel.issue;
        cell.categoryLabel.text = [NSString stringWithFormat:@"%@ %@",self.infomodel.item_title, self.infomodel.last_login_time];
        
        return cell;
        
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            SureOrderDaShiInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(SureOrderDaShiInfomationTableViewCell)];
            cell.model = self.infomodel;
            
            return cell;
        }
       
       
    }
    
    ReplyDetailModel *model = self.listArray[indexPath.row];
    if (model.is_reply) {
        ConsultMyHuiFuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultMyHuiFuTableViewCell)];
        cell.contentLabel.text = model.content;
        return cell;
    }
    ConsultHuiFuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultHuiFuTableViewCell)];
    cell.contentLabel.text = model.content;

    return cell;
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 0)) {
        return 81 + [CSUtility accrodingTextGiveItHeightWith:self.infomodel.issue WithLabelInterval:17 + 19 WithFont:15];
    }
    if (indexPath.section == 0) {
        
       
        return 237;
    }

    ReplyDetailModel *model = self.listArray[indexPath.row];
    if (model.is_reply) {
        return 16 + 11 + 20.5 +[CSUtility accrodingTextGiveItHeightWith:model.content WithLabelInterval:50 WithFont:15];
    }
    return 20 + [CSUtility accrodingTextGiveItHeightWith:model.content WithLabelInterval:10 + 34 WithFont:15];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    
    view.backgroundColor = UIColor.whiteColor;
    
    UILabel *label = UILabel.new;
    
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.centerY.mas_equalTo(0);
    }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"互动问答详情" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 44;
    }
    return 0;
}
- (IBAction)clickSendButtonDone:(id)sender {
    
    if (csCharacterIsBlank(self.rebackTextField.text)) {
        CustomWrongMessage(@"不可回复空内容");
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.order_id;
    para[@"reply"] = self.rebackTextField.text;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_qa_reply Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            [self sendGetRequest];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
@end
