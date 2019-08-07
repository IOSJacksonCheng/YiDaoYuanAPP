//
//  AllKindOfOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AllKindOfOrderViewController.h"

#import "ConsultTableViewCell.h"
#import "DaShiDuanZiXunTableViewCell.h"

#import "SureOrderViewController.h"

#import "ConsultJinXinZhongViewController.h"
#import "ConsultYiWanChengViewController.h"

#import "JinXinZhongDetailViewController.h"
#import "SureOrderWriteMessageViewController.h"
#import "GoToJudgeViewController.h"

#import "DaShiDuanYiWanChengDetailViewController.h"
#import "DaShiDuanDaiHuiFuViewController.h"
@interface AllKindOfOrderViewController ()<UITableViewDelegate, UITableViewDataSource, ConsultTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *topButtonView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *topButtonArray;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) ConsultModel *delegateModel;

@property (nonatomic, strong) ConsultModel *currentUserModel;
/** if ([title isEqualToString:@"进行中"]) {
 return 2;
 }
 
 if ([title isEqualToString:@"待付款"]) {
 return 0;
 }
 if ([title isEqualToString:@"已完成"]) {
 return 10;
 }
 if ([title isEqualToString:@"已退款"]) {
 return -2;
 }
 
 return 100; */
@property (nonatomic, strong) NSMutableArray *allArray;
@property (nonatomic, strong) NSMutableArray *daifukuanArray;
@property (nonatomic, strong) NSMutableArray *jinxinzhongArray;
@property (nonatomic, strong) NSMutableArray *yiwanchengArray;
@property (nonatomic, strong) NSMutableArray *tuikuanArray;

@property (nonatomic, assign) int recordAllPage;
@property (nonatomic, assign) int recorddaifukuanPage;

@property (nonatomic, assign) int recordjinxinzhongPage;

@property (nonatomic, assign) int recordyiwanchengPage;

@property (nonatomic, assign) int recordtuikuanPage;

@property (nonatomic, assign) int currentOrderType;

@property (nonatomic, strong) NSString *recordURL;

@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation AllKindOfOrderViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNewData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configTableView];

    [self configNavigationBar];
    
    [self configSubViews];

    
}
- (void)configTableView {
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ConsultTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ConsultTableViewCell)];
     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDuanZiXunTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDuanZiXunTableViewCell)];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = self.passTitle;
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
- (void)configSubViews {
    
    if (self.currentType == DaShiDuanHuiDaType) {
        
        self.topButtonArray = @[@"全部订单",@"进行中",@"已完成"].mutableCopy;
        
        self.recordURL = CSURL_Portal_mcenter_qa;
        
    }else if (self.currentType == DaShiDuanZiXunType) {
        self.topButtonArray = @[@"全部订单",@"进行中",@"已完成"].mutableCopy;
      
        self.recordURL = CSURL_Portal_mcenter_consult;

    }else if (self.currentType == UserDuanHuiDaType) {
        self.topButtonArray = @[@"全部订单",@"待付款",@"进行中",@"已完成"].mutableCopy;
        
        self.recordURL = CSURL_Portal_user_qa;

    }else if (self.currentType == UserDuanZiXuanType) {
        self.topButtonArray = @[@"全部订单",@"待付款",@"进行中",@"已完成",@"已退款"].mutableCopy;
       
        self.recordURL = CSURL_Portal_user_consult;

    }
    
    self.buttonArray = @[].mutableCopy;
    [self configToViewButton];
}
- (void)configToViewButton {
    CGFloat buttonWidth = MainScreenWidth / (self.topButtonArray.count * 1.0);
    CGFloat buttonHeight = 40 - 1;
    UIButton *firstButton = nil;
    for (int i = 0; i < self.topButtonArray.count; i ++) {
        //-2已退款 -1已取消 0 未支付 1 已支付等待填写信息 2进行中 3申请退款中 10已完成
        UIButton *button = [self getButtonWithTitle:self.topButtonArray[i] WithTag:[self getButtonTitle:self.topButtonArray[i]]];
        if (i == 0) {
            firstButton = button;
        }
        [self.buttonArray addObject:button];
        [self.topButtonView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * buttonWidth);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(buttonWidth);
            make.height.mas_equalTo(buttonHeight);
        }];
    }
    self.lineView = [[UIView alloc] init];
    
    self.lineView.backgroundColor = csBlueColor;
    
    [self.topButtonView addSubview:self.lineView];
    CGFloat leftConstraint = buttonWidth * 0.5 - [self getLineViewWidth:self.topButtonArray[0]];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(leftConstraint);
        
        make.bottom.mas_equalTo(0);
        
        make.height.mas_equalTo(1);
        
    }];
    
    [self clickTopButtonDone:firstButton];
}
- (CGFloat)getLineViewWidth:(NSString *)title {
   
            
    if (title.length == 4) {
        return 60;
    }
    if (title.length == 3) {
        return 45;
    }
    return 30;
}
- (int)getButtonTitle:(NSString *)title {
   
    
    if ([title isEqualToString:@"进行中"]) {
        return 2;
    }
    
    if ([title isEqualToString:@"待付款"]) {
        return 0;
    }
    if ([title isEqualToString:@"已完成"]) {
        return 10;
    }
    if ([title isEqualToString:@"已退款"]) {
        return -2;
    }
    
    return 100;
    
}

