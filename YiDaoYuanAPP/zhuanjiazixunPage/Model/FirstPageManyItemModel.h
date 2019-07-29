//
//  FirstPageManyItemModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstPageManyItemModel : NSObject
@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, strong) NSString *cat_id;

@property (nonatomic, strong) NSString *intro;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, assign) BOOL choose;

@property (nonatomic, strong) NSString *ad;
@end

NS_ASSUME_NONNULL_END
