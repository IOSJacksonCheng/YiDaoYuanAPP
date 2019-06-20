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
@interface YiDaoKeTangViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *topCollectionView;

@property (nonatomic, strong) NSMutableArray *topArray;
@property (nonatomic, strong) NSMutableArray *jingArray;
@property (nonatomic, strong) NSMutableArray *shiArray;
@property (nonatomic, strong) NSMutableArray *ziArray;
@property (nonatomic, strong) NSMutableArray *jiArray;

@end

@implementation YiDaoKeTangViewController
- (NSMutableArray *)jiArray {
    if (!_jiArray) {
        _jiArray = @[].mutableCopy;

        NSArray *titleArray = @[@"文集",@"道经",@"佛经"];
        
        for (NSString *title in titleArray) {
            PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
            model.title = title;
            model.choose = NO;
            [_jiArray addObject:model];
        }
        PersonalTitleCollectionModel *model = _jiArray[0];
        model.choose = YES;
        
    }
    return _jiArray;
}
- (NSMutableArray *)ziArray {
    if (!_ziArray) {
        _ziArray = @[].mutableCopy;

        NSArray *titleArray = @[@"儒家",@"道家",@"法家",@"名家",@"墨家"];
        
        for (NSString *title in titleArray) {
            PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
            model.title = title;
            model.choose = NO;
            [_ziArray addObject:model];
        }
        PersonalTitleCollectionModel *model = _ziArray[0];
        model.choose = YES;
        
    }
    return _ziArray;
}
- (NSMutableArray *)shiArray {
    if (!_shiArray) {
        _shiArray = @[].mutableCopy;

        NSArray *titleArray = @[@"上古",@"中古",@"近古",@"近现代"];
        
        for (NSString *title in titleArray) {
            PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
            model.title = title;
            model.choose = NO;
            [_shiArray addObject:model];
        }
        PersonalTitleCollectionModel *model = _shiArray[0];
        model.choose = YES;
        
    }
    return _shiArray;
}
- (NSMutableArray *)jingArray {
    if (!_jingArray) {
        _jingArray = @[].mutableCopy;
        NSArray *titleArray = @[@"易经",@"尚书",@"诗经",@"礼",@"乐",@"春秋",@"孝经",@"论语"];
        
        for (NSString *title in titleArray) {
            PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
            model.title = title;
            model.choose = NO;
            [_jingArray addObject:model];
        }
        PersonalTitleCollectionModel *model = _jingArray[0];
        model.choose = YES;
        
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
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self configCollectionView];
    [self reloadCollectionView];
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
    

    
}
#pragma mark --UICollectionDelegate/DataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 0) {
        
        return CGSizeMake((MainScreenWidth - 0 * 3) * 0.25, 141);
    }
//    return CGSizeMake(100, 35);
    PersonalTitleCollectionModel *model = [self getCurrentSubModelWithIndexPath:indexPath];

    return CGSizeMake(40 * model.title.length, 35);
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
    
    PersonalTitleCollectionModel *model = [self getCurrentArrayWithIndex:currentClick][indexPath.row];
    return model;
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
                model.choose = YES;
            } else {
                model.choose = NO;
            }
        }
        [self reloadCollectionView];
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
   [self.itemCollectionView reloadData];
    
}
- (void)reloadCollectionView {
     [self.topCollectionView reloadData];
    [self.itemCollectionView reloadData];
   
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"热门课堂";
        cell.moreTitleLabel.hidden = YES;
        return cell;
    }
    YiDaoKeTangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
   
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//     [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 54;
    }
     return 273;
}
@end
