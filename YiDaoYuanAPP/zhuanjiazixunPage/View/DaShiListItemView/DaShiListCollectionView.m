//
//  DaShiListCollectionView.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiListCollectionView.h"
#import "DaShiItemCollectionViewCell.h"
#import "DaShiItemCollectionReusableView.h"

@interface DaShiListCollectionView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>


@end
@implementation DaShiListCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
      
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = UIColor.whiteColor;
        self.collectionViewLayout = layout;
        self.frame = frame;
        [self registerNib:[UINib nibWithNibName:CSCellName(DaShiItemCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell)];
        [self registerNib:[UINib nibWithNibName:CSCellName(DaShiItemCollectionReusableView) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(DaShiItemCollectionReusableView)];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}


#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    DaShiListItemModel *model = self.itemMutableArray[indexPath.section];
    DaShiListItemModel *subModel = model.subArray[indexPath.row];
    
    float wordWidth = 48;
    
    return CGSizeMake(wordWidth * subModel.title.length, 26);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
    //    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemMutableArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    DaShiListItemModel *model = self.itemMutableArray[section];
    
    return model.subArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell) forIndexPath:indexPath];
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.section];
    
    DaShiListItemModel *subModel = model.subArray[indexPath.row];
    
    cell.model = subModel;
    
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 45);
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(DaShiItemCollectionReusableView) forIndexPath:indexPath];
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.section];
    
    headerView.itemTitleLabel.text = model.title;
    
    return headerView;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.section];
    
    DaShiListItemModel *subModel = model.subArray[indexPath.row];
    
 
  
    subModel.choose = !subModel.choose;
    
    
    
    
    [self reloadData];
    
}
- (void)setItemMutableArray:(NSMutableArray *)itemMutableArray {
    _itemMutableArray = itemMutableArray;
    
   
    dispatch_async(dispatch_get_main_queue(), ^{
        DaShiListItemModel *new = [DaShiListItemModel new];
        new.title = @"选择您的生肖";
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 12; i ++) {
            DaShiListItemModel *model = [DaShiListItemModel new];
            model.title = @"虎";
            if (i == 0) {
                model.choose = YES;
            } else {
                model.choose = NO;
            }
            
            [array addObject:model];
        }
        
        new.subArray = array;
        
        NSMutableArray *supArray = [NSMutableArray array];
        
        [supArray addObject:new];
        
        [supArray addObject:new];
        
        [supArray addObject:new];
        
        self.itemMutableArray = supArray;
        
        [self reloadData];
    });
   
}

@end
