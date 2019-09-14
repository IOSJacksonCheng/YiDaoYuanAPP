//
//  DaShiDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDetailViewController.h"

#import "DaShiDetailMoreServicesTableViewCell.h"
#import "DaShiDetailChooseServiceTableViewCell.h"
#import "DaShiDetailCenterTableViewCell.h"
#import "DaShiDetailJudgeTableViewCell.h"
#import "DaShiDetailTitlleTableViewCell.h"
#import "ZJZXMoreTableViewCell.h"
#import "FirstPageManyItemModel.h"
#import "UserJudgeViewController.h"
#import "AdmireMoneyViewController.h"
#import "SureOrderViewController.h"
#import "CSShareView.h"
@interface DaShiDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSString *recordOrderId;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIImageView *guanzhuImageView;

@property (weak, nonatomic) IBOutlet UIView *admireView;

@property (weak, nonatomic) IBOutlet UIView *collectView;
- (IBAction)clickRightBuyButtonDone:(id)sender;
@property (nonatomic, strong) ManyDaShiModel *currentModel;
@property (nonatomic, strong) NSMutableArray *seviceArray;

@property (nonatomic, assign) BOOL chooseMore;

@property (nonatomic, strong) NSMutableArray *judgeArray;

@property (nonatomic, assign) BOOL hasCollect;

@property (nonatomic, strong) CSShareView *shareView;
@end

@implementation DaShiDetailViewController
- (CSShareView *)shareView {
    if (!_shareView) {
        _shareView = [[CSShareView alloc] initWithFrame:self.view.bounds WithDelegate:self WithTitle:self.currentModel.name WithDescription:@"算命App" WithImage:DotaImageName(@"AppIcon") WithUrl:@"www.baidu.com"];
    }
    return _shareView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
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
    
    self.seviceArray = @[].mutableCopy;
    self.judgeArray = @[].mutableCopy;
    
    [self checkCollectStatus];
    
    [self getDaShiInfomation];
    
    [self getServiceRequest];
    
    [self getJudgeList];
}
- (void)getJudgeList {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"master_id"] = self.passMasterID;
    
    para[@"type"] = @"1";

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_evaluate Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.judgeArray = [CSParseManager getUserJudgeArrayArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.mainTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getServiceRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"user_id"] = self.passMasterID;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_consult_price Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.seviceArray = [CSParseManager getFirstPageManyItemModelArrayWithResponseObject:CSGetResult[@"lists"]];
            for (FirstPageManyItemModel *model in self.seviceArray) {
                if ([model.item_id isEqualToString:self.passitem_id]) {
                    model.choose = YES;
                    break;
                }
            }
            [self.mainTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (void)getDaShiInfomation {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"master_id"] = self.passMasterID;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_Master_Info Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.currentModel = [CSParseManager getSingleManyDaShiModellWithResponseObject:CSGetResult];
            [self.mainTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailMoreServicesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailMoreServicesTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailChooseServiceTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailChooseServiceTableViewCell)];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailCenterTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailCenterTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailTitlleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailTitlleTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];

}
- (void)configSubViews {
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCollectViewDone)];
    
    newsTap.numberOfTapsRequired = 1;
    
    newsTap.numberOfTouchesRequired = 1;
    
    [self.collectView addGestureRecognizer:newsTap];
    
    UITapGestureRecognizer *newsTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdmireViewDone)];
    
    newsTap1.numberOfTapsRequired = 1;
    
    newsTap1.numberOfTouchesRequired = 1;
    
    [self.admireView addGestureRecognizer:newsTap1];
}
- (void)clickAdmireViewDone {
    
    [self performSegueWithIdentifier:@"AdmireMoneyViewController" sender:self];
}


