//
//  YiDaoKeTangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangViewController.h"

#import "ZJZXMoreTableViewCell.h"
#import "YiDaoKeTangTableViewCell.h"

#import "PersonalTopCollectionViewCell.h"

#import "PersonalSubTitleCollectionViewCell.h"
#import "YiDaoKeTangHotTableViewCell.h"

#import "YiDaoKeTangListViewController.h"
#import "YiDaoKeTangDetailViewController.h"
@interface YiDaoKeTangViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YiDaoKeTangHotTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;

@property (nonatomic, strong) NSMutableArray *topArray;
@property (nonatomic, strong) NSMutableArray *jingArray;
@property (nonatomic, strong) NSMutableArray *shiArray;
@property (nonatomic, strong) NSMutableArray *ziArray;
@property (nonatomic, strong) NSMutableArray *jiArray;
@property (nonatomic, assign) NSInteger currentNumber;

@property (nonatomic, strong) YiDaoKeTangModel *hotModel;
@property (nonatomic, strong) NSMutableArray *fufeiArray;
@property (nonatomic, strong) NSString *recordVideoId;
@property (nonatomic, strong) NSString *recordHot;
@property (nonatomic, strong) NSString *recordFree;
@property (nonatomic, strong) NSString *recordCategoryId;
@end

