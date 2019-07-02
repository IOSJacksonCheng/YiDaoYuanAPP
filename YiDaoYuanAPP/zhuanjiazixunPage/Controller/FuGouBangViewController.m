//
//  FuGouBangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FuGouBangViewController.h"
#import "FuGouBangTableViewCell.h"
#import "DaShiDetailViewController.h"
typedef NS_ENUM(NSInteger, ListType) {
    HaoPingBangType = 0,
    FuGouBangType,
    QianLiBangType
};
@interface FuGouBangViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
- (IBAction)clickTopViewButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewLeftConstraint;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (nonatomic, assign) ListType currentType;
@property (nonatomic, strong) NSString *recordRankType;

@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;
@end

@implementation FuGouBangViewController
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
    self.currentType = HaoPingBangType;
    [self changeButtonStatusWithTag:self.currentType];
}

- (void)configTableView {
    
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(FuGouBangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(FuGouBangTableViewCell)];
    
}
- (void)configSubViews {
    self.firstArray = @[].mutableCopy;
    self.secondArray = @[].mutableCopy;
    self.thirdArray = @[].mutableCopy;
}
- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"婚恋情感";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
- (IBAction)clickTopViewButtonDone:(UIButton *)sender {
    [self changeButtonStatusWithTag:sender.tag];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"rankType"] = self.recordRankType;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_Master_Rank Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self handleData:CSGetResult[@"lists"]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)handleData:(id)responseObject {
    if (self.currentType == HaoPingBangType) {
        self.firstArray = [CSParseManager getFuGouBangModelArrayWithResponseObject:responseObject];
    } else if (self.currentType == FuGouBangType) {
        self.secondArray = [CSParseManager getFuGouBangModelArrayWithResponseObject:responseObject];
    } else if (self.currentType == QianLiBangType) {
        self.thirdArray = [CSParseManager getFuGouBangModelArrayWithResponseObject:responseObject];
    }
    [self.listTableView reloadData];
}
- (void)changeButtonStatusWithTag:(NSUInteger)tag {
    
    
    if (tag == 0) {
        self.recordRankType = @"good";
        [self.firstButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.firstButton.titleLabel.font = csCharacterFont_18;
    } else {
        [self.firstButton setTitleColor:cs333333Color forState:UIControlStateNormal];
         self.firstButton.titleLabel.font = csCharacterFont_15;
    }
    
    if (tag == 1) {
        self.recordRankType = @"repeat";
        [self.secondButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.secondButton.titleLabel.font = csCharacterFont_18;

    }else {
        [self.secondButton setTitleColor:cs333333Color forState:UIControlStateNormal];
        self.secondButton.titleLabel.font = csCharacterFont_15;

    }
    
    
    
    if (tag == 2) {
        self.recordRankType = @"potential";
        [self.thirdButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.thirdButton.titleLabel.font = csCharacterFont_18;

    }else {
        [self.thirdButton setTitleColor:cs333333Color forState:UIControlStateNormal];
        self.thirdButton.titleLabel.font = csCharacterFont_15;

    }
    
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        CGFloat width = MainScreenWidth * 0.333;
        
      self.lineViewLeftConstraint.constant = width * tag;
        
        [self.view layoutIfNeeded];
        
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    self.currentType = tag;
    
    if ([self getCurrentArray].count == 0) {
        [self sendGetRequest];

    } else {
        [self.listTableView reloadData];
    }
    
    
}
- (FuGouBangModel *)getCurrentModel:(NSIndexPath *)indexPath {
    
    
    if (self.currentType == HaoPingBangType) {
        
        return  self.firstArray[indexPath.row];
        
    } else if (self.currentType == FuGouBangType) {
      
        return   self.secondArray[indexPath.row];
    
    }
    
    return  self.thirdArray[indexPath.row];
    
    
}
- (NSMutableArray *)getCurrentArray {
    if (self.currentType == HaoPingBangType) {
        return  self.firstArray;
    } else if (self.currentType == FuGouBangType) {
        return   self.secondArray;
    } else if (self.currentType == QianLiBangType) {
        return  self.thirdArray;
    }
    return @[].mutableCopy;
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self getCurrentArray].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FuGouBangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(FuGouBangTableViewCell)];
    cell.model = [self getCurrentModel:indexPath];
    if (self.currentType == HaoPingBangType) {
        cell.titleView.hidden = YES;
    } else if (self.currentType == FuGouBangType) {
        cell.titleView.hidden = NO;
        cell.titleViewTopConstraint.constant = 3;
    } else {
        cell.titleView.hidden = NO;
        cell.titleViewTopConstraint.constant = 24;
    }
    if (indexPath.row < 3) {
        cell.firstLabel.hidden = YES;
        cell.firstImageView.hidden = NO;
        if (indexPath.row == 0) {
            cell.firstImageView.image = DotaImageName(@"icon_jinjiang");
        } else if (indexPath.row == 1) {
            cell.firstImageView.image = DotaImageName(@"icon_yinjiang");
        }else if (indexPath.row == 2) {
            cell.firstImageView.image = DotaImageName(@"icon_tongjaing");
        }
    } else {
        cell.firstLabel.hidden = NO;
        cell.firstImageView.hidden = YES;
        cell.firstLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentType == QianLiBangType) {
        return 106;
    }
    return 82;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DaShiDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"DaShiDetailViewController"];
    [self.navigationController pushViewController:new animated:YES];
}
@end
