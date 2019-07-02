//
//  IndustryNewsModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndustryNewsModel : NSObject
@property (nonatomic, strong) NSString *news_id;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *excerpt;

@property (nonatomic, strong) NSString *ctime;

@property (nonatomic, strong) NSString *thumb;

@end

NS_ASSUME_NONNULL_END
