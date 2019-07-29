//
//  DaShiListItemView.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DaShiListItemViewDelegate <NSObject>

- (void)clickCloseViewDone;
- (void)clickSureButton;
@end

NS_ASSUME_NONNULL_BEGIN

@interface DaShiListItemView : UIView

@property (nonatomic, strong) NSMutableArray *mingLiArray;
@property (nonatomic, strong) NSMutableArray *qitaArray;
@property (nonatomic, weak) id<DaShiListItemViewDelegate> csDelegate;
@property (nonatomic, strong) NSMutableArray *shengxiaoArray;
@end

NS_ASSUME_NONNULL_END
