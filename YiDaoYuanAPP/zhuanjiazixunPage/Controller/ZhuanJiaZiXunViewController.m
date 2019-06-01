//
//  ZhuanJiaZiXunViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZhuanJiaZiXunViewController.h"
#import "CSTitleSearchView.h"

#import "ZJZXFirstRowTableViewCell.h"

#import "ZJZXFirstRowModel.h"
#import "ZJZXDaShiTableViewCell.h"
#import "ZJZXDaShiBangDangTableViewCell.h"
#import "ZJZXJudgeTableViewCell.h"
#import "ZJZXMoreTableViewCell.h"
#import "ZJZXBannerTableViewCell.h"
CGFloat const AD_Height = 160;
@interface ZhuanJiaZiXunViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@end

@implementation ZhuanJiaZiXunViewController


- (void)viewWillAppear:(BOOL)animated {
     WhiteNavigationBarColor
    [super viewWillDisappear:animated];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
   
    
}

- (void)configTableView {
    
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXFirstRowTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXFirstRowTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXDaShiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXDaShiTableViewCell)];
    
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXDaShiBangDangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXDaShiBangDangTableViewCell)];
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXJudgeTableViewCell)];
    
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXBannerTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXBannerTableViewCell)];
    
}
- (void)configSubViews {
    
}

- (void)configNavigationBar {
    
   WhiteNavigationBarColor
    
    CSTitleSearchView *searchView = [[CSTitleSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 22)];
    
    searchView.intrinsicContentSize = CGSizeMake(self.view.width - 30, 35);
    
    self.navigationItem.titleView = searchView;
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    
    [leftButton setImage:DotaImageName(@"icon_dingwei") forState:UIControlStateNormal];
    
    [leftButton setTitleColor:cs999999Color forState:UIControlStateNormal];
    leftButton.titleLabel.font = csCharacterFont_15;
    
    [leftButton addTarget:self action:@selector(clickLocationButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    
    
    UIBarButtonItem *lineItem =  [[UIBarButtonItem alloc] initWithTitle:@"|" style:UIBarButtonItemStylePlain target:self action:@selector(clickLocationButtonDone)];
    
    [lineItem setTintColor:[UIColor colorWithHexString:@"0D71C8"]];

   
    self.navigationItem.leftBarButtonItems = @[leftItem, lineItem];
    
}
- (void)clickLocationButtonDone {
    
     [self  performSegueWithIdentifier:@"CSLocationViewController" sender:self];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 2;
    }else if (section == 2) {
        return 1;
    }else if (section == 3) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZJZXBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXBannerTableViewCell)];
        ZJZXFirstRowModel *model = [ZJZXFirstRowModel new];
        NSMutableArray *array = @[].mutableCopy;
        [array addObject:model];
        cell.adImageArray = array;
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ZJZXFirstRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXFirstRowTableViewCell)];
            return cell;
        }
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"推荐大师";
        return cell;
    } else if (indexPath.section == 2) {
        ZJZXDaShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXDaShiTableViewCell)];
        
        return cell;
    }else if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
            cell.csTitleLabel.text = @"用户晒单";
            return cell;
        }
        ZJZXDaShiBangDangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXDaShiBangDangTableViewCell)];
        
        return cell;
    }
    
    ZJZXJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXJudgeTableViewCell)];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        [self  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
       
    } else if (indexPath.section == 3 && indexPath.row == 0) {
       [self  performSegueWithIdentifier:@"FuGouBangViewController" sender:self];
    } else if (indexPath.section == 3 && indexPath.row == 1){
        
        [self  performSegueWithIdentifier:@"UserJudgeListViewController" sender:self];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return AD_Height;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 454.5;
        }
        return 54;
    } else if (indexPath.section == 2) {
        return 340;
    } else if (indexPath.section == 3) {
        if (indexPath.row == 1) {
            return 54;
        }
        return 71;
    }else if (indexPath.section == 4) {
        return 88;
    }
    return 0;
}




@end
