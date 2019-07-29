//
//  DaShiListTypeView.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiListTypeView.h"
#import "DaShiItemTypeCollectionViewCell.h"
#import "DaShiListItemModel.h"
@interface DaShiListTypeView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end
@implementation DaShiListTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
      
        UIColor *backGroundColor = [UIColor colorWithHexString:@"000000"];
       
        self.backgroundColor = [backGroundColor colorWithAlphaComponent:0.7];
    
     
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        self.collectionView.backgroundColor = UIColor.clearColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(DaShiItemTypeCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(DaShiItemTypeCollectionViewCell)];
       
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:self.collectionView];
        
        
        
    }
    
    return self;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
    return CGSizeMake(MainScreenWidth * 0.25, 42);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
//    return UIEdgeInsetsMake(10, 15, 10, 15);
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
   
    return self.levelArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(DaShiItemTypeCollectionViewCell) forIndexPath:indexPath];
    DaShiListItemModel *model = self.levelArray[indexPath.row];
    
    
    cell.itemTitleLabel.text = model.title;
    
    
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
     DaShiListItemModel *model = self.levelArray[indexPath.row];
    [self.csDelegate passLevelModel:model];
    
    
    
    
}
- (void)setLevelArray:(NSMutableArray *)levelArray {
    _levelArray = levelArray;
    [self.collectionView reloadData];
}
@end
