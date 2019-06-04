//
//  ShengXiaoTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShengXiaoTableViewCell.h"
#import "ShengXiaoCollectionViewCell.h"

@interface ShengXiaoTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
@implementation ShengXiaoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(76, 105);
    //创建UICollectionView
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    //设置位置和尺寸
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell的ID
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(ShengXiaoCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(ShengXiaoCollectionViewCell)];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShengXiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(ShengXiaoCollectionViewCell) forIndexPath:indexPath];
    ShengXiaoModel *model = self.itemArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    for (ShengXiaoModel *model in self.itemArray) {
        model.choose = NO;
    }
    
    ShengXiaoModel *model = self.itemArray[indexPath.row];
    
    model.choose = YES;
    
    [self.collectionView reloadData];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}
- (void)setItemArray:(NSMutableArray *)itemArray {
    
    _itemArray = itemArray;
    
    [self.collectionView reloadData];
    
    
    
    
    
    
    
    
}

@end
