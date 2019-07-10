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
+ (NSMutableArray *)getQiFUModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getPersonalTitleCollectionModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getYiDaoKeTangModelArrayWithResponseObject:(id)result;

+ (NSMutableArray *)getYiDaoKeTangJudgeModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getGongPingModelArrayWithResponseObject:(id)result;

+ (NSMutableArray *)getFoAndShenXianModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getQuickWishModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getQiYuanJiLuModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getGongPingDetailArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getDengModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getDengPriceModelArrayWithResponseObject:(id)result;
@end

NS_ASSUME_NONNULL_END
