//
//  XiaoXiModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XiaoXiModel : NSObject
@property (nonatomic, strong) NSString *user_nickname;
@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *msg_id;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *ctime;

@property (nonatomic, assign) BOOL status;

@end

NS_ASSUME_NONNULL_END
