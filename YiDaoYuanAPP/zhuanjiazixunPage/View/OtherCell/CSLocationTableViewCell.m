//
//  CSLocationTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSLocationTableViewCell.h"
#import "CSLocationCollectionViewCell.h"

@interface CSLocationTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end
@implementation CSLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(CSLocationCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(CSLocationCollectionViewCell)];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CSAreaModel *model = self.itemMutableArray[indexPath.row];
    
    float wordWidth = 20;

    return CGSizeMake(wordWidth * model.name.length, 26);
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
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
    
    CSLocationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(CSLocationCollectionViewCell) forIndexPath:indexPath];
    
    CSAreaModel *model = self.itemMutableArray[indexPath.row];
    
    cell.csTitleLabel.text = model.name;
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
   CSAreaModel *model = self.itemMutableArray[indexPath.row];
    
    [self.csDelegate GetLocationModel:model];
    
    
    
}
- (void)setItemMutableArray:(NSMutableArray *)itemMutableArray {
    _itemMutableArray = itemMutableArray;
    
    [self.collectionView reloadData];
    
}

@end
