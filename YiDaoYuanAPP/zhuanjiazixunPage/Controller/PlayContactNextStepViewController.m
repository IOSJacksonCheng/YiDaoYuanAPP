//
//  PlayContactNextStepViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactNextStepViewController.h"
#import "PlayContactStepThreeViewController.h"

#import "ZJZXMoreTableViewCell.h"
#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
@interface PlayContactNextStepViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickNextButtonDone:(id)sender;
@property (nonatomic, strong) NSMutableArray *jingxuanArray;

@property (nonatomic, assign) int page;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@end

@implementation PlayContactNextStepViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.jingxuanArray = @[].mutableCopy;

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
    para[@"cat_id"] = self.passCatId;
    self.page ++;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_qa_case Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            
            
            NSMutableArray *array = [CSParseManager getUserPingLunFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了");
            } else {
               
                [self.jingxuanArray addObjectsFromArray:array];
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
    para[@"cat_id"] = self.passCatId;
    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_qa_case Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.jingxuanArray = [CSParseManager getUserPingLunFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            self.totalLabel.text = [NSString stringWithFormat:@"%@个提问",CSGetResult[@"total"]];
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = self.passTitle;
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1 + self.jingxuanArray.count;
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"精选案例";
        cell.moreTitleLabel.hidden = YES;
        return cell;
    }
    
    FirstPageModel *model = self.jingxuanArray[indexPath.section - 1];
    if (indexPath.row == 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        cell.model = model;
        return cell;
    }
    PlayContactSamplesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    cell.model = model;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 54;
    }
    FirstPageModel *model = self.jingxuanArray[indexPath.section - 1];
    if (indexPath.row  == 0) {
        
        
        return [self accrodingTextGiveItHeightWith:model.content];
    }
    
    return 95 + [self accrodingReplyTextGiveItHeightWith:model.reply];
}
- (CGFloat)accrodingReplyTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 66 - 10;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height));
    
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
- (IBAction)clickNextButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"PlayContactStepThreeViewController" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayContactStepThreeViewController"]) {
        PlayContactStepThreeViewController *new = segue.destinationViewController;
        new.passCatId = self.passCatId;
        
        
    }
}
@end
