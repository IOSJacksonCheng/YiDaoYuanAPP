//
//  AllOrderModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllOrderModel : NSObject
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *total_price;
@property (nonatomic, strong) NSString *creat_time;
@property (nonatomic, strong) NSString *status;


@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *goods_img;
@property (nonatomic, strong) NSString *goods_price;
@property (nonatomic, strong) NSString *goods_attr_name;
@property (nonatomic, strong) NSString *goods_attr_value;
@property (nonatomic, strong) NSString *quantity;


@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSMutableArray *skille;
/** 代付款 进行中 已完成 退款 status*/
@property (nonatomic, strong) NSString *statusTitle;
@end

NS_ASSUME_NONNULL_END
