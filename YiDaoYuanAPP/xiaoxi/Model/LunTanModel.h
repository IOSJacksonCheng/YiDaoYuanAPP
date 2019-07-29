//
//  LunTanModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LunTanModel : NSObject
@property (nonatomic, strong) NSString *forum_id;
@property (nonatomic, strong) NSString *topic;

@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *topic_img;

@end

NS_ASSUME_NONNULL_END
