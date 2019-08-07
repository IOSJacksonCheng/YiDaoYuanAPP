//
//  CSChatModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSChatModel : NSObject
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *is_reply;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *ctime;

@property (nonatomic, strong) NSString *size;
@end

NS_ASSUME_NONNULL_END
