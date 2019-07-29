//
//  LunTanMoreDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanMoreDetailViewController.h"

#import "LunTanTitleTableViewCell.h"
#import "LunTanMoreDetailCountTableViewCell.h"
#import "LunTanUserJudgeTableViewCell.h"
@interface LunTanMoreDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *csInputTextField;
@property (weak, nonatomic) IBOutlet UIView *remindView;
- (IBAction)clickSendButtonDone:(id)sender;

- (IBAction)clickCancelButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSString *totalPingLun;

@end

@implementation LunTanMoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)GetMoreData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"forum_id"] = self.passModel.forum_id;

    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_forum_comment_list Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getpingjiaListModelWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
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
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    para[@"forum_id"] = self.passModel.forum_id;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_forum_comment_list Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getpingjiaListModelWithResponseObject:CSGetResult[@"lists"]];
            self.totalPingLun = [NSString stringWithFormat:@"%@",CSGetResult[@"total"]];
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanTitleTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanMoreDetailCountTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanMoreDetailCountTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanUserJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanUserJudgeTableViewCell)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
}
- (void)configSubViews {
    self.remindView.hidden = YES;
//    self.bgView.layer.cornerRadius = 5;
//    self.bgView.layer.masksToBounds = YES;
    
    self.csInputTextField.layer.cornerRadius = 15;
    self.csInputTextField.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"论坛详情";
    
    WhiteNavigationBarColor
    
    
    
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.listArray.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
        cell.model = self.passModel;
        return cell;
    }
    if (indexPath.section == 1) {
        LunTanMoreDetailCountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanMoreDetailCountTableViewCell)];
        cell.totalLabel.text = [NSString stringWithFormat:@"(%@)",self.totalPingLun];
        return cell;
    }
    LunTanUserJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanUserJudgeTableViewCell)];
    pingjiaListModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 240;
    }
    
    if (indexPath.section == 1) {
        return 50;
    }
    pingjiaListModel *model = self.listArray[indexPath.row];

    
    return [self accrodingTextGiveItHeightWith:model.comment_content]+ 95;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    view.backgroundColor = csf5f5f5Color;
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}

- (IBAction)clickSendButtonDone:(id)sender {
    [self.view endEditing:YES];
    if (csCharacterIsBlank(self.csInputTextField.text)) {
        CustomWrongMessage(@"请输入要评论的内容");
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"forum_id"] = self.passModel.forum_id;

    para[@"comment_content"] = self.csInputTextField.text;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_forum_topic_comment Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.remindView.hidden = NO;
            [self getNewData];
            CSShowWrongMessage
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}

- (IBAction)clickCancelButtonDone:(id)sender {
    self.remindView.hidden = YES;
}

- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 20 - 9 - 17;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height));
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:15];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
@end
