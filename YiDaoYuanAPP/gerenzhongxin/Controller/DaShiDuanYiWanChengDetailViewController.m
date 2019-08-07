//
//  DaShiDuanYiWanChengDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/6.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDuanYiWanChengDetailViewController.h"

#import "DaShiDuanYiWanChengDetailTableViewCell.h"
#import "DaShiDuanYiWanChengInfoTableViewCell.h"
#import "DaShiDuanYiWanChengJudgeTableViewCell.h"

#import "DaShiOrderInfoModel.h"

#import "GoToJudgePictureTableViewCell.h"

#import "GoToJudgeJudgeModel.h"
@interface DaShiDuanYiWanChengDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *checkLiaoTianButton;
@property (nonatomic, strong) DaShiOrderInfoModel *infoModel;

@property (nonatomic, strong) NSMutableDictionary *csDictionary;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation DaShiDuanYiWanChengDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    
    [self sendGetRequest];
    
}
- (void)sendGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.consult.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_mcenter_consultinfo Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.infoModel = [CSParseManager getSingleDaShiOrderInfoModellWithResponseObject:CSGetResult];
            
            self.csDictionary = CSGetResult[@"evaluation"];
            NSArray *array = self.csDictionary[@"imgs"];
            NSMutableArray *newArray = @[].mutableCopy;
            for (NSString *image in array) {
                GoToJudgeJudgeModel *model = [GoToJudgeJudgeModel new];
                model.url = image;
                [newArray addObject:model];
            }
            
            self.listArray = newArray;
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
    
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanYiWanChengJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanYiWanChengJudgeTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(GoToJudgePictureTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(GoToJudgePictureTableViewCell)];

    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)clickCheckJiLuDone {
    [CSUtility goToHistoryChatViewControllerWithOrderId:self.infoModel.order_id];
}
- (void)configSubViews {
//    self.rightNowButton.layer.cornerRadius = 23;
//    self.rightNowButton.layer.masksToBounds = YES;
    [self.checkLiaoTianButton addTarget:self action:@selector(clickCheckJiLuDone) forControlEvents:UIControlEventTouchDown];
    self.checkLiaoTianButton.layer.cornerRadius = 23;
    self.checkLiaoTianButton.layer.borderWidth = 1;
    self.checkLiaoTianButton.layer.borderColor = cs999999Color.CGColor;
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
    if (self.csDictionary) {
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    NSArray *array = self.csDictionary[@"imgs"];
    if (array.count == 0) {
        return 1;
    }
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
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
        if (indexPath.row == 3) {
            
            DaShiDuanYiWanChengInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengInfoTableViewCell)];
            cell.csTitleLabel.text = @"性别：";
            cell.csContentLabel.text = self.infoModel.sex;
            
            return cell;
            
        }
        
    }
    if (indexPath.row == 0) {
        DaShiDuanYiWanChengJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanYiWanChengJudgeTableViewCell)];
        
        
        cell.dict = self.csDictionary;
        
        
        
        return cell;
    }
    
    GoToJudgePictureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(GoToJudgePictureTableViewCell) forIndexPath:indexPath];
    
    
    cell.listArray = self.listArray;
    cell.showTitleView = NO;
    return cell;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 139;
        }
        
        return 50;
    }
    
    if (indexPath.row == 0) {
        return 153.5 + [CSUtility accrodingTextGiveItHeightWith:[NSString stringWithFormat:@"%@",self.csDictionary[@"content"]] WithLabelInterval:40 WithFont:16];
    }
   
    
    return 400;
}
@end
