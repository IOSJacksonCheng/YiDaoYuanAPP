//
//  PersonalCenterViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCollectionViewCell.h"
#import "PersonalModel.h"
#import "MoneyHistoryViewController.h"
#import "UserJudgeViewController.h"
#import "NewPersonalCenterViewTableViewCell.h"
#import "PersonalFirstRowTableViewCell.h"

#import "WkWebViewViewController.h"
#import "AllKindOfOrderViewController.h"
#import "MoneyHistoryViewController.h"

#import "PersonalInfomationViewController.h"

#import "CSUserJudgeListViewController.h"
#import "DaShisPingJiaViewController.h"
@interface PersonalCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *itemMutableArray;

@property (nonatomic, strong) NSMutableArray *daShiMutableArray;

@property (nonatomic, strong) NSString *recordYuEOrYiDaoYunTitle;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *recordTitle;
@property (nonatomic, strong) NSString *recordUrl;

@property (nonatomic, assign) OrderType currentType;

@property (nonatomic, strong) NSString *recordZiXunOrHuiDa;
@property (nonatomic, assign) MoneyType currentMoneyType;



@end

@implementation PersonalCenterViewController

- (NSMutableArray *)daShiMutableArray {
    if (!_daShiMutableArray) {
        _daShiMutableArray = @[].mutableCopy;
        
//        PersonalModel *model1 = [PersonalModel new];
//        
//        model1.title = @"我的评价";
//        model1.image = @"icon_1_pingjia-1";
//        
//        [_daShiMutableArray addObject:model1];
        
//        PersonalModel *model2 = [PersonalModel new];
//        model2.title = @"我的问答";
//        model2.image = @"icon_2_wenda-1";
//        [_daShiMutableArray addObject:model2];
        
        PersonalModel *model3 = [PersonalModel new];
        model3.title = @"我的评分";
        model3.image = @"icon_3_评分-1";
        
        [_daShiMutableArray addObject:model3];
        
        PersonalModel *model4 = [PersonalModel new];
        model4.title = @"充值";
        model4.image = @"icon_2_shouyi -1";
        
        [_daShiMutableArray addObject:model4];
        
        PersonalModel *model5 = [PersonalModel new];
        model5.title = @"大师入驻";
        model5.image = @"icon_3_dashi-1";
        
        [_daShiMutableArray addObject:model5];
        
        
        
        PersonalModel *model6 = [PersonalModel new];
        model6.title = @"城市合伙人";
        model6.image = @"icon_4_chengshi-1";
        
        [_daShiMutableArray addObject:model6];
        
        
        
        PersonalModel *model8 = [PersonalModel new];
        model8.title = @"商城";
        model8.image = @"icon_shangcheng-1";
        
        [_daShiMutableArray addObject:model8];
        
        
        PersonalModel *model7 = [PersonalModel new];
        model7.title = @"邀请分享";
        model7.image = @"icon_5_yaoqing-1";
        
        [_daShiMutableArray addObject:model7];
        
        PersonalModel *model9 = [PersonalModel new];
        model9.title = @"意见反馈";
        model9.image = @"意见反馈";
        
        [_daShiMutableArray addObject:model9];
        
        
        PersonalModel *model10 = [PersonalModel new];
        model10.title = @"关于我们";
        model10.image = @"icon_guanyuwomen";
        
        [_daShiMutableArray addObject:model10];
        
    }
    return _daShiMutableArray;
}


