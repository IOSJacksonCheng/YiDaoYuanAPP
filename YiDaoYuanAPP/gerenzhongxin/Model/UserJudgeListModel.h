//
//  UserJudgeListModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserJudgeListModel : NSObject
@property (nonatomic, strong) NSString *evaluation_id;

@property (nonatomic, strong) NSString *master_id;

@property (nonatomic, strong) NSString *master_name;


@property (nonatomic, strong) NSString *grade;


@property (nonatomic, strong) NSString *avatar;


@property (nonatomic, strong) NSString *content;


@property (nonatomic, strong) NSString *order_id;


@property (nonatomic, strong) NSString *type;


@property (nonatomic, strong) NSMutableArray *skille;


@end

NS_ASSUME_NONNULL_END
