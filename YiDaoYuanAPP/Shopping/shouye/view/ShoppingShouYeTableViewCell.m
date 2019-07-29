//
//  ShoppingShouYeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingShouYeTableViewCell.h"
#import "ShoppingShouYeCollectionViewCell.h"

#import "CSProductItemModel.h"
@interface ShoppingShouYeTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ShoppingShouYeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(ShoppingShouYeCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(ShoppingShouYeCollectionViewCell)];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
}

#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake(MainScreenWidth * 0.2, 98);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
        return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.itemMutableArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShoppingShouYeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(ShoppingShouYeCollectionViewCell) forIndexPath:indexPath];
    
    CSProductItemModel *model = self.itemMutableArray[indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    
    cell.csTitleLabel.text = model.class_name;
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    CSProductItemModel *model = self.itemMutableArray[indexPath.row];
    [self.csDelegate passID:model.idString];
    
}
- (void)setItemMutableArray:(NSMutableArray *)itemMutableArray {
    _itemMutableArray = itemMutableArray;
    
    [self.collectionView reloadData];
    
}


@end
