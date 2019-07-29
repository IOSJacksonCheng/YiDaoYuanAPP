//
//  ManyDaShiModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManyDaShiModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *speciality;
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *avatar;


@property (nonatomic, strong) NSString *order_num;


@property (nonatomic, strong) NSMutableArray *skille;
@property (nonatomic, strong) NSString *keep_num;
@property (nonatomic, assign) BOOL is_new;
@property (nonatomic, assign) BOOL is_auth;

@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *avg_return;

@property (nonatomic, strong) NSString *detailed;

@property (nonatomic, strong) NSString *user_name;

@end

NS_ASSUME_NONNULL_END
