//
//  LunTanViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "LunTanViewController.h"
#import "LunTanTitleTableViewCell.h"
#import "LunTanButtonTableViewCell.h"

#import "LunTanMoreDetailViewController.h"

@interface LunTanViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) LunTanModel *recordId;
@end

@implementation LunTanViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_forum_index Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getLunTanModellWithResponseObject:CSGetResult[@"lists"]];
            
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
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanTitleTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(LunTanButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(LunTanButtonTableViewCell)];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)configSubViews {
    
    
}

- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"论坛";
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.listArray.count >=2) {
        return 2;
    }
    return self.listArray.count;;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
            LunTanModel *model = self.listArray[indexPath.section];
            cell.model = model;
            return cell;
        }
        
        LunTanButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanButtonTableViewCell)];
        
        cell.historyMoreLabel.hidden = YES;
        cell.hitstoryTitleLabel.hidden = YES;
        cell.historyBottomView.hidden = YES;
        cell.nowLabel.hidden = NO;
        cell.nowImageView.hidden = NO;
        
        return cell;
    }
    if (indexPath.row == 0) {
        LunTanButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanButtonTableViewCell)];
        
        cell.historyMoreLabel.hidden = NO;
        cell.hitstoryTitleLabel.hidden = NO;
        cell.historyBottomView.hidden = NO;
        cell.nowLabel.hidden = YES;
        cell.nowImageView.hidden = YES;
        
        return cell;
    }
    
    LunTanTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(LunTanTitleTableViewCell)];
    LunTanModel *model = self.listArray[indexPath.section];
    cell.model = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            
            return 240;
        }
        
       
        
        return 50;
    }
    if (indexPath.row == 0) {
        
        
        return 50;
    }
    
    return 240;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    view.backgroundColor = csf5f5f5Color;
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
         [self performSegueWithIdentifier:@"LunTanMoreViewController" sender:self];
        return;
    }
     LunTanModel *model = self.listArray[indexPath.section];
    self.recordId = model;
   [self performSegueWithIdentifier:@"LunTanMoreDetailViewController" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LunTanMoreDetailViewController"]) {
        LunTanMoreDetailViewController *new = segue.destinationViewController;
        new.passModel = self.recordId;
    }
}
@end
