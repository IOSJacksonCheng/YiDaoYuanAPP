//
//  UserJudgeListDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserJudgeListDetailViewController.h"

#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
#import "UserJudgeDetailImageTableViewCell.h"
@interface UserJudgeListDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) FirstPageModel *model;
@end

@implementation UserJudgeListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.model = [FirstPageModel new];
    [self getNewData];
}
- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"evaluation_id"] = self.passId;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_Index_Evaluationinfo Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.model = [CSParseManager getPunLunSingleModelArrayWithResponseObject:CSGetResult];
            
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(UserJudgeDetailImageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(UserJudgeDetailImageTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"晒单列表";
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        cell.model = self.model;
        return cell;
    }
    if (indexPath.row == 1) {
        UserJudgeDetailImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(UserJudgeDetailImageTableViewCell)];
        if (self.model.imgs.count >= 1) {
             [cell.firstImage sd_setImageWithURL:[NSURL URLWithString:self.model.imgs[0]] placeholderImage:PlaceHolderImage];
        }else {
            cell.firstImage.image = PlaceHolderImage;
        }
        if (self.model.imgs.count >= 2) {
            [cell.secondImage sd_setImageWithURL:[NSURL URLWithString:self.model.imgs[1]] placeholderImage:PlaceHolderImage];
        }else {
            cell.secondImage.image = PlaceHolderImage;
        }
       

        return cell;
    }
    PlayContactSamplesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    cell.subTitleLabel.hidden = YES;
    cell.model = self.model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        
        return [self accrodingTextGiveItHeightWith:self.model.content];
    }
    if (indexPath.row == 1) {
        return 116;
    }
    return 100;
    
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
