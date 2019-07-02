//
//  FirstPageModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageModel : NSObject
@property (nonatomic, strong) NSString *master_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *avatar;
/** 是否认证 0 否 1是*/
@property (nonatomic, strong) NSString *is_auth;
@property (nonatomic, strong) NSMutableArray *skille;



@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *ctime;

@end

NS_ASSUME_NONNULL_END
