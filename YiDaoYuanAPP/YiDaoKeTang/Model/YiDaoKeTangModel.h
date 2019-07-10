//
//  YiDaoKeTangModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YiDaoKeTangModel : NSObject
@property (nonatomic, strong) NSString *class_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *focus;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *master;
@property (nonatomic, strong) NSString *discount;

@property (nonatomic, strong) NSString *count;

@property (nonatomic, assign) BOOL is_apply;
@property (nonatomic, assign) BOOL is_hot;

@end

NS_ASSUME_NONNULL_END
