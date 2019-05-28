//
//  DaShiListItemModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DaShiListItemModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, getter=isChoose) BOOL choose;
@property (nonatomic, strong) NSMutableArray *subArray;
@end

NS_ASSUME_NONNULL_END
