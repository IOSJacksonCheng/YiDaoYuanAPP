//
//  GongPingModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/8.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GongPingModel : NSObject
@property (nonatomic, strong) NSString *idString;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *start;

@property (nonatomic, assign) BOOL valid;

@property (nonatomic, strong) NSString *cat_id;
@property (nonatomic, strong) NSString *title;
/** 茶 = tea。flower：花、fruit：果、cake：糕点、buddha：香  */
@property (nonatomic, strong) NSString *ident;

@property (nonatomic, strong) NSString *tribute_id;
@property (nonatomic, strong) NSString *tribute_name;
@property (nonatomic, strong) NSString *tribute_icon;

@end

NS_ASSUME_NONNULL_END
