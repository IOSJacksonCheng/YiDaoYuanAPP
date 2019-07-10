//
//  QiFUModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiFuDianDengItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QiFUModel : NSObject
@property (nonatomic, strong) NSString *supplication_id;
@property (nonatomic, strong) NSString *buddha_name;
@property (nonatomic, strong) NSString *buddha_id;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *acc;
@property (nonatomic, strong) NSMutableArray *item;


@property (nonatomic, strong) QiFuDianDengItemModel *lampModel;
@end

NS_ASSUME_NONNULL_END