- (NSMutableArray *)itemMutableArray {
    if (!_itemMutableArray) {
        _itemMutableArray = @[].mutableCopy;
        
        PersonalModel *model1 = [PersonalModel new];
       
        model1.title = @"我的评价";
        model1.image = @"icon_1_pingjia-1";
        
        [_itemMutableArray addObject:model1];
        
    
        
        PersonalModel *model4 = [PersonalModel new];
        model4.title = @"充值";
        model4.image = @"icon_2_shouyi -1";
        
        [_itemMutableArray addObject:model4];
        
        PersonalModel *model5 = [PersonalModel new];
        model5.title = @"大师入驻";
        model5.image = @"icon_3_dashi-1";
      
        [_itemMutableArray addObject:model5];
        
        
        
        PersonalModel *model6 = [PersonalModel new];
        model6.title = @"城市合伙人";
        model6.image = @"icon_4_chengshi-1";
      
        [_itemMutableArray addObject:model6];
        
        PersonalModel *model8 = [PersonalModel new];
        model8.title = @"商城";
        model8.image = @"icon_shangcheng-1";
        
        [_itemMutableArray addObject:model8];
        
        PersonalModel *model7 = [PersonalModel new];
        model7.title = @"邀请分享";
        model7.image = @"icon_5_yaoqing-1";
       
        [_itemMutableArray addObject:model7];
        
        
        PersonalModel *model9 = [PersonalModel new];
        model9.title = @"意见反馈";
        model9.image = @"意见反馈";
        
        [_itemMutableArray addObject:model9];
        
        
        PersonalModel *model10 = [PersonalModel new];
        model10.title = @"关于我们";
        model10.image = @"icon_guanyuwomen";
        
        [_itemMutableArray addObject:model10];
    }
    return _itemMutableArray;
}
- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    [self configNavigationBar];
    [self.tableView reloadData];
    [CSUtility updateCurrentMoney:^(BOOL updateSuccess) {
        if (updateSuccess) {
            [self.tableView reloadData];
        }
    }];
    
}
- (void)viewDidAppear:(BOOL)animated {
   
    [super viewDidAppear:animated];
    
    [self configNavigationBar];
}
- (void)viewDidLoad {
  
    [super viewDidLoad];
   
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
//    [self sendGetRequest];
}
//- (void)sendGetRequest {
//    NSMutableDictionary *para = @{}.mutableCopy;
//    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consult Pameters:para success:^(id  _Nonnull responseObject) {
//        
//        if (CSInternetRequestSuccessful) {
//            
//        }else {
//            
//        }
//    } failure:^(NSError * _Nonnull error) {
//        
//    }];
//}
- (void)configTableView {
    

    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(NewPersonalCenterViewTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(NewPersonalCenterViewTableViewCell)];
    
     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PersonalFirstRowTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PersonalFirstRowTableViewCell)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 50;
}