@implementation YiDaoKeTangViewController
- (YiDaoKeTangModel *)hotModel {
    if (!_hotModel) {
        _hotModel = YiDaoKeTangModel.new;
    }
    return _hotModel;
}
- (NSMutableArray *)fufeiArray {
    if (!_fufeiArray) {
        _fufeiArray = @[].mutableCopy;
    }
    return _fufeiArray;
}
- (NSMutableArray *)jiArray {
    if (!_jiArray) {
        _jiArray = @[].mutableCopy;

//        NSArray *titleArray = @[@"文集",@"道经",@"佛经"];
//
//        for (NSString *title in titleArray) {
//            PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
//            model.title = title;
//            model.choose = NO;
//            [_jiArray addObject:model];
//        }
//        PersonalTitleCollectionModel *model = _jiArray[0];
//        model.choose = YES;
        
    }
    return _jiArray;
}
- (NSMutableArray *)ziArray {
    if (!_ziArray) {
        _ziArray = @[].mutableCopy;

      
    }
    return _ziArray;
}
- (NSMutableArray *)shiArray {
    if (!_shiArray) {
        _shiArray = @[].mutableCopy;

      
        
    }
    return _shiArray;
}
- (NSMutableArray *)jingArray {
    if (!_jingArray) {
        _jingArray = @[].mutableCopy;
        
        
    }
    return _jingArray;
}
- (NSMutableArray *)topArray {
    if (!_topArray) {
        _topArray = @[].mutableCopy;
        PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
        model.imageString = @"img_jing";
         model.choose = YES;
        [_topArray addObject:model];
        
        PersonalTitleCollectionModel *model1 = [PersonalTitleCollectionModel new];
          model1.imageString = @"img_shi";
         model1.choose = NO;
        [_topArray addObject:model1];
        
        PersonalTitleCollectionModel *model2 = [PersonalTitleCollectionModel new];
          model2.imageString = @"img_zi";
         model2.choose = NO;
        [_topArray addObject:model2];
        
        PersonalTitleCollectionModel *model3 = [PersonalTitleCollectionModel new];
          model3.imageString = @"img_ji";
        model3.choose = NO;
        [_topArray addObject:model3];
        
    }
    return _topArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.currentNumber = 1;
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
   
    [self configCollectionView];
    
    [self sendGetRequest];
}
- (void)sendGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
   
    para[@"type"] = [NSString stringWithFormat:@"%ld",(long)self.currentNumber];
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Course_Category Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            [self configArray:CSGetResult[@"lists"]];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configArray:(id)result {
    
    if (self.currentNumber == 1) {
        //jing
        self.jingArray = [CSParseManager getPersonalTitleCollectionModelArrayWithResponseObject:result];
    } else if (self.currentNumber == 2) {
        self.shiArray = [CSParseManager getPersonalTitleCollectionModelArrayWithResponseObject:result];
    }else if (self.currentNumber == 3) {
        self.ziArray = [CSParseManager getPersonalTitleCollectionModelArrayWithResponseObject:result];
    }else if (self.currentNumber == 4) {
        self.jiArray = [CSParseManager getPersonalTitleCollectionModelArrayWithResponseObject:result];
    }
    [self reloadCollectionView];
    
}
- (void)sendGetRequestWithId:(NSString *)idString {
    NSMutableDictionary *para = @{}.mutableCopy;
  
    para[@"category_id"] = idString;
  
    para[@"is_hot"] = @"1";

    para[@"pageSize"] = @"1";
    
    self.recordCategoryId = idString;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Course Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            NSMutableArray *arrar = [CSParseManager getYiDaoKeTangModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (arrar.count != 0) {
                self.hotModel = arrar[0];
            }
            [self.tableview reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    [self sendGetFuFeiRequestWithId:idString];
}
- (void)sendGetFuFeiRequestWithId:(NSString *)idString {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"category_id"] = idString;
    
    para[@"pageSize"] = @"2";
    
    para[@"is_fee"] = @"1";

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Course Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.fufeiArray = [CSParseManager getYiDaoKeTangModelArrayWithResponseObject:CSGetResult[@"lists"]];
           
            [self.tableview reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  
    //创建UICollectionView
    self.itemCollectionView.collectionViewLayout = layout;
  
    //设置位置和尺寸
    self.itemCollectionView.delegate = self;
    self.itemCollectionView.dataSource = self;
    //注册cell的ID
    [self.itemCollectionView registerNib:[UINib nibWithNibName:CSCellName(PersonalSubTitleCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(PersonalSubTitleCollectionViewCell)];
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.topCollectionView.collectionViewLayout = layout1;
    
    //设置位置和尺寸
    self.topCollectionView.delegate = self;
    self.topCollectionView.dataSource = self;
    //注册cell的ID
    [self.topCollectionView registerNib:[UINib nibWithNibName:CSCellName(PersonalTopCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(PersonalTopCollectionViewCell)];
    
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangHotTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangHotTableViewCell)];
    
}
- (void)clickSearchView {
     [self performSegueWithIdentifier:@"YiDaoKeTangSearchViewController" sender:self];
}

- (void)configSubViews {
    


    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchView)];
    
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.searchView addGestureRecognizer:tap];
    
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
    
    
   
}

- (void)configNavigationBar {
    
    self.title = @"易道课堂";
    
    F3f3f3NavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark --UICollectionDelegate/DataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        
        return CGSizeMake((MainScreenWidth - 0 * 3) * 0.25, 141);
    }
//    return CGSizeMake(100, 35);
    PersonalTitleCollectionModel *model = [self getCurrentSubModelWithIndexPath:indexPath];
   
    return CGSizeMake(30 * model.title.length, 35);
}
- (PersonalTitleCollectionModel *)getCurrentSubModelWithIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger currentClick = 0;
    for (int i = 0; i < self.topArray.count; i ++) {
       
        PersonalTitleCollectionModel *model = self.topArray[i];
        if (model.choose) {
            currentClick = i;
            break;
        }
    }
    PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
    
    NSMutableArray *array = [self getCurrentArrayWithIndex:currentClick];
    
    if (array.count == 0) {
        return model;
    }
    
    
    return array[indexPath.row];
}
- (NSMutableArray *)getCurrentArrayWithIndex:(NSInteger)index {
    if (index == 0) {
        return self.jingArray;
    }
    if (index == 1) {
        return self.shiArray;
    }
    if (index == 2) {
        return self.ziArray;
    }
    
    return self.jiArray;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 1) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 0, 10, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
  
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 0) {
        return 4;
    }
    
    return [self getCurrenArray].count;
}
- (NSMutableArray *)getCurrenArray {
    NSInteger index = 0;
    for (int i = 0; i < self.topArray.count; i ++) {
        
        PersonalTitleCollectionModel *model = self.topArray[i];
        if (model.choose) {
            index = i;
            break;
        }
    }
    if (index == 0) {
        return self.jingArray;
    }
    if (index == 1) {
        return self.shiArray;
    }
    if (index == 2) {
        return self.ziArray;
    }
    
    return self.jiArray;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        PersonalTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(PersonalTopCollectionViewCell) forIndexPath:indexPath];
        PersonalTitleCollectionModel *model = self.topArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    PersonalSubTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(PersonalSubTitleCollectionViewCell) forIndexPath:indexPath];
  PersonalTitleCollectionModel *model = [self getCurrenArray][indexPath.row];
    cell.model = model;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        
        
        for (int i = 0; i < self.topArray.count; i ++) {
            PersonalTitleCollectionModel *model = self.topArray[i];
            if (i == indexPath.row) {
                self.currentNumber = i + 1;
                model.choose = YES;
            } else {
                model.choose = NO;
            }
        }
        if ([self getCurrenArray].count == 0) {
           
            [self sendGetRequest];

        } else {
            [self reloadCollectionView];
        }
        return ;
    }
    NSMutableArray *currentArray = [self getCurrenArray];
   
    for (int i = 0; i < currentArray.count; i ++) {
        PersonalTitleCollectionModel *model = currentArray[i];
        if (i == indexPath.row) {
            model.choose = YES;
        } else {
            model.choose = NO;
        }
    }
    [self reloadCollectionView];
    
}
- (void)reloadCollectionView {
    
    NSMutableArray *currentArray = [self getCurrenArray];
    PersonalTitleCollectionModel *newModel = [PersonalTitleCollectionModel new];
    for (int i = 0; i < currentArray.count; i ++) {
        PersonalTitleCollectionModel *model = currentArray[i];
        if (model.choose) {
            newModel = model;
        }
    }
    [self sendGetRequestWithId:newModel.idString];
    
     [self.topCollectionView reloadData];
    [self.itemCollectionView reloadData];
    
   
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (self.fufeiArray.count == 0) {
        return 0;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"热门课堂";
        cell.moreTitleLabel.hidden = NO;
        cell.moreTitleLabel.text = @"查看更多 >";
        return cell;
    } else if (indexPath.section == 1) {
        YiDaoKeTangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
        cell.model = self.hotModel;
        return cell;
    } else if (indexPath.section == 2) {
        
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"付费课堂";
        cell.moreTitleLabel.hidden = NO;
        cell.moreTitleLabel.text = @"查看更多 >";
        return cell;
    }
    
    YiDaoKeTangHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangHotTableViewCell) forIndexPath:indexPath];
    cell.csDelegate = self;
    cell.hotArray = self.fufeiArray;
    return cell;
}
- (void)goWhichIdString:(NSString *)classId {
    self.recordVideoId = classId;
     [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.recordHot =@"1";
        self.recordFree = @"";
        [self performSegueWithIdentifier:@"YiDaoKeTangListViewController" sender:self];
    } else if (indexPath.section == 1) {
        self.recordVideoId = self.hotModel.class_id;
        [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
    }else if (indexPath.section == 2) {
        self.recordHot =@"";
        self.recordFree = @"1";
        [self performSegueWithIdentifier:@"YiDaoKeTangListViewController" sender:self];
    }
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 54;
    }
    if (indexPath.section == 1) {
        return 273;
    }
    if (indexPath.section == 2) {
        return 54;
    }
     return 333;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"YiDaoKeTangListViewController"]) {
        YiDaoKeTangListViewController *new = segue.destinationViewController;
        new.passIdString = self.recordCategoryId;
        new.isHot = self.recordHot;
        new.isFree = self.recordFree;
    }else if ([segue.identifier isEqualToString:@"YiDaoKeTangDetailViewController"]) {
        YiDaoKeTangDetailViewController *new = segue.destinationViewController;
        new.passId = self.recordVideoId;
    }
}
@end
