//
//  DengPriceModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/10.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DengPriceModel : NSObject
@property (nonatomic, strong) NSString *price_id;

@property (nonatomic, strong) NSString *day;


@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *start;

@property (nonatomic, strong) NSString *end;

@property (nonatomic, assign) BOOL choose;

@property (nonatomic, assign) BOOL recommend;
@end

NS_ASSUME_NONNULL_END
