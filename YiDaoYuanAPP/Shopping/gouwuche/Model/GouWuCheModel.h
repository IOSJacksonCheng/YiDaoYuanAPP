//
//  GouWuCheModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/11.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GouWuCheModel : NSObject
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *quantity;
@property (nonatomic, strong) NSString *cart_id;
@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *i;
@property (nonatomic, strong) NSString *v;
@property (nonatomic, assign) BOOL choose;

@property (nonatomic, strong) NSString *willBuyNum;
@end

NS_ASSUME_NONNULL_END
