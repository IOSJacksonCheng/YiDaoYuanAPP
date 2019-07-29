//
//  UserJudgeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "UserJudgeViewController.h"

#import "DaShiDetailJudgeTableViewCell.h"//132.5
#import "UserDefaultJudgeTableViewCell.h"
@interface UserJudgeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *judgeTableView;
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
- (IBAction)clickJudgeTypeButtonDone:(UIButton *)sender;
//0 传1   1传 2  2传 4
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) int page;


@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;
@property (weak, nonatomic) IBOutlet UILabel *pingfenLabel;

@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView2;
@property (weak, nonatomic) IBOutlet UILabel *pingfenLabel2;

@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView3;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView3;
@property (weak, nonatomic) IBOutlet UILabel *pingfenLabel3;

@property (nonatomic, strong) NSString *firstFen;
@property (nonatomic, strong) NSString *secondFen;

@property (nonatomic, strong) NSString *thirdFen;

@end

@implementation UserJudgeViewController

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
    if (self.judgeTableView.mj_header.isRefreshing) {
        [self.judgeTableView.mj_header endRefreshing];
    }
    if (self.judgeTableView.mj_footer.isRefreshing) {
        [self.judgeTableView.mj_footer endRefreshing];
    }
}
- (NSString *)getCurrentType {
    if (self.currentIndex == 0) {
        return @"1";
    }
    if (self.currentIndex == 1) {
        return @"2";
    }
    return @"4";
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"master_id"] = self.passMasterID;
    para[@"type"] = [self getCurrentType];;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_evaluate Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getUserJudgeArrayArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.judgeTableView reloadData];
                
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)getAvergeFenRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"master_id"] = self.passMasterID;
    
    para[@"type"] = [self getCurrentType];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_avgevaluate Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.firstFen = [NSString stringWithFormat:@"%@",CSGetResult[@"quality"]];
            self.secondFen = [NSString stringWithFormat:@"%@",CSGetResult[@"serve"]];

            self.thirdFen = [NSString stringWithFormat:@"%@",CSGetResult[@"reply"]];
            [self refreshFenView];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getNewData {
    [self getAvergeFenRequest];
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"master_id"] = self.passMasterID;
    
    para[@"type"] = [self getCurrentType];
    self.page = 1;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_evaluate Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];

        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getUserJudgeArrayArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.judgeTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
}
- (void)configTableView {
    
    
    self.judgeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.judgeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.judgeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    [self.judgeTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    [self.judgeTableView registerNib:[UINib nibWithNibName:CSCellName(UserDefaultJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(UserDefaultJudgeTableViewCell)];
}
- (void)configSubViews {
    self.currentIndex = 0;
    [self clickButtonWithTag:self.currentIndex];
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    self.title = @"用户评价";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (IBAction)clickJudgeTypeButtonDone:(UIButton *)sender {
    [self clickButtonWithTag:sender.tag];
    self.currentIndex = sender.tag;
    
    [self getNewData];
    
}
- (void)clickButtonWithTag:(NSInteger)tag {
    if (tag == 0) {
        [self.firstButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.firstButton.titleLabel.font = csCharacterFont_16;
    } else {
        [self.firstButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.firstButton.titleLabel.font = csCharacterFont_15;
    }
    
    if (tag == 1) {
        [self.secondButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.secondButton.titleLabel.font = csCharacterFont_16;
    } else {
        [self.secondButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.secondButton.titleLabel.font = csCharacterFont_15;
    }
    
    if (tag == 2) {
        [self.thirdButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.thirdButton.titleLabel.font = csCharacterFont_16;
    } else {
        [self.thirdButton setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.thirdButton.titleLabel.font = csCharacterFont_15;
    }
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserJudgeArray *model = self.listArray[indexPath.row];
    if (self.currentIndex == 2) {
        UserDefaultJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(UserDefaultJudgeTableViewCell)];
        cell.model = model;
        return cell;
    }
    DaShiDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 0 || self.currentIndex == 1) {
        UserJudgeArray *model = self.listArray[indexPath.row];
        return 83 + 49.5 + [self accrodingJudgeTextGiveItHeightWith:model.content];
        
    }
    
    UserJudgeArray *model = self.listArray[indexPath.row];
    return 30 + 65 + [self accrodingDefaultJudgeTextGiveItHeightWith:model.content];
    
}

- (CGFloat)accrodingDefaultJudgeTextGiveItHeightWith:(NSString *)text {
    
    if (csCharacterIsBlank(text)) {
        return 0;
    }
    
    CGFloat labelWidth = MainScreenWidth - 8 - 69;
    
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

- (void)refreshFenView {
    
    self.pingfenLabel.text = self.firstFen;
    
    if (self.firstFen.intValue == 0) {
        self.oneXingImageView.image = DotaImageName(@"icon_weishou");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
    } else if (self.firstFen.intValue == 1) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.firstFen.intValue == 2) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.firstFen.intValue == 3) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.firstFen.intValue == 4) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.firstFen.intValue == 5) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect");
        
        
    }
    
    
    self.pingfenLabel2.text = self.secondFen;
    
    if (self.secondFen.intValue == 0) {
        self.oneXingImageView2.image = DotaImageName(@"icon_weishou");
        self.twoXingImageView2.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView2.image = DotaImageName(@"icon_weishou");
        
    } else if (self.secondFen.intValue == 1) {
        self.oneXingImageView2.image = DotaImageName(@"icon_collect");
        self.twoXingImageView2.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.secondFen.intValue == 2) {
        self.oneXingImageView2.image = DotaImageName(@"icon_collect");
        self.twoXingImageView2.image = DotaImageName(@"icon_collect");
        self.threeXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.secondFen.intValue == 3) {
        self.oneXingImageView2.image = DotaImageName(@"icon_collect");
        self.twoXingImageView2.image = DotaImageName(@"icon_collect");
        self.threeXingImageView2.image = DotaImageName(@"icon_collect");
        self.fourXingImageView2.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.secondFen.intValue == 4) {
        self.oneXingImageView2.image = DotaImageName(@"icon_collect");
        self.twoXingImageView2.image = DotaImageName(@"icon_collect");
        self.threeXingImageView2.image = DotaImageName(@"icon_collect");
        self.fourXingImageView2.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView2.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.secondFen.intValue == 5) {
        self.oneXingImageView2.image = DotaImageName(@"icon_collect");
        self.twoXingImageView2.image = DotaImageName(@"icon_collect");
        self.threeXingImageView2.image = DotaImageName(@"icon_collect");
        self.fourXingImageView2.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView2.image = DotaImageName(@"icon_collect");
        
        
    }
    
    self.pingfenLabel3.text = self.thirdFen;
    
    if (self.thirdFen.intValue == 0) {
        self.oneXingImageView3.image = DotaImageName(@"icon_weishou");
        self.twoXingImageView3.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView3.image = DotaImageName(@"icon_weishou");
        
    } else if (self.thirdFen.intValue == 1) {
        self.oneXingImageView3.image = DotaImageName(@"icon_collect");
        self.twoXingImageView3.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.thirdFen.intValue == 2) {
        self.oneXingImageView3.image = DotaImageName(@"icon_collect");
        self.twoXingImageView3.image = DotaImageName(@"icon_collect");
        self.threeXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.thirdFen.intValue == 3) {
        self.oneXingImageView3.image = DotaImageName(@"icon_collect");
        self.twoXingImageView3.image = DotaImageName(@"icon_collect");
        self.threeXingImageView3.image = DotaImageName(@"icon_collect");
        self.fourXingImageView3.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.thirdFen.intValue == 4) {
        self.oneXingImageView3.image = DotaImageName(@"icon_collect");
        self.twoXingImageView3.image = DotaImageName(@"icon_collect");
        self.threeXingImageView3.image = DotaImageName(@"icon_collect");
        self.fourXingImageView3.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView3.image = DotaImageName(@"icon_weishou");
        
        
    }else if (self.thirdFen.intValue == 5) {
        self.oneXingImageView3.image = DotaImageName(@"icon_collect");
        self.twoXingImageView3.image = DotaImageName(@"icon_collect");
        self.threeXingImageView3.image = DotaImageName(@"icon_collect");
        self.fourXingImageView3.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView3.image = DotaImageName(@"icon_collect");
        
        
    }
    
}
@end
