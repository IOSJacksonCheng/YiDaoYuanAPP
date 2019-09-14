//
//  DaShiFirstPageModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DaShiFirstPageModel : NSObject
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *master_name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, assign) BOOL is_auth;
@property (nonatomic, strong) NSMutableArray *skille;

@property (nonatomic, strong) NSString *level_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *master;

@end

NS_ASSUME_NONNULL_END
