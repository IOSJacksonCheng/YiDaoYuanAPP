//
//  TiXianDetailViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TiXianDetailViewControllerDelegate <NSObject>

- (void)passname:(NSString *)name WithOrder:(NSString *)order;

@end
@interface TiXianDetailViewController : BaseViewController
@property (nonatomic, weak) id<TiXianDetailViewControllerDelegate> simpleDelegate;
@end

NS_ASSUME_NONNULL_END
