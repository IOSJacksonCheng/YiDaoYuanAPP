//
//  UserJudgeArray.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserJudgeArray : NSObject
@property (nonatomic, strong) NSString *item_title;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *user_nickname;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) NSMutableArray *imgs;
@property (nonatomic, strong) NSString *avg;
@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
