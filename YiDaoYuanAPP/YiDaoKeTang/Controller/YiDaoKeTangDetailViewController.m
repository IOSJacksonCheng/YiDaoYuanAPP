//
//  YiDaoKeTangDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangDetailViewController.h"

#import "ZJZXMoreTableViewCell.h"
#import "YiDaoKeTangDetailDaShiTableViewCell.h"
#import "YiDaoKeTangDetailButtonTableViewCell.h"
#import "YiDaoKeTangDetailIntroduceTableViewCell.h"
#import "YiDaoKeTangDetailJudgeTableViewCell.h"
@interface YiDaoKeTangDetailViewController ()<UITableViewDelegate, UITableViewDataSource, YiDaoKeTangDetailButtonTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *freeButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL clickIntroduce;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *csInputView;

@end

@implementation YiDaoKeTangDetailViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self clickIntroduceButtonDone];
    [self.tableView reloadData];
}

- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailDaShiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailDaShiTableViewCell)];
       [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailButtonTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailIntroduceTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailIntroduceTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangDetailJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangDetailJudgeTableViewCell)];
    
}
- (void)configSubViews {
    self.freeButton.layer.cornerRadius = 5;
    self.freeButton.layer.borderColor = csBlueColor.CGColor;
    self.freeButton.layer.borderWidth = 1;
    
    self.inputTextField.layer.cornerRadius = 18;
    self.inputTextField.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    self.title = @"手相面相";
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_share-1") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickShareButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickShareButtonDone {
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    if (self.clickIntroduce) {
        return 1;
    }
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
            cell.csTitleLabel.text = @"专题目录";
            cell.moreTitleLabel.text = @"更新至1课时/共1课时";
            return cell;
        } else if (indexPath.row == 1) {
            YiDaoKeTangDetailDaShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailDaShiTableViewCell)];
            return cell;
        }
        
        YiDaoKeTangDetailButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailButtonTableViewCell)];
        cell.csDelegate = self;
        return cell;
    }
    
    if (self.clickIntroduce) {
        YiDaoKeTangDetailIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailIntroduceTableViewCell)];
        return cell;
    }
   
    //judge cell
    YiDaoKeTangDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangDetailJudgeTableViewCell)];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.clickIntroduce && indexPath.section == 1) {
        [self performSegueWithIdentifier:@"YiDaoKeTangContentViewController" sender:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
           return 54;
        } else if (indexPath.row == 1) {
            return 116.5;
        }
        return 56;
    }
    if (self.clickIntroduce) {
        return 245;
    }
    return 210;
}
#pragma mark YiDaoKeTangDetailButtonTableViewCellDelegate
- (void)clickJudgeButtonDone {
    self.clickIntroduce = NO;
    self.csInputView.hidden = NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
     self.inputViewHeightConstraint.constant = 50;
}
- (void)clickIntroduceButtonDone {
    self.clickIntroduce = YES;
     self.csInputView.hidden = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    self.inputViewHeightConstraint.constant = 0;
}
@end
