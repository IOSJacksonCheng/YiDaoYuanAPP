//
//  JudgeModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/5.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JudgeModel : NSObject
@property (nonatomic, strong) NSString *evaluate_id;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) JudgeModel *reply;

@end

NS_ASSUME_NONNULL_END
