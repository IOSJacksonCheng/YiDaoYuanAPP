//
//  UserJudgeListViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserJudgeListViewController.h"

#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
#import "UserJudgeListDetailViewController.h"
@interface UserJudgeListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSString *recordEID;
@end

@implementation UserJudgeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"type"] = @"1";

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Index_Bask Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getUserPingLunFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
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
- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
   
    self.page = 1;
   
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
   
    para[@"type"] = @"1";

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Index_Bask Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];

        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getUserPingLunFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
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

    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"晒单列表";
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if (indexPath.row == 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        FirstPageModel *model = self.listArray[indexPath.section];
        cell.model = model;
        return cell;
    }
    
    PlayContactSamplesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    cell.subTitleLabel.hidden = YES;
    FirstPageModel *model = self.listArray[indexPath.section];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstPageModel *model = self.listArray[indexPath.section];
    self.recordEID = model.evaluation_id;
    [self performSegueWithIdentifier:@"UserJudgeListDetailViewController" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
       
        FirstPageModel *model = self.listArray[indexPath.section];

        return [self accrodingTextGiveItHeightWith:model.content];
    }
    return 100;
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"UserJudgeListDetailViewController"]) {
        UserJudgeListDetailViewController *new = segue.destinationViewController;
        new.passId = self.recordEID;
    }
}

- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 100;
    }
    
    CGFloat labelWidth = MainScreenWidth - 77 - 16;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 10 + 56);
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:13];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
@end
