//
//  DaShiListCollectionView.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VideoSearchCollectionViewDelegate <NSObject>

- (void)passNewItemArray:(NSMutableArray *)array;

@end
NS_ASSUME_NONNULL_BEGIN

@interface DaShiListCollectionView : UICollectionView
@property (nonatomic, strong) NSMutableArray *mingLiArray;
@property (nonatomic, strong) NSMutableArray *qitaArray;
@property (nonatomic, strong) NSMutableArray *shenxiaoArray;
@property (nonatomic, strong) NSMutableArray *shengxiaoArray;
@property (nonatomic, weak) id<VideoSearchCollectionViewDelegate> csDelegate;
- (void)refreshView;

@end

NS_ASSUME_NONNULL_END
