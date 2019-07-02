//
//  FuGouBangModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FuGouBangModel : NSObject
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *order_num;
@property (nonatomic, strong) NSString *keep_num;
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, assign) BOOL is_auth;
@property (nonatomic, strong) NSMutableArray *skille;

@end

NS_ASSUME_NONNULL_END
