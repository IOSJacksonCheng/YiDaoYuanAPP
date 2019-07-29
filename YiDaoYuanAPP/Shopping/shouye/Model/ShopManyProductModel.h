//
//  ShopManyProductModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/12.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopManyProductModel : NSObject
@property (nonatomic, strong) NSString *goods_id;

@property (nonatomic, strong) NSString *goods_name;


@property (nonatomic, strong) NSString *img;


@property (nonatomic, strong) NSString *intro;


@property (nonatomic, strong) NSString *sell_price;


@property (nonatomic, assign) BOOL newspro;


@property (nonatomic, assign) BOOL best;

@end

NS_ASSUME_NONNULL_END
