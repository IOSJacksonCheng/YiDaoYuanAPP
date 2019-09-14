//
//  DaShiListViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiListViewController.h"
#import "CSSearchTableViewCell.h"
#import "DaShiListItemView.h"
#import "DaShiDetailViewController.h"
#import "DaShiListItemView.h"

#import "DaShiListItemModel.h"

#import "DaShiListTypeView.h"

@interface DaShiListViewController ()<UITableViewDelegate, UITableViewDataSource, DaShiListItemViewDelegate, DaShiListTypeViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

- (IBAction)clickChooseButtonDone:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (nonatomic, strong) DaShiListItemView *itemCollectionView;
- (IBAction)clickConsultButtonDone:(UIButton *)sender;
- (IBAction)clickAllSelectionButtonDone:(id)sender;


@property (nonatomic, strong) NSMutableArray *mingliArray;

@property (nonatomic, strong) NSMutableArray *dashilevelArray;

@property (nonatomic, strong) NSMutableArray *qitaArray;

@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *shengxiaoArray;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) DaShiListTypeView *typeView;

@property (nonatomic, strong) DaShiListItemModel *levelModel;


@property (weak, nonatomic) IBOutlet UIButton *zonghepaixuButton;
@property (weak, nonatomic) IBOutlet UIButton *zixunlaoshiButton;
@property (nonatomic, strong) NSString *recordMatserId;

@property (nonatomic, strong) NSString *recordSort;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end

@implementation DaShiListViewController

- (DaShiListTypeView *)typeView {
    if (!_typeView) {
        
        if (self.noFee) {
            _typeView = [[DaShiListTypeView alloc] initWithFrame:CGRectMake(0, 38, MainScreenWidth, MainScreenHeight - 38)];

        } else {
            _typeView = [[DaShiListTypeView alloc] initWithFrame:CGRectMake(0, 135, MainScreenWidth, MainScreenHeight - 135)];

        }
        
        _typeView.csDelegate = self;
        [self.view addSubview:_typeView];
    }
    return _typeView;
}
- (NSMutableArray *)shengxiaoArray {
    if (!_shengxiaoArray) {
        _shengxiaoArray = [self getShenXiaoArray];
    }
    return _shengxiaoArray;
}

- (NSMutableArray *)getShenXiaoArray {
    
    NSMutableArray *array = @[].mutableCopy;
    
    DaShiListItemModel *model = [DaShiListItemModel new];
    model.title = @"鼠";
    model.idString = @"1";
    [array addObject:model];
    
    DaShiListItemModel *model1 = [DaShiListItemModel new];
    model1.title = @"牛";
    model1.idString = @"2";
    [array addObject:model1];
    
    DaShiListItemModel *model2 = [DaShiListItemModel new];
    model2.title = @"虎";
    model2.idString = @"3";
    [array addObject:model2];
    
    
    DaShiListItemModel *model3 = [DaShiListItemModel new];
    model3.title = @"兔";
    model3.idString = @"4";
    [array addObject:model3];
    
    DaShiListItemModel *model5 = [DaShiListItemModel new];
    model5.title = @"龙";
    model5.idString = @"5";
    [array addObject:model5];
    
    DaShiListItemModel *model6 = [DaShiListItemModel new];
    model6.title = @"蛇";
    model6.idString = @"6";
    [array addObject:model6];
    
    DaShiListItemModel *model7 = [DaShiListItemModel new];
    model7.title = @"马";
    model7.idString = @"7";
    [array addObject:model7];
    
    DaShiListItemModel *model8 = [DaShiListItemModel new];
    model8.title = @"羊";
    model8.idString = @"8";
    [array addObject:model8];
    
    DaShiListItemModel *model9 = [DaShiListItemModel new];
    model9.title = @"猴";
    model9.idString = @"9";
    [array addObject:model9];
    
    DaShiListItemModel *model10 = [DaShiListItemModel new];
    model10.title = @"鸡";
    model10.idString = @"10";
    [array addObject:model10];
    
    DaShiListItemModel *model11 = [DaShiListItemModel new];
    model11.title = @"狗";
    model11.idString = @"11";
    [array addObject:model11];
    
    DaShiListItemModel *model12 = [DaShiListItemModel new];
    model12.title = @"猪";
    model12.idString = @"12";
    [array addObject:model12];
    
    return array;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self configNavigationBar];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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
    
    self.mingliArray = @[].mutableCopy;
    
    self.dashilevelArray = @[].mutableCopy;
   
    self.qitaArray = @[].mutableCopy;

    
    [self getNewData];

    [self getDashiItem];
}
- (void)getDashiItem {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_master_condition Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
           
            self.mingliArray = [CSParseManager getDaShiListItemModelArrayWithResponseObject:CSGetResult[@"numerology"] WithQiTa:NO];
           
            self.dashilevelArray = [CSParseManager getCollectDaShiListItemModelArrayWithResponseObject:CSGetResult[@"level"]];
           
            if (csCharacterIsBlank(self.passLevelId)) {
               
                if (self.dashilevelArray.count != 0) {
                    
                    self.levelModel = self.dashilevelArray[0];
                    
                    
                    [self.zixunlaoshiButton setTitle:self.levelModel.title forState:UIControlStateNormal];
                }
                
            }
           
            
            self.qitaArray = [CSParseManager getDaShiListItemModelArrayWithResponseObject:CSGetResult[@"skilled"] WithQiTa:YES];

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)endRefresh {
    if (self.searchTableView.mj_header.isRefreshing) {
        [self.searchTableView.mj_header endRefreshing];
    }
    if (self.searchTableView.mj_footer.isRefreshing) {
        [self.searchTableView.mj_footer endRefreshing];
    }
}

- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    self.page += 1;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"sort"] = self.recordSort;

    
        para[@"item_id"] = self.passId;
        
        for (int i = 0; i < self.mingliArray.count; i ++) {
            DaShiListItemModel *model = self.mingliArray[i];
            if (model.choose) {
                para[[NSString stringWithFormat:@"numerology_id[%d]",i]] = model.idString;
            }
            
            
        }
        for (int i = 0; i < self.qitaArray.count; i ++) {
            DaShiListItemModel *model = self.qitaArray[i];
            if (model.choose) {
                para[[NSString stringWithFormat:@"skilled_id[%d]",i]] = model.idString;
            }
            
            
        }
        for (int i = 0; i < self.shengxiaoArray.count; i ++) {
            DaShiListItemModel *model = self.shengxiaoArray[i];
            if (model.choose) {
                para[@"zodiac_id"] = model.idString;
                break;
            }
            
            
        }
        para[@"level_id"] = self.levelModel.idString;
        
    NSString *url = CSURL_portal_master;
    if (self.noFee) {
        url = CSURL_portal_index_search;
    }
    [CSNetManager sendGetRequestWithNeedToken:YES Url:url Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getManyDaShiModellArrayWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！");
            } else {
                [self.listArray addObjectsFromArray:array];
                [self.searchTableView reloadData];
            }
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];

    para[@"sort"] = self.recordSort;

    
    para[@"item_id"] = self.passId;
        
        for (int i = 0; i < self.mingliArray.count; i ++) {
            DaShiListItemModel *model = self.mingliArray[i];
           
            if (model.choose) {
              
                para[[NSString stringWithFormat:@"numerology_id[%d]",i]] = model.idString;
                
            }
            
            
        }
    
        for (int i = 0; i < self.qitaArray.count; i ++) {
            DaShiListItemModel *model = self.qitaArray[i];
            if (model.choose) {
                para[[NSString stringWithFormat:@"skilled_id[%d]",i]] = model.idString;
            }
            
            
        }
        for (int i = 0; i < self.shengxiaoArray.count; i ++) {
            DaShiListItemModel *model = self.shengxiaoArray[i];
            if (model.choose) {
                para[@"zodiac_id"] = model.idString;
                break;
            }
            
            
        }
        para[@"level_id"] = self.levelModel.idString;
        
    NSString *url = CSURL_portal_master;
    if (self.noFee) {
        url = CSURL_portal_index_search;
    }
   
   
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:url Pameters:para success:^(id  _Nonnull responseObject) {
       
        [self endRefresh];

        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getManyDaShiModellArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.searchTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];

        CSInternetFailure
    }];
}
- (void)configTableView {
    self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.searchTableView.backgroundColor = [UIColor colorWithHexString:@"F3F3F3"];
    [self.searchTableView registerNib:[UINib nibWithNibName:CSCellName(CSSearchTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(CSSearchTableViewCell)];
    self.searchTableView.rowHeight = 156;
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.searchTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)configSubViews {


    self.itemCollectionView = [[DaShiListItemView alloc] initWithFrame:self.view.bounds];
    
    self.itemCollectionView.hidden = YES;
    
    self.itemCollectionView.csDelegate = self;
   
    [self.view addSubview:self.itemCollectionView];
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.adImage] placeholderImage:PlaceHolderImage];
   
    [self.zixunlaoshiButton setTitle:self.passIdTitle forState:UIControlStateNormal];
    
    if (self.noFee) {
        self.imageHeightConstraint.constant = 0;
    }
    if (!csCharacterIsBlank(self.passLevelId)) {
        self.levelModel = DaShiListItemModel.new;
        
        self.levelModel.title = self.passLevel;
        self.levelModel.idString = self.passLevelId;
         [self.zixunlaoshiButton setTitle:self.levelModel.title forState:UIControlStateNormal];
    }
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    self.title = @"大师列表";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark -- DaShiListItemViewDelegate
- (void)clickSureButton {
    [self getNewData];
    
    self.itemCollectionView.hidden = YES;

}
- (void)clickCloseViewDone {
    self.itemCollectionView.hidden = YES;
}
#pragma mark --UITableViewDelegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(CSSearchTableViewCell)];
    
    ManyDaShiModel *model = self.listArray[indexPath.row];
    if (self.noFee) {
        model.price = @"";
    }
    cell.model = model;
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ManyDaShiModel *model = self.listArray[indexPath.row];
    self.recordMatserId = model.master_id;
     [self  performSegueWithIdentifier:@"DaShiDetailViewController" sender:self];
    
}
- (IBAction)clickChooseButtonDone:(UIButton *)sender {
    
    self.typeView.hidden = YES;
    self.itemCollectionView.mingLiArray = self.mingliArray;
    self.itemCollectionView.qitaArray = self.qitaArray;
    self.itemCollectionView.shengxiaoArray = self.shengxiaoArray;
    self.itemCollectionView.hidden = NO;
}
- (IBAction)clickConsultButtonDone:(UIButton *)sender {
    self.zixunlaoshiButton.selected = !self.zixunlaoshiButton.selected;
    
    if (self.zixunlaoshiButton.selected) {
        self.typeView.levelArray = self.dashilevelArray;
        self.typeView.hidden = NO;
    } else {
        self.typeView.hidden = YES;
    }
    
}

