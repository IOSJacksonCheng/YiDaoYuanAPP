//
//  TiXianViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TiXianViewControllerDelegate <NSObject>

- (void)successback;

@end
@interface TiXianViewController : BaseViewController
@property (nonatomic, weak) id<TiXianViewControllerDelegate> simpleDelegate;

@end

NS_ASSUME_NONNULL_END
