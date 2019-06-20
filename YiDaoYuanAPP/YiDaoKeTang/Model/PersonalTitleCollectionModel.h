//
//  PersonalTitleCollectionModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/18.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalTitleCollectionModel : NSObject
@property (nonatomic, assign) BOOL choose;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageString;
@end

NS_ASSUME_NONNULL_END
