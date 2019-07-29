//
//  AddressModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/11.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject
@property (nonatomic, strong) NSString *shipp_id;

@property (nonatomic, strong) NSString *shipp_name;


@property (nonatomic, strong) NSString *shipp_phone;

@property (nonatomic, strong) NSString *shipp_address;

@property (nonatomic, assign) BOOL status;
@end

NS_ASSUME_NONNULL_END
