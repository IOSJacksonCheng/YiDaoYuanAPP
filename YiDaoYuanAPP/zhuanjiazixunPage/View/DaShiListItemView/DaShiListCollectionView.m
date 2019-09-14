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
@property (nonatomic, strong) NSIndexPath *recordIndex;

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
  
//    DaShiListItemModel *model = [DaShiListItemModel new];
//
//    if (indexPath.section == 0) {
//
//        model = self.shengxiaoArray[indexPath.row];
//
//    } else if (indexPath.section == 1) {
//
//        model = self.mingLiArray[indexPath.row];
//
//    }else if (indexPath.section == 2) {
//
//        model = self.qitaArray[indexPath.row];
//
//
//
//    }
//
//    float wordWidth = 48;
//
//    if (model.title.length == 2) {
//        wordWidth = 30;
//
//    }else if (model.title.length == 3) {
//        wordWidth = 15;
//    }else if (model.title.length >= 4) {
//        wordWidth = 14;
//
//    }
//    return CGSizeMake(wordWidth * model.title.length, 26);
    return CGSizeMake(56, 26);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
    //    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 3;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 3;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 12;
    }
    if (section == 1) {
        return self.mingLiArray.count;
    }
    return self.qitaArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell) forIndexPath:indexPath];
    if (indexPath.section == 0) {
        DaShiListItemModel *model = self.shengxiaoArray[indexPath.row];
        cell.model = model;

    } else if (indexPath.section == 1) {
        DaShiListItemModel *model = self.mingLiArray[indexPath.row];
        cell.model = model;
        

    }else if (indexPath.section == 2) {
        DaShiListItemModel *model = self.qitaArray[indexPath.row];
        cell.model = model;
        

    }
    
    
    
    
    
    return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(200, 45);
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CSCellName(DaShiItemCollectionReusableView) forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"选择您的生肖" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        headerView.itemTitleLabel.attributedText = string;

    } else if (indexPath.section == 1) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"命理（须知准确出生时辰）" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]} range:NSMakeRange(2, 10)];
       
        
        headerView.itemTitleLabel.attributedText = string;

    } else if (indexPath.section == 2) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"占卜类&其他（无需准确出生时辰）" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 16],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        
        [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 12], NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]} range:NSMakeRange(6, 10)];
        headerView.itemTitleLabel.attributedText = string;

    }
    
    
    return headerView;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        DaShiListItemModel *newmodel = self.shengxiaoArray[indexPath.row];
       
        newmodel.choose =  !newmodel.choose;
        
        if (self.recordIndex) {
            DaShiListItemModel *model = self.shengxiaoArray[self.recordIndex.row];
            model.choose = NO;
        }
        
        self.recordIndex = indexPath;
        
        
    } else if (indexPath.section == 1) {
        DaShiListItemModel *model = self.mingLiArray[indexPath.row];
        model.choose = !model.choose;
        
    }else if (indexPath.section == 2) {
        DaShiListItemModel *model = self.qitaArray[indexPath.row];
        model.choose = !model.choose;

        
    }
    
    
    
    
    [self reloadData];
    
}
- (void)setMingLiArray:(NSMutableArray *)mingLiArray {
    _mingLiArray = mingLiArray;
    [self reloadData];
}
- (void)setQitaArray:(NSMutableArray *)qitaArray {
    _qitaArray = qitaArray;
    [self reloadData];
}
- (void)refreshView {
    [self reloadData];

}
@end
