//
//  YiDaoYuanCollectionModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YiDaoYuanCollectionModel : NSObject
@property (nonatomic, assign) BOOL choose;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *RMB;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, assign) BOOL showSales;
@property (nonatomic, strong) NSString *ctime;
@end

NS_ASSUME_NONNULL_END
