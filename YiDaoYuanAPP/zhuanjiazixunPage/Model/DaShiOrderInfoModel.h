//
//  DaShiOrderInfoModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DaShiOrderInfoModel : NSObject
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *ctime;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *discounts;

@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *master_name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *item_title;

@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *last_login_time;
@property (nonatomic, strong) NSString *user_avatar;
@property (nonatomic, strong) NSString *issue;
@property (nonatomic, strong) NSMutableArray *skille;

@property (nonatomic, strong) NSString *birthday;

@property (nonatomic, strong) NSString *sex;

@property (nonatomic, strong) NSString *statusTitle;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *user_nickname;
@property (nonatomic, assign) BOOL haveJudged;

@end

NS_ASSUME_NONNULL_END
