//
//  ChooseDaShiModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChooseDaShiModel : NSObject
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *speciality;

@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *order_num;
@property (nonatomic, assign) BOOL choose;
@end

NS_ASSUME_NONNULL_END