- (UIButton *)getButtonWithTitle:(NSString *)title WithTag:(int)tag{
    
    UIButton *button = [[UIButton alloc] init];
    
    
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = csCharacterFont_15;
    button.tag = tag;
    [button addTarget:self action:@selector(clickTopButtonDone:) forControlEvents:UIControlEventTouchDown];
    return button;
}
- (void)changeButtonStatus:(UIButton *)sender {
    for (UIButton *button in self.buttonArray) {
        if (button.tag == sender.tag) {
           
            
                [button setTitleColor:csBlueColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:cs333333Color forState:UIControlStateNormal];
            }
        
    }
}
- (void)clickTopButtonDone:(UIButton *)sender {
    
    [self changeButtonStatus:sender];
    
    self.currentOrderType = (int)sender.tag;
    
    if ([self getCurrentArray].count == 0) {
        [self getNewData];
    } else {
        [self.tableView reloadData];
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGFloat left = [self getLineViewLeftConStraint];
        
        CGFloat width = [self getLineViewWidth];
        [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(left);
            make.width.mas_equalTo(width);
        }];
        
        [self.view layoutIfNeeded];
        
        
        
    } completion:^(BOOL finished) {
        
    }];
   
}
- (CGFloat)getLineViewWidth {
    NSString *title = @"";
    for (int i = 0; i < self.topButtonArray.count; i ++) {
        if (self.currentOrderType == [self getButtonTitle:self.topButtonArray[i]]) {
            title = self.topButtonArray[i];
            break;
        }
    }
    return [self getLineViewWidth:title];
}
- (CGFloat)getLineViewLeftConStraint {
    
    CGFloat buttonWidth = MainScreenWidth / (self.topButtonArray.count * 1.0);

    int index = 0;
    NSString *title = @"";
    for (int i = 0; i < self.topButtonArray.count; i ++) {
        if (self.currentOrderType == [self getButtonTitle:self.topButtonArray[i]]) {
            index = i;
            title = self.topButtonArray[i];
            break;
        }
    }
    
    CGFloat leftConstraint = buttonWidth * index + buttonWidth * 0.5 - [self getLineViewWidth:title] * 0.5;
    
    return leftConstraint;
    
}
- (void)getNewData {
    
    [self resetCurrentPages];
    
    NSMutableDictionary *para = @{}.mutableCopy;
   
    para[@"status"] = [NSString stringWithFormat:@"%d",self.currentOrderType];
    
    para[@"page"] = [NSString stringWithFormat:@"%d",[self getCurrentPages]];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:self.recordURL Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            [self handleNewDataWithArray:[CSParseManager getConsultModelArrayWithResponseObject:CSGetResult[@"lists"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getMoreData {
    
    [self addCurrentPages];
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"status"] = [NSString stringWithFormat:@"%d",self.currentOrderType];
    
    para[@"page"] = [NSString stringWithFormat:@"%d",[self getCurrentPages]];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:self.recordURL Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            [self handleMoreDataWithArray:[CSParseManager getConsultModelArrayWithResponseObject:CSGetResult[@"lists"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)handleNewDataWithArray:(NSMutableArray *)array {
    
    int type = self.currentOrderType;
    
    
    if (type == 2) {
        self.jinxinzhongArray = array;
    }else if (type == 0) {
        self.daifukuanArray = array;
    }else if (type == 10) {
        self.yiwanchengArray = array;
    }else if (type == -2) {
        self.tuikuanArray = array;
    }else {
        
        self.allArray = array;

    }
    
    
    [self.tableView reloadData];
    
}
- (void)handleMoreDataWithArray:(NSMutableArray *)array {
    
    if (array.count == 0) {
        CustomWrongMessage(@"下面没有更多数据了");
        return;
    }
    
    int type = self.currentOrderType;
    
    
    if (type == 2) {
        [self.jinxinzhongArray addObjectsFromArray:array];
    }else if (type == 0) {
        [self.daifukuanArray addObjectsFromArray:array];
    }else if (type == 10) {
        [self.yiwanchengArray addObjectsFromArray:array];

    }else if (type == -2) {
        [self.tuikuanArray addObjectsFromArray:array];

    }else {
        [self.allArray addObjectsFromArray:array];

        
    }
    
    
    [self.tableView reloadData];
    
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)addCurrentPages {
    
    int type = self.currentOrderType;
    if (type == 2) {
        self.recordjinxinzhongPage += 1;
    } else if (type == 0) {
        self.recorddaifukuanPage += 1;
    } else if (type == 10) {
        self.recordyiwanchengPage += 1;
    } else if (type == -2) {
        self.recordtuikuanPage += 1;
    } else {
        self.recordAllPage += 1;

    }
    
    
}
- (void)resetCurrentPages {
    int type = self.currentOrderType;

    if (type == 2) {
         self.recordjinxinzhongPage = 1;
    }else if (type == 0) {
         self.recorddaifukuanPage = 1;
    }else if (type == 10) {
        self.recordyiwanchengPage = 1;
    }else if (type == -2) {
        self.recordtuikuanPage = 1;
    }else {
        self.recordAllPage = 1;

    }
    
    
}
- (int)getCurrentPages {
    int type = self.currentOrderType;

    if (type == 2) {
        return self.recordjinxinzhongPage;
    }
    if (type == 0) {
        return self.recorddaifukuanPage;
    }
    if (type == 10) {
        return self.recordyiwanchengPage;
    }
    if (type == -2) {
        return self.recordtuikuanPage;
    }
    
    
    return self.recordAllPage;
}
////-2已退款 -1已取消 0 未支付 1 已支付等待填写信息 2进行中 3申请退款中 10已完成
- (NSMutableArray *)getCurrentArray {
   
    int type = self.currentOrderType;

    if (type == 2) {
        return self.jinxinzhongArray;
    }
    if (type == 0) {
        return self.daifukuanArray;
    }
    if (type == 10) {
        return self.yiwanchengArray;
    }
    if (type == -2) {
        return self.tuikuanArray;
    }
    
    
    return self.allArray;
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self getCurrentArray].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.currentType == DaShiDuanHuiDaType || self.currentType == DaShiDuanZiXunType) {
       
        DaShiDuanZiXunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDuanZiXunTableViewCell)];
        
        ConsultModel *model = [self getCurrentModel:indexPath.row];
        if (self.currentType == DaShiDuanZiXunType) {
            cell.zixun = YES;
        }else {
            cell.zixun = NO;
        }
        cell.model = model;
        return cell;
    }
    ConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ConsultTableViewCell)];
    if (self.currentType == UserDuanZiXuanType) {
        cell.zixun = YES;
    }else {
        cell.zixun = NO;
    }
    ConsultModel *model = [self getCurrentModel:indexPath.row];
    cell.model = model;
    cell.simpleDelegate = self;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsultModel *model = [self getCurrentModel:indexPath.row];

    if (self.currentType == DaShiDuanZiXunType) {
        
        if (model.status.intValue == 2) {
            return 209;
        }
        return 181;
    } else if (self.currentType == DaShiDuanHuiDaType) {
        
        
        
        if (model.status.intValue == 2) {
            return 209 + [self accrodingTextGiveItHeightWith:model.content] + 8;
        }
        return 181 + [self accrodingTextGiveItHeightWith:model.content] + 8;
        
    }
    
    if (self.currentType == UserDuanHuiDaType) {
        
        
        
        if (model.status.intValue == 0 || model.status.intValue == 10) {
            return 209 + [self accrodingTextGiveItHeightWith:model.content] + 8;
        }
        return 181 + [self accrodingTextGiveItHeightWith:model.content] + 8;
        
    }
    if (model.status.intValue == 2 || model.status.intValue == 0 || model.status.intValue == 10 ) {
        return 209;
    }
    
    return 181;
    
}
- (ConsultModel *)getCurrentModel:(NSInteger)row {
    NSMutableArray *array = [self getCurrentArray];
    
    return array[row];
    
}
/** if ([title isEqualToString:@"进行中"]) {
 return 2;
 }
 
 if ([title isEqualToString:@"待付款"]) {
 return 0;
 }
 if ([title isEqualToString:@"已完成"]) {
 return 10;
 }
 if ([title isEqualToString:@"已退款"]) {
 return -2;
 }
 
 return 100; */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ConsultModel *model = [self getCurrentModel:indexPath.row];
    self.currentUserModel = model;
    if (self.currentType == DaShiDuanHuiDaType) {
        if (model.status.intValue == 10) {
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            JinXinZhongDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"JinXinZhongDetailViewController"];
            new.order_id = model.order_id;
            new.hideTextField = YES;
            [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES
             ];

        }
    }else if (self.currentType == DaShiDuanZiXunType) {
        
        if (model.status.intValue == 10) {
             UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];            DaShiDuanYiWanChengDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:CSCellName(DaShiDuanYiWanChengDetailViewController)];
            
            new.consult = model;
            
            [self.navigationController pushViewController:new animated:YES];
        } else if (model.status.intValue == 2) {
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];            DaShiDuanDaiHuiFuViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:CSCellName(DaShiDuanDaiHuiFuViewController)];
            
