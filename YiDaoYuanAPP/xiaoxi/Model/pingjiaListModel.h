//
//  pingjiaListModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface pingjiaListModel : NSObject
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatar;

@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSString *comment_content;

@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *comment_id;
@property (nonatomic, strong) NSMutableArray *review;



@end

NS_ASSUME_NONNULL_END
