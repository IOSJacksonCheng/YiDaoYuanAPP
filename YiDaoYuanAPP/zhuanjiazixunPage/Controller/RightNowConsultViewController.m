//
//  RightNowConsultViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "RightNowConsultViewController.h"
//356.5
#import "RightNowConsultTableViewCell.h"
#import "RightNowConsultIntroduceTableViewCell.h"
//54
#import "ZJZXMoreTableViewCell.h"
@interface RightNowConsultViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (weak, nonatomic) IBOutlet UIButton *jumpButton;
- (IBAction)clickJumpButtonDone:(id)sender;

- (IBAction)clickChooseButtonDone:(id)sender;

@end

@implementation RightNowConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    self.listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(RightNowConsultTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RightNowConsultTableViewCell)];
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(RightNowConsultIntroduceTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(RightNowConsultIntroduceTableViewCell)];
    
    [self.listTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
   
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"即时咨询";
}

- (IBAction)clickJumpButtonDone:(id)sender {
    self.jumpButton.selected = !self.jumpButton.selected;
}

- (IBAction)clickChooseButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"DaShiListViewController" sender:self];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        RightNowConsultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RightNowConsultTableViewCell)];
        return cell;
    } else if (indexPath.row == 1) {
         ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.moreTitleLabel.hidden = YES;
        cell.csTitleLabel.text = @"婚恋情感";
        
        return cell;
    }else if (indexPath.row == 2) {
        RightNowConsultIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RightNowConsultIntroduceTableViewCell)];
        
        return cell;
    }else if (indexPath.row == 3) {
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.moreTitleLabel.hidden = YES;
        cell.csTitleLabel.text = @"说明";
        
        return cell;
    }
        RightNowConsultIntroduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(RightNowConsultIntroduceTableViewCell)];
        
        return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSInteger row = indexPath.row;
    
        if (row == 0) {
            
            return 356.5;
        } else if (row == 2 || row == 4) {
            
            
            return 62;
        }
        return 54;
   
}
@end
