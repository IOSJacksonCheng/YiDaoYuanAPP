//
//  QuestionId.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QuestionId : NSObject
@property (nonatomic, strong) NSString *question_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL choose;
@property (nonatomic, assign) BOOL isTextField;
@property (nonatomic, assign) BOOL isEightRow;
@end

NS_ASSUME_NONNULL_END
