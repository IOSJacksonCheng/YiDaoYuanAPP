//
//  PlayContactViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactViewController.h"

#import "PlayContactTableViewCell.h"
#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"

#import "FirstPageManyItemModel.h"

#import "PlayContactNextStepViewController.h"

#import "PlayContactStepThreeViewController.h"
@interface PlayContactViewController ()<UITableViewDelegate, UITableViewDataSource, PlayContactTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *questionArray;
@property (nonatomic, strong) NSMutableArray *jingxuanArray;
@property (nonatomic, strong) NSString *recordCid;
@property (nonatomic, strong) NSString *recordTitle;
@end

@implementation PlayContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.questionArray = @[].mutableCopy;
    
    self.jingxuanArray = @[].mutableCopy;
    [self sendGetRequest];
    
    [self getJingXuanAnli];
}
- (void)getJingXuanAnli {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_qa_case Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.jingxuanArray = [CSParseManager getUserPingLunFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_qa_category Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.questionArray = [CSParseManager getFirstPageManyItemModelArrayWithResponseObject:CSGetResult[@"lists"]];
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
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];

    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"互动问答";
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1 + self.jingxuanArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.questionArray.count;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
       
        PlayContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactTableViewCell)];
        FirstPageManyItemModel *model = self.questionArray[indexPath.row];
        cell.csTitleLabel.text = model.title;
        cell.csSubTitleLabel.text = model.intro;
        cell.model = model;
        cell.csDelegate = self;
        [cell.csImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];        return cell;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FirstPageManyItemModel *model = self.questionArray[indexPath.row];
        self.recordCid = model.cat_id;
        self.recordTitle = model.title;
 [self performSegueWithIdentifier:@"PlayContactNextStepViewController" sender:self];
    }
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section != 1) {
        return UIView.new;
    }
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.whiteColor;
    UILabel *label = UILabel.new;
    label.text = @"精选案例";
    label.font = csCharacterFont_18;
    label.textColor = cs333333Color;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.centerY.mas_equalTo(0);
    }];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 0;
}
- (void)passContactModelId:(FirstPageManyItemModel *)model {
    self.recordCid = model.cat_id;
    self.recordTitle = model.title;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayContactNextStepViewController"]) {
        PlayContactNextStepViewController *new = segue.destinationViewController;
        new.passCatId = self.recordCid;
        new.passTitle = self.recordTitle;
    } else if ([segue.identifier isEqualToString:@"PlayContactStepThreeViewController"]) {
        PlayContactStepThreeViewController *new = segue.destinationViewController;
        
        new.passCatId = self.recordCid;
    }
}
@end
