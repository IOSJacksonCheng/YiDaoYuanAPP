//
//  CSParseManager.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class FirstPageModel;
@class ManyDaShiModel;
@class DaShiOrderInfoModel;
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
+ (NSMutableArray *)getGouWuCheModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getGoodsModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getAddressModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getHomePageADModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getCSProductItemModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getShopManyProductModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getShopDetailAttrModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getAllOrderModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getQuestionModelArrayWithResponseObject:(id)result ;
+ (NSMutableArray *)getWuLiuSubModelArrayWithResponseObject:(id)result ;
+ (NSMutableArray *)getAllSubOrderModelArrayWithResponseObject:(id)result;
+ (FirstPageModel *)getPunLunSingleModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getRightNowConsultModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getFirstPageManyItemModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getQuestionIdModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getChooseDaShiModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getDaShiListItemModelArrayWithResponseObject:(id)result WithQiTa:(BOOL)other;
+ (NSMutableArray *)getCollectDaShiListItemModelArrayWithResponseObject:(id)result;
+ (NSMutableArray *)getManyDaShiModellArrayWithResponseObject:(id)result;
+ (ManyDaShiModel *)getSingleManyDaShiModellWithResponseObject:(id)result;
+ (NSMutableArray *)getUserJudgeArrayArrayWithResponseObject:(id)result;
+ (DaShiOrderInfoModel *)getSingleDaShiOrderInfoModellWithResponseObject:(id)result;
+ (NSMutableArray *)getXiaoXiModellWithResponseObject:(id)result;
+ (NSMutableArray *)getLunTanModellWithResponseObject:(id)result;
+ (NSMutableArray *)getpingjiaListModelWithResponseObject:(id)result;
+ (NSMutableArray *)getMoneyHistoryModelWithResponseObject:(id)result;
+ (NSMutableArray *)getReplyDetailModelWithResponseObject:(id)result;
+ (NSMutableArray *)getUserJudgeListModelWithResponseObject:(id)result;
+ (NSMutableArray *)getCSChatModelWithResponseObject:(id)result;
@end

NS_ASSUME_NONNULL_END
