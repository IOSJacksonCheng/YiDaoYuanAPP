//
//  YiDaoYuanCollectionTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoYuanCollectionTableViewCell.h"

#import "YiMoneyCollectionViewCell.h"
@interface YiDaoYuanCollectionTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>



@property (weak, nonatomic) IBOutlet UICollectionView *csCollectionView;

@end
@implementation YiDaoYuanCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.csCollectionView registerNib:[UINib nibWithNibName:CSCellName(YiMoneyCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(YiMoneyCollectionViewCell)];
    
    //创建UICollectionView
    
   
    self.csCollectionView.delegate = self;
    self.csCollectionView.dataSource = self;
    self.backgroundColor = UIColor.whiteColor;
    self.csCollectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.csCollectionView.showsHorizontalScrollIndicator = NO;
    self.csCollectionView.showsVerticalScrollIndicator = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {



    return CGSizeMake((MainScreenWidth - 10 * 4) * 0.3, 85);
//    return CGSizeMake(109, 70);

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(10, 15, 10, 15);
    //    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 10;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
   return self.titleArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YiMoneyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(YiMoneyCollectionViewCell) forIndexPath:indexPath];
    
    YiDaoYuanCollectionModel *model = self.titleArray[indexPath.row];
    
    
    
    cell.model = model;
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [self.csDelegate clickItemWithRow:indexPath.row];
    
}
- (void)setTitleArray:(NSMutableArray *)titleArray {
    _titleArray = titleArray;
    
    [self.csCollectionView reloadData];
}
@end
