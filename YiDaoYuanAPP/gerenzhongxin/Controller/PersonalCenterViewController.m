//
//  PersonalCenterViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCollectionViewCell.h"
#import "PersonalModel.h"
#import "MoneyHistoryViewController.h"
#import "JinXinZhongDetailViewController.h"
#import "UserJudgeViewController.h"
#import "NewPersonalCenterViewTableViewCell.h"
#import "PersonalFirstRowTableViewCell.h"
@interface PersonalCenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *itemMutableArray;

@property (nonatomic, strong) NSMutableArray *daShiMutableArray;

@property (nonatomic, strong) NSString *recordYuEOrYiDaoYunTitle;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL userIsDaShi;
@end

@implementation PersonalCenterViewController

- (NSMutableArray *)daShiMutableArray {
    if (!_daShiMutableArray) {
        _daShiMutableArray = @[].mutableCopy;
        
        PersonalModel *model1 = [PersonalModel new];
        
        model1.title = @"我的评价";
        model1.image = @"icon_1_pingjia-1";
        
        [_daShiMutableArray addObject:model1];
        
        PersonalModel *model2 = [PersonalModel new];
        model2.title = @"我的问答";
        model2.image = @"icon_2_wenda-1";
        [_daShiMutableArray addObject:model2];
        
        PersonalModel *model3 = [PersonalModel new];
        model3.title = @"我的评分";
        model3.image = @"icon_3_评分-1";
        
        [_daShiMutableArray addObject:model3];
        
        PersonalModel *model4 = [PersonalModel new];
        model4.title = @"充值";
        model4.image = @"icon_2_shouyi -1";
        
        [_daShiMutableArray addObject:model4];
        
        PersonalModel *model5 = [PersonalModel new];
        model5.title = @"大师入驻";
        model5.image = @"icon_3_dashi-1";
        
        [_daShiMutableArray addObject:model5];
        
        
        
        PersonalModel *model6 = [PersonalModel new];
        model6.title = @"城市合伙人";
        model6.image = @"icon_4_chengshi-1";
        
        [_daShiMutableArray addObject:model6];
        
        
        
        PersonalModel *model8 = [PersonalModel new];
        model8.title = @"商城";
        model8.image = @"icon_shangcheng-1";
        
        [_daShiMutableArray addObject:model8];
        
        
        PersonalModel *model7 = [PersonalModel new];
        model7.title = @"邀请分享";
        model7.image = @"icon_5_yaoqing-1";
        
        [_daShiMutableArray addObject:model7];
        
        PersonalModel *model9 = [PersonalModel new];
        model9.title = @"意见反馈";
        model9.image = @"意见反馈";
        
        [_daShiMutableArray addObject:model9];
        
        
        PersonalModel *model10 = [PersonalModel new];
        model10.title = @"关于我们";
        model10.image = @"icon_guanyuwomen";
        
        [_daShiMutableArray addObject:model10];
        
    }
    return _daShiMutableArray;
}


- (NSMutableArray *)itemMutableArray {
    if (!_itemMutableArray) {
        _itemMutableArray = @[].mutableCopy;
        
        PersonalModel *model1 = [PersonalModel new];
       
        model1.title = @"我的评价";
        model1.image = @"icon_1_pingjia-1";
        
        [_itemMutableArray addObject:model1];
        
    
        
        PersonalModel *model4 = [PersonalModel new];
        model4.title = @"充值";
        model4.image = @"icon_2_shouyi -1";
        
        [_itemMutableArray addObject:model4];
        
        PersonalModel *model5 = [PersonalModel new];
        model5.title = @"大师入驻";
        model5.image = @"icon_3_dashi-1";
      
        [_itemMutableArray addObject:model5];
        
        
        
        PersonalModel *model6 = [PersonalModel new];
        model6.title = @"城市合伙人";
        model6.image = @"icon_4_chengshi-1";
      
        [_itemMutableArray addObject:model6];
        
        PersonalModel *model8 = [PersonalModel new];
        model8.title = @"商城";
        model8.image = @"icon_shangcheng-1";
        
        [_itemMutableArray addObject:model8];
        
        PersonalModel *model7 = [PersonalModel new];
        model7.title = @"邀请分享";
        model7.image = @"icon_5_yaoqing-1";
       
        [_itemMutableArray addObject:model7];
        
        
        PersonalModel *model9 = [PersonalModel new];
        model9.title = @"意见反馈";
        model9.image = @"意见反馈";
        
        [_itemMutableArray addObject:model9];
        
        
        PersonalModel *model10 = [PersonalModel new];
        model10.title = @"关于我们";
        model10.image = @"icon_guanyuwomen";
        
        [_itemMutableArray addObject:model10];
    }
    return _itemMutableArray;
}
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
    
