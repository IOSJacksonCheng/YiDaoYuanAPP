//
//  HomePageADModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/12.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePageADModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *descriptionString;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *goods_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *adimg;
@property (nonatomic, strong) NSString *intro;
@property (nonatomic, strong) NSString *sell_price;

@end

NS_ASSUME_NONNULL_END
