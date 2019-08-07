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

#import "CoreLocation/CoreLocation.h"
#import "DaShiDetailViewController.h"
#import "ManyItemTableViewCell.h"
#import "DaShiListViewController.h"

#import "DaShisPingJiaViewController.h"

CGFloat const AD_Height = 180;
@interface ZhuanJiaZiXunViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, ZJZXDaShiTableViewCellDelegate,ManyItemTableViewCellDelegate>
@property (nonatomic, strong) NSString *recordAdImage;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@property (strong, nonatomic) CLLocationManager* locationManager;

@property (nonatomic, strong) UIBarButtonItem *leftItem;

@property (nonatomic, strong) NSMutableArray *daShiArray;
@property (nonatomic, strong) NSMutableArray *userJudgeArray;
@property (nonatomic, strong) NSString *recordMasterId;

@property (nonatomic, strong) NSMutableArray *itemArray;

@property (nonatomic, strong) NSString *recordItemId;

@property (nonatomic, strong) NSMutableArray *adImageArray;
@end

@implementation ZhuanJiaZiXunViewController


- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillDisappear:animated];

    NSString *location = [[NSUserDefaults standardUserDefaults] stringForKey:@"CSLocationCity"];
    [self configLeftItem:location];
    [self getNoRead];
}
- (void)getNoRead {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendNoCheckLoginStatusGetRequestWithNeedToken:YES Url:CSURL_portal_msg_unread Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            NSString *badgeNum =[NSString stringWithFormat:@"%@",CSGetResult[@"count"]];
            UIViewController *tController = [self.tabBarController.viewControllers objectAtIndex:2];
            int badgeValue = [badgeNum intValue];
            if (badgeValue >0) {
                tController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",badgeValue];
            }else{
                tController.tabBarItem.badgeValue = nil;
            }
            
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.adImageArray = @[].mutableCopy;
    NSString *location = [[NSUserDefaults standardUserDefaults] stringForKey:@"CSLocationCity"];
   
    [self configLeftItem:location];
    
    self.daShiArray = @[].mutableCopy;
    self.userJudgeArray = @[].mutableCopy;
    self.itemArray = @[].mutableCopy;
    [self sendGetRequest];
    
    [self startLocation];
}
- (void)sendGetRequest {
    
    [self getBannerRequest];
    [self getHotDaShi];
    [self getUserPingLun];
    [self getItemRequest];
    if (self.mainTableView.mj_header.isRefreshing) {
        [self.mainTableView.mj_header endRefreshing];
    }
}
- (void)getBannerRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_hot_banner Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.adImageArray = [CSParseManager getHomePageADModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getItemRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_hot_item Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.itemArray = [CSParseManager getFirstPageManyItemModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getUserPingLun {
   
    NSMutableDictionary *para = @{}.mutableCopy;
    

    para[@"type"] = @"1";
    para[@"page"] = @"1";

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Index_Bask Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.userJudgeArray = [CSParseManager getUserPingLunFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.mainTableView reloadData];

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)getHotDaShi {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Re Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
             self.daShiArray = [CSParseManager getDaShiFirstPageModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.mainTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
-(void)startLocation{
    
    if ([CLLocationManager locationServicesEnabled]) {//判断定位操作是否被允许
        
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;//遵循代理
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.locationManager.distanceFilter = 10.0f;
        
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
        
        [self.locationManager startUpdatingLocation];//开始定位
        
    }else{//不能定位用户的位置的情况再次进行判断，并给与用户提示
        
        //1.提醒用户检查当前的网络状况
        
        //2.提醒用户打开定位开关
        
    }
    
}
#pragma mark -- CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //当前所在城市的坐标值
    CLLocation *currLocation = [locations lastObject];
    
    CSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            //  Country(国家)  State(省)  City（市）
           
            CSLog(@"#####%@",address);
            
            CSLog(@"%@", [address objectForKey:@"Country"]);
            
            CSLog(@"%@", [address objectForKey:@"State"]);
            
            CSLog(@"%@", [address objectForKey:@"City"]);
           
            [self configLeftItem:[address objectForKey:@"City"]];

            [[NSUserDefaults standardUserDefaults] setValue:[address objectForKey:@"City"] forKey:@"CSLocationCity"];
        }
        
    }];
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
    }
}
- (void)configTableView {
    
    self.mainTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.showsHorizontalScrollIndicator = NO;
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXFirstRowTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXFirstRowTableViewCell)];
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXDaShiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXDaShiTableViewCell)];
    
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXDaShiBangDangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXDaShiBangDangTableViewCell)];
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXJudgeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXJudgeTableViewCell)];
    
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXBannerTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXBannerTableViewCell)];
    
     [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ManyItemTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ManyItemTableViewCell)];
    
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendGetRequest)];
    
}
- (void)configSubViews {
    
}