- (void)configNavigationBar {
    self.title = @"大师详情";
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_share") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickShareButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;

}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)clickShareButtonDone {
    
    [self.view addSubview:self.shareView];

    
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UserJudgeViewController"]) {
        UserJudgeViewController *new = segue.destinationViewController;
        new.passMasterID = self.passMasterID;
    } else if ([segue.identifier isEqualToString:@"AdmireMoneyViewController"]) {
        AdmireMoneyViewController *new = segue.destinationViewController;
        new.master_id = self.passMasterID;
        new.masterIcon = self.currentModel.avatar;
        new.masterName = self.currentModel.user_name;
    }else if ([segue.identifier isEqualToString:@"SureOrderViewController"]) {
        SureOrderViewController *new = segue.destinationViewController;
        new.order_id = self.recordOrderId;
        new.masterName = self.currentModel.name;
        new.masterId = self.currentModel.master_id;
    }
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1) {
        if (self.seviceArray.count == 0) {
            return 0;
        }
        if (self.chooseMore) {
            return self.seviceArray.count;
        }
        if (self.seviceArray.count >= 3) {
            return 3;
        }
        return self.seviceArray.count;
    }else if (section == 2) {
        return 2;
    }
    return self.judgeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            DaShiDetailTitlleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailTitlleTableViewCell)];
            cell.model = self.currentModel;
            return cell;
        } else if (row == 2) {
            
            DaShiDetailCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailCenterTableViewCell)];
            cell.introLabel.text = self.currentModel.detailed;
            [cell.introImageView sd_setImageWithURL:[NSURL URLWithString:self.currentModel.ad_avatar] placeholderImage:PlaceHolderImage];
            return cell;
        }else if (row == 1) {
            
            ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
            cell.csTitleLabel.text = @"个人介绍";
            cell.moreTitleLabel.hidden = YES;
            return cell;
        }
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"项目服务";
        cell.moreTitleLabel.hidden = YES;
        return cell;
    }else if (section == 1) {
        
        DaShiDetailChooseServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailChooseServiceTableViewCell)];

        FirstPageManyItemModel *model = self.seviceArray[indexPath.row];
        [cell.csImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];
            cell.csTitleLabel.text = model.title;
        
        cell.csMoneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
        if (model.choose) {
            cell.chooseStatusImageView.image = DotaImageName(@"icon_xuanzhong");
        }else {
            cell.chooseStatusImageView.image = DotaImageName(@"icon_weixuanzhong");

        }
         return cell;
    }else if (section == 2) {
        
        if (row == 0) {
            DaShiDetailMoreServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailMoreServicesTableViewCell)];
            return cell;
        }
            
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"用户评价";
        cell.moreTitleLabel.hidden = NO;
        cell.moreTitleLabel.text = @"查看更多";
        return cell;
        
        
    }
      DaShiDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    UserJudgeArray *model = self.judgeArray[indexPath.row];
    cell.model = model;
    return cell;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 1) {
        
        
         [self  performSegueWithIdentifier:@"UserJudgeViewController" sender:self];
    } else if (indexPath.section == 1) {
        
        for (FirstPageManyItemModel *model in self.seviceArray) {
            model.choose = NO;
        }
        
        FirstPageManyItemModel *model = self.seviceArray[indexPath.row];
        model.choose = YES;
        self.passitem_id = model.item_id;
        [self.mainTableView reloadData];
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        if (self.seviceArray.count <= 3) {
            CustomWrongMessage(@"暂无更多服务");
            return;
        }
        self.chooseMore = !self.chooseMore;
        [self.mainTableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
           
            return 290 - 25 + [CSUtility accrodingTextGiveItHeightWith:self.currentModel.speciality WithLabelInterval:9 + 11 + 11 + 34 WithFont:11];
        } else if (row == 2) {
            
            return 128 + 18.5 + [self accrodingTextGiveItHeightWith:self.currentModel.detailed];
            return 180;
        }
        return 54;
    }else if (section == 1) {
        
        return 54;
    }else if (section == 2) {
        
        if (row == 0) {
            return 44;
        }
        
       return 54;
        
        
    }
     UserJudgeArray *model = self.judgeArray[indexPath.row];
  return 83 + 49.5 + [self accrodingJudgeTextGiveItHeightWith:model.content];
}

- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 19 - 21;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height));
    
}
- (CGFloat)accrodingJudgeTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 87 - 19;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height));
    
}

- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:12];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
- (IBAction)clickRightBuyButtonDone:(id)sender {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"master_id"] = self.passMasterID;
    para[@"item_id"] = self.passitem_id;
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_consult_order Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
           self.recordOrderId = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            [self performSegueWithIdentifier:@"SureOrderViewController" sender:self];

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
#pragma mark -- 收藏part
- (void)checkCollectStatus {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"object_id"] = self.passMasterID;
    para[@"table_name"] = @"master";
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_favorites_hasFavorite Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.hasCollect = YES;

            self.guanzhuImageView.image = DotaImageName(@"icon_collect");
        }else {
            self.hasCollect = NO;
            self.guanzhuImageView.image = DotaImageName(@"icon_guanzhu-2");
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)clickCancelCollect {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"object_id"] = self.passMasterID;
    para[@"table_name"] = @"master";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_user_favorites_unset Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {

            self.hasCollect = NO;
            self.guanzhuImageView.image = DotaImageName(@"icon_guanzhu-2");
            CustomWrongMessage(@"取消关注成功！");

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)clickCollectViewDone {
    if (self.hasCollect) {
        [self clickCancelCollect];
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"object_id"] = self.passMasterID;
    para[@"table_name"] = @"master";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_user_favorites_add Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.hasCollect = YES;
            CustomWrongMessage(@"关注成功！");

            self.guanzhuImageView.image = DotaImageName(@"icon_collect");
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
@end
