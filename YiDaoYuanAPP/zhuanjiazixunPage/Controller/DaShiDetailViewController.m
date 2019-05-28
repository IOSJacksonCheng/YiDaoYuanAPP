//
//  DaShiDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDetailViewController.h"

#import "DaShiDetailMoreServicesTableViewCell.h"
#import "DaShiDetailChooseServiceTableViewCell.h"
#import "DaShiDetailCenterTableViewCell.h"
#import "DaShiDetailJudgeTableViewCell.h"
#import "DaShiDetailTitlleTableViewCell.h"
#import "ZJZXMoreTableViewCell.h"
@interface DaShiDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (weak, nonatomic) IBOutlet UIView *admireView;

@property (weak, nonatomic) IBOutlet UIView *collectView;
- (IBAction)clickRightBuyButtonDone:(id)sender;

@end

@implementation DaShiDetailViewController
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
}

- (void)configTableView {
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailMoreServicesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailMoreServicesTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailChooseServiceTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailChooseServiceTableViewCell)];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailCenterTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailCenterTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(DaShiDetailTitlleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiDetailTitlleTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];

}
- (void)configSubViews {
    UITapGestureRecognizer *newsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCollectViewDone)];
    
    newsTap.numberOfTapsRequired = 1;
    
    newsTap.numberOfTouchesRequired = 1;
    
    [self.collectView addGestureRecognizer:newsTap];
    
    UITapGestureRecognizer *newsTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdmireViewDone)];
    
    newsTap1.numberOfTapsRequired = 1;
    
    newsTap1.numberOfTouchesRequired = 1;
    
    [self.admireView addGestureRecognizer:newsTap1];
}
- (void)clickAdmireViewDone {
    
    [self performSegueWithIdentifier:@"AdmireMoneyViewController" sender:self];
}
- (void)clickCollectViewDone {
    
}
- (void)configNavigationBar {
    self.title = @"大师详情";
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_share") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickShareButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickShareButtonDone {
    
   
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else if (section == 1) {
        return 3;
    }else if (section == 2) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
            DaShiDetailTitlleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailTitlleTableViewCell)];
            return cell;
        } else if (row == 2) {
            
            DaShiDetailCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailCenterTableViewCell)];
            return cell;
        }else if (row == 1) {
            
            ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
            cell.csTitleLabel.text = @"个人介绍";
            cell.moreTitleLabel.hidden = YES;
            return cell;
        }
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"项目服务";
        cell.moreTitleLabel.hidden = YES;
        return cell;
    }else if (section == 1) {
        
        DaShiDetailChooseServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailChooseServiceTableViewCell)];
        if (indexPath.row == 0) {
            cell.csImageView.image = DotaImageName(@"icon_zhanbu");
            cell.csTitleLabel.text = @"占卜断事";
        } else if (indexPath.row == 1) {
            cell.csImageView.image = DotaImageName(@"icon_liunian");
            cell.csTitleLabel.text = @"流年运势";
        }else if (indexPath.row == 2) {
            cell.csImageView.image = DotaImageName(@"icon_mingyun-1");
            cell.csTitleLabel.text = @"命运详批";
        }
         return cell;
    }else if (section == 2) {
        
        if (row == 0) {
            DaShiDetailMoreServicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailMoreServicesTableViewCell)];
            return cell;
        }
            
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"用户评价";
        cell.moreTitleLabel.hidden = NO;
        return cell;
        
        
    }
      DaShiDetailJudgeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiDetailJudgeTableViewCell)];
   
    return cell;
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 1) {
        
        
         [self  performSegueWithIdentifier:@"UserJudgeViewController" sender:self];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        if (row == 0) {
           
            return 290;
        } else if (row == 2) {
            
            
            return 180;
        }
        return 54;
    }else if (section == 1) {
        
        return 54;
    }else if (section == 2) {
        
        if (row == 0) {
            return 44;
        }
        
       return 54;
        
        
    }
  return 132.5;
}

- (IBAction)clickRightBuyButtonDone:(id)sender {
    
    
}
@end