- (void)configNavigationBar {
    
   WhiteNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    CSTitleSearchView *searchView = [[CSTitleSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 22)];
    
    searchView.intrinsicContentSize = CGSizeMake(self.view.width - 30, 35);
    
    self.navigationItem.titleView = searchView;
    
    
    [self configLeftItem:@"深圳市"];
    
}
- (void)configLeftItem:(NSString *)title {
    UIButton *leftButton = [[UIButton alloc] init];
    
   
    
    [leftButton setImage:DotaImageName(@"icon_dingwei") forState:UIControlStateNormal];
    
    [leftButton setTitleColor:cs999999Color forState:UIControlStateNormal];
    leftButton.titleLabel.font = csCharacterFont_12;
    
    [leftButton addTarget:self action:@selector(clickLocationButtonDone) forControlEvents:UIControlEventTouchDown];
    
    if (csCharacterIsBlank(title)) {
         [leftButton setTitle:@"中国" forState:UIControlStateNormal];
    } else {
        if (title.length > 3) {
            title = [title substringToIndex:3];
        }
         [leftButton setTitle:title forState:UIControlStateNormal];
    }
    
    self.leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    
    
    UIBarButtonItem *lineItem =  [[UIBarButtonItem alloc] initWithTitle:@"|" style:UIBarButtonItemStylePlain target:self action:@selector(clickLocationButtonDone)];
    
    [lineItem setTintColor:[UIColor colorWithHexString:@"0D71C8"]];
    
    
    self.navigationItem.leftBarButtonItems = @[self.leftItem, lineItem];
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
        return 3;
    }else if (section == 2) {
        if (self.daShiArray.count == 0) {
            return 0;
        }
        return 1;
    }else if (section == 3) {
        return 2;
    }
    return self.userJudgeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZJZXBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXBannerTableViewCell)];
        
        cell.adImageArray = self.adImageArray;
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ManyItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ManyItemTableViewCell) forIndexPath:indexPath];
            cell.listArray = self.itemArray;
            cell.csDelegate = self;
            return cell;
        }
        if (indexPath.row == 1) {
            ZJZXFirstRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXFirstRowTableViewCell)];
            return cell;
        }
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"推荐大师";
        return cell;
    } else if (indexPath.section == 2) {
        ZJZXDaShiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXDaShiTableViewCell)];
        cell.daShiArray = self.daShiArray;
        cell.csDelegate = self;
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
    FirstPageModel *model = self.userJudgeArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)passDaShiMasterId:(NSString *)idString {
    self.recordMasterId = idString;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        
//        [self  performSegueWithIdentifier:@"DaShiListViewController" sender:self];
       
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
            return 142 + 18 + 10;
        }
        if (indexPath.row == 1) {
            return 216;
        }
        return 45;
    } else if (indexPath.section == 2) {
        if (self.daShiArray.count == 1) {
            return 140;
            
        }
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DaShiDetailViewController"]) {
        DaShiDetailViewController *new = segue.destinationViewController;
        new.passMasterID = self.recordMasterId;
    }else if ([segue.identifier isEqualToString:@"DaShiListViewController"]) {
        DaShiListViewController *new = segue.destinationViewController;
        new.passId = self.recordItemId;
        new.adImage = self.recordAdImage;
    }
}

- (void)passItemId:(FirstPageManyItemModel *)model {
    self.recordItemId = model.item_id;
    self.recordAdImage  = model.ad;
}
@end
