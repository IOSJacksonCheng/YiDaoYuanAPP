//
//  ManyItemTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ManyItemTableViewCell.h"

#import "ManyItemCollectionViewCell.h"
#import "FirstPageManyItemModel.h"

@interface ManyItemTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end
@implementation ManyItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((MainScreenWidth - 18 * 2) * 0.2, 71);
    //创建UICollectionView
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.scrollEnabled = NO;
    //设置位置和尺寸
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell的ID
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(ManyItemCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(ManyItemCollectionViewCell)];
   
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
   
    return UIEdgeInsetsMake(0, 18, 0, 18);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    ManyItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(ManyItemCollectionViewCell) forIndexPath:indexPath];
    
    FirstPageManyItemModel *model = self.listArray[indexPath.row];
   
    [cell.csImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];

    cell.csTitleLabel.text = model.title;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstPageManyItemModel *model = self.listArray[indexPath.row];

    if ([model.item_id isEqualToString:@"-1"]) {
         [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"IndustryNewsViewController" sender:self];
        
    } else if ([model.item_id isEqualToString:@"-2"]) {
        
    } else {
        [self.csDelegate passItemId:model];
         [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"DaShiListViewController" sender:nil];
    }
    
}
- (void)setListArray:(NSMutableArray *)listArray {
    _listArray = listArray;
    [self.collectionView reloadData];
}
@end
