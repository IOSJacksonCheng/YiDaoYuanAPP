//
//  ManyProductCollectionViewFlowLayout.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/15.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ManyProductCollectionViewFlowLayout;
NS_ASSUME_NONNULL_BEGIN
@protocol ManyProductCollectionViewFlowLayoutDelegate <NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout;

@end
@interface ManyProductCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, weak) id<ManyProductCollectionViewFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
