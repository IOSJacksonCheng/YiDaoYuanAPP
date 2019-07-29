//
//  ConsultModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConsultModel : NSObject
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSMutableArray *skille;
/** 代付款 进行中 已完成 退款 status*/
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *statusTitle;


@property (nonatomic, strong) NSString *user_nickname;

@property (nonatomic, strong) NSString *item_title;

@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *content;
@end

NS_ASSUME_NONNULL_END
