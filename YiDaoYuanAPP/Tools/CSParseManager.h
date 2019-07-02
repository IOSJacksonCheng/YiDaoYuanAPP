//
//  CSParseManager.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSParseManager : NSObject
+ (NSMutableArray *)getAreaModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getMyCollectModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getDaShiListItemModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getConsultModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getUserPingLunFirstPageModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getDaShiFirstPageModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getIndustryNewsModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getFuGouBangModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getYiDaoYuanCollectionModelArrayWithResponseObject:(id)result;
@end

NS_ASSUME_NONNULL_END
