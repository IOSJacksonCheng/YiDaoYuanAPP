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
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation UserJudgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    
    
    self.judgeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
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
    
    [self.judgeTableView reloadData];
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
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 2) {
        UserDefaultJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(UserDefaultJudgeTableViewCell)];
        return cell;
    }
    DaShiDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == 0 || self.currentIndex == 1) {
        return 132.5;
    }
    
    return 96.5;
}
@end
