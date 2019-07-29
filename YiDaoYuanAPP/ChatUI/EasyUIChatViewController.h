//
//  EasyUIChatViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "EaseMessageViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EasyUIChatViewController : EaseMessageViewController
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avater;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, assign) BOOL isKefu;
@property (nonatomic, assign) BOOL isDaShi;
@end

NS_ASSUME_NONNULL_END
