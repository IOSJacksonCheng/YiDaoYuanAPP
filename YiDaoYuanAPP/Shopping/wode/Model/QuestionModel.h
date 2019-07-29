//
//  QuestionModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/16.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *create_time;
@property (nonatomic, assign) BOOL choose;
@end

NS_ASSUME_NONNULL_END
