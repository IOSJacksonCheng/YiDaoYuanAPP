//
//  FirstPageDaShiTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FirstPageDaShiTableViewCell.h"

#import "FirstPageDaShiItemCollectionViewCell.h"

#import "FirstPageCollectionReusableView.h"

#import "DaShiFirstPageModel.h"

@interface FirstPageDaShiTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
@implementation FirstPageDaShiTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(FirstPageDaShiItemCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(FirstPageDaShiItemCollectionViewCell)];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(FirstPageCollectionReusableView) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(FirstPageCollectionReusableView)];
}

#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
  
    
    return CGSizeMake(MainScreenWidth * 0.333, 219);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
//    return UIEdgeInsetsMake(5, 5, 5, 5);
        return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemMutableArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    DaShiFirstPageModel *model = self.itemMutableArray[section];
    if (model.master.count > 3) {
        return 3;
    }
    return model.master.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstPageDaShiItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(FirstPageDaShiItemCollectionViewCell) forIndexPath:indexPath];
    
    DaShiFirstPageModel *model = self.itemMutableArray[indexPath.section];

  
    DaShiFirstPageModel *subModel = model.master[indexPath.row];

    cell.model = subModel;
    

    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 45);
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    FirstPageCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(FirstPageCollectionReusableView) forIndexPath:indexPath];
   
    DaShiFirstPageModel *model = self.itemMutableArray[indexPath.section];

    headerView.csTitleLabel.text = model.title;
    
    headerView.tag = indexPath.section;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadView:)];
    
    tap.numberOfTapsRequired = 1;
    
    tap.numberOfTouchesRequired = 1;
    
    [headerView addGestureRecognizer:tap];
    
    return headerView;
    
}
- (void)clickHeadView:(UITapGestureRecognizer *)gesture {
   
    UIView *view = gesture.view;
    
    NSInteger section = view.tag;
    
    DaShiFirstPageModel *model = self.itemMutableArray[section];

    [self.csDelegate passLevelId:model.level_id WithTitle:model.title];
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiFirstPageModel *model = self.itemMutableArray[indexPath.section];

    DaShiFirstPageModel *subModel = model.master[indexPath.row];

    [self.csDelegate passDaShiMasterId:subModel.master_id];
    
    
}

- (void)setItemMutableArray:(NSMutableArray *)itemMutableArray {
    _itemMutableArray = itemMutableArray;
    
    [self.collectionView reloadData];
    
}

@end
