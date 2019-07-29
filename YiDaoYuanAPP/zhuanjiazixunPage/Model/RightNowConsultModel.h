//
//  RightNowConsultModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RightNowConsultModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *cat_id;
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) BOOL choose;

@property (nonatomic, strong) NSString *item_id;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *ad;
@property (nonatomic, strong) NSString *explain;
@property (nonatomic, strong) NSString *intro;
@end

NS_ASSUME_NONNULL_END
