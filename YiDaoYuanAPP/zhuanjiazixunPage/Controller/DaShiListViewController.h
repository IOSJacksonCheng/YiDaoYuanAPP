//
//  DaShiListViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DaShiListViewController : BaseViewController
@property (nonatomic, strong) NSString *passId;
@property (nonatomic, strong) NSString *adImage;
@property (nonatomic, assign) BOOL noFee;
@property (nonatomic, strong) NSString *passIdTitle;

@property (nonatomic, strong) NSString *passLevel;
@property (nonatomic, strong) NSString *passLevelId;
@end

NS_ASSUME_NONNULL_END