- (IBAction)clickAllSelectionButtonDone:(id)sender {

//    self.zonghepaixuButton.selected = !self.zonghepaixuButton.selected;
    if (self.noFee) {
        NSArray *titleArray = @[@"综合排序",@"评价升序 ",@"评价降序"];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        
        for (int i = 0; i < titleArray.count; i++) {
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:titleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                self.recordSort = [NSString stringWithFormat:@"%d",i];
                
                if (i == 1) {
                    self.recordSort = @"3";
                } else if (i == 2) {
                    self.recordSort = @"4";

                }
                [self.zonghepaixuButton setTitle:titleArray[i] forState:UIControlStateNormal];
                
                [self getNewData];
                
            }];
            [alert addAction:action];
            
        }
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        
        [alert addAction:cancelAction];
        
        //5.显示AlertController
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    NSArray *titleArray = @[@"综合排序",@"价格升序",@"价格降序",@"评价升序 ",@"评价降序"];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:titleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          
            self.recordSort = [NSString stringWithFormat:@"%d",i];
            
            [self.zonghepaixuButton setTitle:titleArray[i] forState:UIControlStateNormal];
            
            [self getNewData];

        }];
        [alert addAction:action];
        
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //3.将按钮添加到AlertController中
    
    [alert addAction:cancelAction];
    
    //5.显示AlertController
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DaShiDetailViewController"]) {
       
        DaShiDetailViewController *new = segue.destinationViewController;
        
        new.passMasterID = self.recordMatserId;
        new.passitem_id = self.passId;
    }
    
}




- (void)passLevelModel:(DaShiListItemModel *)model {
    self.levelModel = model;
    self.typeView.hidden = YES;
    [self.zixunlaoshiButton setTitle:self.levelModel.title forState:UIControlStateNormal];
    self.zixunlaoshiButton.selected = NO;
    [self getNewData];
}



@end