//    [self.itemCollectionView registerNib:[UINib nibWithNibName:CSCellName(PersonalCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(PersonalCollectionViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(NewPersonalCenterViewTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(NewPersonalCenterViewTableViewCell)];
    
     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PersonalFirstRowTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PersonalFirstRowTableViewCell)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = 50;
}

- (void)configSubViews {
   
    
    
    
    
}
- (void)clickYuELabel {
    self.recordYuEOrYiDaoYunTitle =@"余额";
    [self performSegueWithIdentifier:@"MoneyHistoryViewController" sender:self];
}
- (void)clickYiDaoYunLabel {
    self.recordYuEOrYiDaoYunTitle =@"易道元";

     [self performSegueWithIdentifier:@"MoneyHistoryViewController" sender:self];
}
- (void)clickHeaderViewDone {
    self.userIsDaShi = !self.userIsDaShi;
    if (self.userIsDaShi) {
        self.title = @"个人中心大师端";
    }else {
        self.title = @"个人中心";
    }
    [self.tableView reloadData];
}
- (void)clickAnswerViewDone {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (self.userIsDaShi) {
        [self performSegueWithIdentifier:@"DaShiDuanZiXunViewController" sender:self];
        return;
    }
    
    
    JinXinZhongDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"JinXinZhongDetailViewController"];
    
    [self.navigationController pushViewController:new animated:YES];
}
- (void)clickMyCollectViewDone {
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"MyCollectViewController" sender:self];
}
- (void)clickConsultViewDone {
    if (self.userIsDaShi) {
        [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiDuanZiXunViewController" sender:self];
        return;
    }
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"ConsultOrderViewController" sender:self];
    
}
- (void)configNavigationBar {
    
    self.title = @"我的";
    
    BlueNavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"FFFFFF"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_shezhi") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickLocationButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)clickLocationButtonDone {
   
    [self performSegueWithIdentifier:@"PersonalSetViewController" sender:self];
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
   
    if (self.userIsDaShi) {
     
        return self.daShiMutableArray.count;
   
    }
    
    return self.itemMutableArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        PersonalFirstRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PersonalFirstRowTableViewCell) forIndexPath:indexPath];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickConsultViewDone)];
        
        tap.numberOfTapsRequired = 1;
        
        tap.numberOfTouchesRequired = 1;
        
        [cell.consultView addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMyCollectViewDone)];
        
        tap1.numberOfTapsRequired = 1;
        
        tap1.numberOfTouchesRequired = 1;
        
        [cell.myCollectView addGestureRecognizer:tap1];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAnswerViewDone)];
        
        tap2.numberOfTapsRequired = 1;
        
        tap2.numberOfTouchesRequired = 1;
        
        [cell.answerView addGestureRecognizer:tap2];
        
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeaderViewDone)];
        
        tap3.numberOfTapsRequired = 1;
        
        tap3.numberOfTouchesRequired = 1;
        
        [cell.headImageView addGestureRecognizer:tap3];
        
        UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickYuELabel)];
        
        tap4.numberOfTapsRequired = 1;
        
        tap4.numberOfTouchesRequired = 1;
        
        [cell.yuEView addGestureRecognizer:tap4];
        
        UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickYiDaoYunLabel)];
        
        tap5.numberOfTapsRequired = 1;
        
        tap5.numberOfTouchesRequired = 1;
        
        [cell.yidaoyuanView addGestureRecognizer:tap5];
        
        
        
        
        
        return cell;
    }
    NewPersonalCenterViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(NewPersonalCenterViewTableViewCell)];
   
    PersonalModel *model = [PersonalModel new];
    
    if (self.userIsDaShi) {
        model = self.daShiMutableArray[indexPath.row];
    } else {
        model = self.itemMutableArray[indexPath.row];
    }
    
    cell.csImageView.image = DotaImageName(model.image);
    cell.csTitleLabel.text = model.title;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 263;
    }
    return 45;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return;
    }
    PersonalModel *model = [PersonalModel new];
    
    if (self.userIsDaShi) {
        model = self.daShiMutableArray[indexPath.row];
    } else {
        model = self.itemMutableArray[indexPath.row];
    }
    
    if ([model.title isEqualToString:@"充值"]) {
        [self performSegueWithIdentifier:@"ChongZhiViewController" sender:self];
    } else if ([model.title isEqualToString:@"大师入驻"]) {
        [self performSegueWithIdentifier:@"DaShiRuZhuViewController" sender:self];
    } else if ([model.title isEqualToString:@"城市合伙人"]) {
        [self performSegueWithIdentifier:@"ChengShiHeHuoRenViewController" sender:self];
    }else if ([model.title isEqualToString:@"邀请分享"]) {
        [self performSegueWithIdentifier:@"ShareViewController" sender:self];
    }else if ([model.title isEqualToString:@"商城"])  {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
        
        [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"shoppingStoryboard"];
    } else if ([model.title isEqualToString:@"我的评价"]) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        UserJudgeViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserJudgeViewController"];
        
        [self.navigationController pushViewController:new animated:YES];
    }
}
//#pragma mark -- UICollectionViewDataSource/Delegate
//// UIEdgeInsets insets = {top, left, bottom, right};
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//
//
//    return CGSizeMake((MainScreenWidth - 10 * 5) / 4.0, 80);
//
//}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//
//    return UIEdgeInsetsMake(10, 15, 10, 15);
//    //    return UIEdgeInsetsMake(0, 0, 0, 0);
//
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 5;
//}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//
//    return 5;
//}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (self.userIsDaShi) {
//        return self.daShiMutableArray.count;
//    }
//    return self.itemMutableArray.count;
//}
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    PersonalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(PersonalCollectionViewCell) forIndexPath:indexPath];
//
//    PersonalModel *model = [PersonalModel new];
//
//    if (self.userIsDaShi) {
//        model = self.daShiMutableArray[indexPath.row];
//    } else {
//         model = self.itemMutableArray[indexPath.row];
//    }
//
//    cell.csImageView.image = DotaImageName(model.image);
//    cell.csTitleLabel.text = model.title;
//
//
//    return cell;
//
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//
//    PersonalModel *model = [PersonalModel new];
//
//    if (self.userIsDaShi) {
//        model = self.daShiMutableArray[indexPath.row];
//    } else {
//        model = self.itemMutableArray[indexPath.row];
//    }
//
//    if ([model.title isEqualToString:@"充值"]) {
//        [self performSegueWithIdentifier:@"ChongZhiViewController" sender:self];
//    } else if ([model.title isEqualToString:@"大师入驻"]) {
//        [self performSegueWithIdentifier:@"DaShiRuZhuViewController" sender:self];
//    } else if ([model.title isEqualToString:@"城市合伙人"]) {
//        [self performSegueWithIdentifier:@"ChengShiHeHuoRenViewController" sender:self];
//    }else if ([model.title isEqualToString:@"邀请分享"]) {
//        [self performSegueWithIdentifier:@"ShareViewController" sender:self];
//    }else if ([model.title isEqualToString:@"商城"])  {
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
//
//        [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"shoppingStoryboard"];
//    } else if ([model.title isEqualToString:@"我的评价"]) {
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        UserJudgeViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserJudgeViewController"];
//
//        [self.navigationController pushViewController:new animated:YES];
//    }
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MoneyHistoryViewController"]) {
        
        MoneyHistoryViewController *new = segue.destinationViewController;
        
        new.passString = self.recordYuEOrYiDaoYunTitle;;
    }
    
}
@end
