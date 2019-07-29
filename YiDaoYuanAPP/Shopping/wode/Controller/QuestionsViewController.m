//
//  QuestionsViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/16.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QuestionsViewController.h"

#import "QuestionTitleTableViewCell.h"
#import "QuestionDetailTableViewCell.h"

#import "QuestionModel.h"

@interface QuestionsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;
@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.page += 1;
   
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_Goods_issue Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getQuestionModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！");
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
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_Goods_issue Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getQuestionModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(QuestionDetailTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(QuestionDetailTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(QuestionTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(QuestionTitleTableViewCell)];

}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"常见问题";
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.listArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     QuestionModel *model = self.listArray[section];
    if (model.choose) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuestionModel *model = self.listArray[indexPath.section];
    if (indexPath.row == 0) {
        QuestionTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(QuestionTitleTableViewCell) forIndexPath:indexPath];
        cell.titleLabel.text = model.title;
        if (model.choose) {
            cell.chooseImageView.image = DotaImageName(@"icon_xiala-3");
        } else {
            cell.chooseImageView.image = DotaImageName(@"icon_shouqi");

        }
        return cell;
    }
    QuestionDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(QuestionDetailTableViewCell) forIndexPath:indexPath];
    cell.detailLabel.text = model.content;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
         QuestionModel *model = self.listArray[indexPath.section];
        model.choose = !model.choose;
        
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 64;
    }
    QuestionModel *model = self.listArray[indexPath.section];
    return [self accrodingTextGiveItHeightWith:model.content];
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    
    
    CGFloat labelWidth = MainScreenWidth - 18 - 13;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 14 + 10);
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:13];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
@end