- (void)configSubViews {
   
    
    
    
    
}
- (void)clickYuELabel {
    self.recordYuEOrYiDaoYunTitle =@"余额";
    self.currentMoneyType = YuEMoneyType;

    [self performSegueWithIdentifier:@"MoneyHistoryViewController" sender:self];
}
- (void)clickYiDaoYunLabel {
    self.recordYuEOrYiDaoYunTitle =@"易道元";
    
    self.currentMoneyType = YiDaoYuanMoneyType;

    
     [self performSegueWithIdentifier:@"MoneyHistoryViewController" sender:self];
}
- (void)clickHeaderViewDone {
    
//    if (CS_UserIsMaster) {
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"CS_UserIsMaster"];
//    } else {
//         [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CS_UserIsMaster"];
//    }
//    [self.tableView reloadData];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PersonalInfomationViewController *new = [main instantiateViewControllerWithIdentifier:@"PersonalInfomationViewController"];
    
    [self.navigationController pushViewController:new animated:YES];
}
- (void)clickAnswerViewDone {
    
    
    if (CS_UserIsMaster) {
        
        self.currentType = DaShiDuanHuiDaType;
    } else {
        self.currentType = UserDuanHuiDaType;
    }
    self.recordZiXunOrHuiDa = @"互动回答";
    [self  performSegueWithIdentifier:@"AllKindOfOrderViewController" sender:self];
    
}
- (void)clickMyCollectViewDone {
    [self  performSegueWithIdentifier:@"MyCollectViewController" sender:self];
}
- (void)clickConsultViewDone {
    if (CS_UserIsMaster) {
        
        self.currentType = DaShiDuanZiXunType;
    } else {
        self.currentType = UserDuanZiXuanType;
    }
    self.recordZiXunOrHuiDa = @"咨询订单";

    [self  performSegueWithIdentifier:@"AllKindOfOrderViewController" sender:self];
    
}
- (void)configNavigationBar {
    
    self.title = @"我的";
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_shezhi") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickLocationButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickLocationButtonDone {
   
    [self performSegueWithIdentifier:@"PersonalSetViewController" sender:self];
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
   
    if (CS_UserIsMaster) {
     
        return self.daShiMutableArray.count;
   
    }
    
    return self.itemMutableArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PersonalFirstRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PersonalFirstRowTableViewCell) forIndexPath:indexPath];
        
        cell.yidaoYuanLabel.text = [NSString stringWithFormat:@"%@元",CS_Coin];
        cell.yueYuanLabel.text = [NSString stringWithFormat:@"%@元",CS_Balance];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:CS_Avatar] placeholderImage:CSUserImagePlaceHolder];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",CS_User_Nickname];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickConsultViewDone)];
        
        tap.numberOfTapsRequired = 1;
        
        tap.numberOfTouchesRequired = 1;
        
        [cell.consultView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMyCollectViewDone)];
        
        tap1.numberOfTapsRequired = 1;
        
        tap1.numberOfTouchesRequired = 1;
        
        [cell.myCollectView addGestureRecognizer:tap1];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAnswerViewDone)];
        
        tap2.numberOfTapsRequired = 1;
        
        tap2.numberOfTouchesRequired = 1;
        
        [cell.answerView addGestureRecognizer:tap2];
        
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderViewDone)];
        
        tap3.numberOfTapsRequired = 1;
        
        tap3.numberOfTouchesRequired = 1;
        
        [cell.headImageView addGestureRecognizer:tap3];
        
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickYuELabel)];
        
        tap4.numberOfTapsRequired = 1;
        
        tap4.numberOfTouchesRequired = 1;
        
        [cell.yuEView addGestureRecognizer:tap4];
        
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickYiDaoYunLabel)];
        
        tap5.numberOfTapsRequired = 1;
        
        tap5.numberOfTouchesRequired = 1;
        
        [cell.yidaoyuanView addGestureRecognizer:tap5];
        
        
        
        
        
        return cell;
    }
    NewPersonalCenterViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NewPersonalCenterViewTableViewCell)];
   
    PersonalModel *model = [PersonalModel new];
    
    if (CS_UserIsMaster) {
        model = self.daShiMutableArray[indexPath.row];
    } else {
        model = self.itemMutableArray[indexPath.row];
    }
    
    cell.csImageView.image = DotaImageName(model.image);
    cell.csTitleLabel.text = model.title;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 263;
    }
    return 45;
}
- (void)sendGetRequestForDaShiInfomation {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_isapply Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self performSegueWithIdentifier:@"DaShiRuZhuViewController" sender:self];

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    PersonalModel *model = [PersonalModel new];
    
    if (CS_UserIsMaster) {
        model = self.daShiMutableArray[indexPath.row];
    } else {
        model = self.itemMutableArray[indexPath.row];
    }
    
    if ([model.title isEqualToString:@"充值"]) {
        [self performSegueWithIdentifier:@"ChongZhiViewController" sender:self];
    } else if ([model.title isEqualToString:@"大师入驻"]) {
        
        [self sendGetRequestForDaShiInfomation];
        
    } else if ([model.title isEqualToString:@"城市合伙人"]) {
        [self performSegueWithIdentifier:@"ChengShiHeHuoRenViewController" sender:self];
    }else if ([model.title isEqualToString:@"邀请分享"]) {
        [self performSegueWithIdentifier:@"ShareViewController" sender:self];
    }else if ([model.title isEqualToString:@"商城"])  {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"shoppingStoryboard"];
    } else if ([model.title isEqualToString:@"我的评价"]) {
        
        if (!CS_UserIsMaster) {
            CSUserJudgeListViewController *new = [CSUserJudgeListViewController new];
            [self.navigationController pushViewController:new animated:YES];
            return;
        }
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UserJudgeViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserJudgeViewController"];
        new.passMasterID = CS_UserID;
        new.hideTopView = YES;
        [self.navigationController pushViewController:new animated:YES];
    }else if ([model.title isEqualToString:@"关于我们"]) {
        self.recordUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_About_Us];
        self.recordTitle = @"关于我们";
        [self performSegueWithIdentifier:@"WkWebViewViewController" sender:self];

    }else if ([model.title isEqualToString:@"意见反馈"])  {
        
         [self performSegueWithIdentifier:@"UserSuggestViewController" sender:self];
    }else if ([model.title isEqualToString:@"我的评分"])  {
        DaShisPingJiaViewController *new = [DaShisPingJiaViewController new];
        
        [self.navigationController pushViewController:new animated:YES];
    }else if ([model.title isEqualToString:@"我的回答"])  {
//        DaShiMyHuiDaViewController *new = [DaShiMyHuiDaViewController new];
//        
//        [self.navigationController pushViewController:new animated:YES];
    }
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MoneyHistoryViewController"]) {
        
        MoneyHistoryViewController *new = segue.destinationViewController;
        
        new.passString = self.recordYuEOrYiDaoYunTitle;
        new.currentType = self.currentMoneyType;
    }else if ([segue.identifier isEqualToString:@"WkWebViewViewController"]) {
        WkWebViewViewController *new = segue.destinationViewController;
        new.passTitle = self.recordTitle;
        new.passUrl = self.recordUrl;
        
    }else if ([segue.identifier isEqualToString:@"AllKindOfOrderViewController"]) {
        AllKindOfOrderViewController *new = segue.destinationViewController;
        new.passTitle = self.recordZiXunOrHuiDa;
        new.currentType = self.currentType;
        
    }
    
}

@end
