//
//  FuGouBangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FuGouBangViewController.h"
#import "FuGouBangTableViewCell.h"
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
@end

@implementation FuGouBangViewController

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
    
}
- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"婚恋情感";
}
- (IBAction)clickTopViewButtonDone:(UIButton *)sender {
    [self changeButtonStatusWithTag:sender.tag];
}
- (void)changeButtonStatusWithTag:(NSUInteger)tag {
    
    
    if (tag == 0) {
        //全部付款
        [self.firstButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.firstButton.titleLabel.font = csCharacterFont_18;
    } else {
        [self.firstButton setTitleColor:cs333333Color forState:UIControlStateNormal];
         self.firstButton.titleLabel.font = csCharacterFont_15;
    }
    
    if (tag == 1) {
        //待付款
        [self.secondButton setTitleColor:csBlueColor forState:UIControlStateNormal];
        self.secondButton.titleLabel.font = csCharacterFont_18;

    }else {
        [self.secondButton setTitleColor:cs333333Color forState:UIControlStateNormal];
        self.secondButton.titleLabel.font = csCharacterFont_15;

    }
    
    
    
    if (tag == 2) {
        //进行中
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
    [self.listTableView reloadData];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FuGouBangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(FuGouBangTableViewCell)];
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
@end
