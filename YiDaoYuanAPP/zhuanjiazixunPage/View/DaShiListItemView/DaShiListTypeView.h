//
//  DaShiListTypeView.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DaShiListItemModel;
NS_ASSUME_NONNULL_BEGIN
@protocol DaShiListTypeViewDelegate <NSObject>

- (void)passLevelModel:(DaShiListItemModel *)model;
@end
@interface DaShiListTypeView : UIView
@property (nonatomic, strong) NSMutableArray *levelArray;
@property (nonatomic, weak) id<DaShiListTypeViewDelegate> csDelegate;

@end

NS_ASSUME_NONNULL_END
