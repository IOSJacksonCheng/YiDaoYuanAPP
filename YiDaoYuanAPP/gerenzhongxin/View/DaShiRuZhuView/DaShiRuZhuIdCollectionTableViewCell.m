//
//  DaShiRuZhuIdCollectionTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuIdCollectionTableViewCell.h"
#import "DaShiItemCollectionViewCell.h"
@interface DaShiRuZhuIdCollectionTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
@implementation DaShiRuZhuIdCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(DaShiItemCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell)];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;}

#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.row];
    
    float wordWidth = 70;
    
    if (model.title.length == 4) {
        wordWidth = 80;
    }
    
    return CGSizeMake(wordWidth, 26);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    //    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.itemMutableArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell) forIndexPath:indexPath];
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.row];
 
    cell.model = model;
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.row];
    
   
    
    
    
    model.choose = !model.choose;
    
    
    
    
    [self.collectionView reloadData];
    
}
- (void)setItemMutableArray:(NSMutableArray *)itemMutableArray {
    _itemMutableArray = itemMutableArray;
    
    [self.collectionView reloadData];
    
}

@end