//            new.consult = model;
            new.orderId = model.order_id;
            
            [self.navigationController pushViewController:new animated:YES];
            
            
        }
       

       
    } else if (self.currentType == UserDuanZiXuanType
        ) {
        if (model.status.integerValue == 2) {
            
            [self performSegueWithIdentifier:@"ConsultJinXinZhongViewController" sender:self];
        } else if (model.status.integerValue == -2) {
            
            [self performSegueWithIdentifier:@"ConsultTuiKuanViewController" sender:self];
        }else if (model.status.integerValue == 10) {
            
            [self performSegueWithIdentifier:@"ConsultYiWanChengViewController" sender:self];
        } else if (model.status.integerValue == 1) {

            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            SureOrderWriteMessageViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:CSCellName(SureOrderWriteMessageViewController)];
           
            DaShiOrderInfoModel *newmodel = [DaShiOrderInfoModel new];
            newmodel.order_id = model.order_id;
            newmodel.master_name = model.name;
            newmodel.avatar = model.avatar;
            new.infoModel = newmodel;
            
            [self.navigationController pushViewController:new animated:YES];
        }
    } else if (self.currentType == UserDuanHuiDaType) {
        
        if (model.status.integerValue == 10) {
            GoToJudgeViewController *new = [GoToJudgeViewController new];
            
            new.order_id = model.order_id;
            
            new.typestring = @"3";
            
            
            
            [self.navigationController pushViewController:new animated:YES];
        } else if (model.status.integerValue == 2) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            
            JinXinZhongDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"JinXinZhongDetailViewController"];
            ConsultModel *model = [self getCurrentModel:indexPath.row];
            
            new.order_id = model.order_id;
            
            
            [self.navigationController pushViewController:new animated:YES
             ];
        }
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SureOrderViewController"]) {
        SureOrderViewController *new = segue.destinationViewController;
        new.order_id = self.delegateModel.order_id;
    }else if ([segue.identifier isEqualToString:@"ConsultJinXinZhongViewController"]) {
        ConsultJinXinZhongViewController *new = segue.destinationViewController;
        new.order_id = self.currentUserModel.order_id;
    }else if ([segue.identifier isEqualToString:@"ConsultYiWanChengViewController"]) {
        ConsultYiWanChengViewController *new = segue.destinationViewController;
        new.order_id = self.currentUserModel.order_id;
    }
}
- (void)passModel:(ConsultModel *)model {
    self.delegateModel = model;
}
- (void)refreshCurrentView {
    [self getNewData];
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 20 - 17;
    
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
@end
