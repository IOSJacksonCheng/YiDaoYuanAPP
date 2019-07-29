//
//  CSParseManager.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSParseManager.h"

#import "CSAreaModel.h"
#import "MoneyHistoryModel.h"


#import "MyCollectModel.h"
#import "DaShiListItemModel.h"
#import "ConsultModel.h"
#import "FirstPageModel.h"
#import "IndustryNewsModel.h"
#import "FuGouBangModel.h"
#import "YiDaoYuanCollectionModel.h"
#import "QiFUModel.h"
#import "PersonalTitleCollectionModel.h"

#import "YiDaoKeTangModel.h"
#import "JudgeModel.h"
#import "GongPingModel.h"
#import "FoAndShenXianModel.h"
#import "DaShiListItemModel.h"

#import "QiYuanJiLuModel.h"
#import "DengModel.h"

#import "DengPriceModel.h"
#import "GouWuCheModel.h"

#import "AddressModel.h"
#import "GoodsModel.h"
#import "HomePageADModel.h"
#import "CSProductItemModel.h"
#import "ShopManyProductModel.h"
#import "AllOrderModel.h"
#import "QuestionModel.h"

#import "WuLiuSubModel.h"
#import "RightNowConsultModel.h"
#import "FirstPageManyItemModel.h"

#import "QuestionId.h"
#import "ChooseDaShiModel.h"
#import "DaShiListItemModel.h"

#import "ManyDaShiModel.h"
#import "UserJudgeArray.h"
#import "DaShiOrderInfoModel.h"
#import "XiaoXiModel.h"
#import "LunTanModel.h"
#import "pingjiaListModel.h"

#import "ReplyDetailModel.h"

@implementation CSParseManager
+ (NSMutableArray *)getReplyDetailModelWithResponseObject:(id)result{
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        ReplyDetailModel *model = [ReplyDetailModel new];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        
        model.content = [self handleStringIsNull:array[i][@"content"]];
        
        
        NSNumber *status = array[i][@"is_reply"];
        
        if ([status isEqualToNumber:@1]) {
            model.is_reply = YES;
            if (CS_UserIsMaster) {
                model.content = [NSString stringWithFormat:@"我的回复：%@",model.content];

            } else {
                model.content = [NSString stringWithFormat:@"大师回复：%@",model.content];

            }
        } else {
            model.is_reply = NO;
            if (CS_UserIsMaster) {
                model.content = [NSString stringWithFormat:@"用户回复：%@",model.content];
                
            } else {
                model.content = [NSString stringWithFormat:@"我的回复：%@",model.content];
                
            }
           

        }
        
        
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
    
    
    
    
}
+ (NSMutableArray *)getMoneyHistoryModelWithResponseObject:(id)result{
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        MoneyHistoryModel *model = [MoneyHistoryModel new];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        
        model.price = [self handleStringIsNull:array[i][@"price"]];
        
        
        model.money = [self handleStringIsNull:array[i][@"money"]];
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        
        
       
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
    
    
    
    
}
+ (NSMutableArray *)getpingjiaListModelWithResponseObject:(id)result{
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        pingjiaListModel *model = [pingjiaListModel new];
        model.nickname = [self handleStringIsNull:array[i][@"nickname"]];
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        
        
        model.user_id = [self handleStringIsNull:array[i][@"user_id"]];
        
        model.comment_content = [self handleStringIsNull:array[i][@"comment_content"]];
        
        
        model.create_time = [self handleStringIsNull:array[i][@"create_time"]];
        model.comment_id = [self handleStringIsNull:array[i][@"comment_id"]];

        
        model.review = [[self alloc] getpingjiaListModelWithResponseObject:array[i][@"review"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
    
    
    
    
}
- (NSMutableArray *)getpingjiaListModelWithResponseObject:(id)result{
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        pingjiaListModel *model = [pingjiaListModel new];
        model.nickname = [self handleStringIsNull:array[i][@"nickname"]];
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        
        
        model.user_id = [self handleStringIsNull:array[i][@"user_id"]];
        
        model.comment_content = [self handleStringIsNull:array[i][@"comment_content"]];
        
        
        model.create_time = [self handleStringIsNull:array[i][@"create_time"]];
        
        
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
    
    
    
    
}
+ (NSMutableArray *)getLunTanModellWithResponseObject:(id)result{
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        LunTanModel *model = [LunTanModel new];
        model.forum_id = [self handleStringIsNull:array[i][@"forum_id"]];
        
        model.topic = [self handleStringIsNull:array[i][@"topic"]];
        
        
        model.create_time = [self handleStringIsNull:array[i][@"create_time"]];
        
        model.content = [self handleStringIsNull:array[i][@"content"]];
        
        
        model.topic_img = [self handleStringIsNull:array[i][@"topic_img"]];
        
       
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
    
    
    
    
}
+ (NSMutableArray *)getXiaoXiModellWithResponseObject:(id)result{
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        XiaoXiModel *model = [XiaoXiModel new];
        model.user_nickname = [self handleStringIsNull:array[i][@"user_nickname"]];
        
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        
        model.msg_id = [self handleStringIsNull:array[i][@"msg_id"]];
        
        
        model.content = [self handleStringIsNull:array[i][@"content"]];
        
        NSNumber *status = array[i][@"status"];
        
        if ([status isEqualToNumber:@1]) {
            model.status = YES;
        } else {
            model.status = NO;
        }
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
   
    
    
   
}
+ (DaShiOrderInfoModel *)getSingleDaShiOrderInfoModellWithResponseObject:(id)result{
    
    if (![result isKindOfClass:[NSDictionary class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    
    
    DaShiOrderInfoModel *model = [DaShiOrderInfoModel new];
    model.statusTitle = [self handleStringIsNull:result[@"statusTitle"]];

    model.user_nickname = [self handleStringIsNull:result[@"user_nickname"]];
    model.name = [self handleStringIsNull:result[@"name"]];
    
    model.birthday = [self handleStringIsNull:result[@"birthday"]];
    
    
    model.sex = [self handleStringIsNull:result[@"sex"]];
    
    model.user_name = [self handleStringIsNull:result[@"user_name"]];
    
    model.user_id = [self handleStringIsNull:result[@"user_id"]];
    
    
    model.last_login_time = [self handleStringIsNull:result[@"last_login_time"]];
    
    model.user_avatar = [self handleStringIsNull:result[@"user_avatar"]];
    
    
    model.issue = [self handleStringIsNull:result[@"issue"]];
   
    model.order_id = [self handleStringIsNull:result[@"order_id"]];
    
    model.ctime = [self handleStringIsNull:result[@"ctime"]];
    
    
    model.price = [self handleStringIsNull:result[@"price"]];
    if (csCharacterIsBlank(model.price)) {
        model.price = [self handleStringIsNull:result[@"money"]];
    }
    model.discounts = [self handleStringIsNull:result[@"discounts"]];
    
    
    model.master_id = [self handleStringIsNull:result[@"master_id"]];
    
    model.skille = result[@"skille"];
    model.master_name = [self handleStringIsNull:result[@"master_name"]];
    
    model.avatar = [self handleStringIsNull:result[@"avatar"]];
    if (csCharacterIsBlank(model.avatar)) {
        model.avatar = [self handleStringIsNull:result[@"master_avatar"]];
    }
    model.item_title = [self handleStringIsNull:result[@"item_title"]];
    if (csCharacterIsBlank(model.item_title)) {
        model.item_title = [self handleStringIsNull:result[@"creategory"]];
    }
    NSNumber *status = result[@"is_evaluation"];
    
    if ([status isEqualToNumber:@1]) {
        model.haveJudged = YES;
    } else {
        model.haveJudged = NO;
    }
    
    return model;
}
+ (NSMutableArray *)getUserJudgeArrayArrayWithResponseObject:(id)result{
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        UserJudgeArray *model = [UserJudgeArray new];
        
        model.item_title = [self handleStringIsNull:array[i][@"item_title"]];
        
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        
        model.user_id = [self handleStringIsNull:array[i][@"user_id"]];
        
        
        model.user_nickname = [self handleStringIsNull:array[i][@"user_nickname"]];
        
        
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        
        model.tags = array[i][@"tags"];
        model.imgs = array[i][@"imgs"];
        model.avg = [self handleStringIsNull:array[i][@"avg"]];
        
        
        model.content = [self handleStringIsNull:array[i][@"content"]];
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (ManyDaShiModel *)getSingleManyDaShiModellWithResponseObject:(id)result{
    
    if (![result isKindOfClass:[NSDictionary class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    
        
        ManyDaShiModel *model = [ManyDaShiModel new];
        model.detailed = [self handleStringIsNull:result[@"detailed"]];
    
    model.master_id = [self handleStringIsNull:result[@"master_id"]];
        
        
        model.name = [self handleStringIsNull:result[@"name"]];
        
        model.speciality = [self handleStringIsNull:result[@"speciality"]];
        
        
        model.grade = [self handleStringIsNull:result[@"grade"]];
        
        
        model.avatar = [self handleStringIsNull:result[@"avatar"]];
        
        model.price = [self handleStringIsNull:result[@"price"]];
        model.order_num = [self handleStringIsNull:result[@"order_num"]];
        
        
        model.level = [self handleStringIsNull:result[@"level"]];
    
   
        model.avg_return = [self handleStringIsNull:result[@"avg_return"]];
        
        
        model.keep_num = [self handleStringIsNull:result[@"keep_num"]];
        
        NSNumber *status = result[@"is_new"];
        
        if ([status isEqualToNumber:@1]) {
            model.is_new = YES;
        } else {
            model.is_new = NO;
        }
        status = result[@"is_auth"];
        if ([status isEqualToNumber:@1]) {
            model.is_auth = YES;
        } else {
            model.is_auth = NO;
        }
        model.skille = result[@"skille"];
    return model;
}
+ (NSMutableArray *)getManyDaShiModellArrayWithResponseObject:(id)result{
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        ManyDaShiModel *model = [ManyDaShiModel new];
        
        model.master_id = [self handleStringIsNull:array[i][@"master_id"]];
        
        
        model.name = [self handleStringIsNull:array[i][@"name"]];
        
         model.speciality = [self handleStringIsNull:array[i][@"speciality"]];
        
        
        model.grade = [self handleStringIsNull:array[i][@"grade"]];
        
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        
        model.price = [self handleStringIsNull:array[i][@"price"]];
        model.order_num = [self handleStringIsNull:array[i][@"order_num"]];
        
        
        model.level = [self handleStringIsNull:array[i][@"level"]];
        
        model.avg_return = [self handleStringIsNull:array[i][@"avg_return"]];
        
        
        model.keep_num = [self handleStringIsNull:array[i][@"keep_num"]];
        
        NSNumber *status = array[i][@"is_new"];
        
        if ([status isEqualToNumber:@1]) {
            model.is_new = YES;
        } else {
            model.is_new = NO;
        }
        status = array[i][@"is_auth"];
        if ([status isEqualToNumber:@1]) {
            model.is_auth = YES;
        } else {
            model.is_auth = NO;
        }
        model.skille = array[i][@"skille"];
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getCollectDaShiListItemModelArrayWithResponseObject:(id)result{
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DaShiListItemModel *model = [DaShiListItemModel new];
       
            model.idString = [self handleStringIsNull:array[i][@"level_id"]];
        
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        
        
        model.choose = NO;
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getDaShiListItemModelArrayWithResponseObject:(id)result WithQiTa:(BOOL)other{
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DaShiListItemModel *model = [DaShiListItemModel new];
        if (other) {
             model.idString = [self handleStringIsNull:array[i][@"skilled_id"]];
        } else {
             model.idString = [self handleStringIsNull:array[i][@"numerology_id"]];
        }
       
        model.title = [self handleStringIsNull:array[i][@"title"]];
        
        
        model.choose = NO;
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getChooseDaShiModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        ChooseDaShiModel *model = [ChooseDaShiModel new];
        
        model.master_id = [self handleStringIsNull:array[i][@"master_id"]];
        model.name = [self handleStringIsNull:array[i][@"name"]];
        model.speciality = [self handleStringIsNull:array[i][@"speciality"]];
         model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
         model.price = [self handleStringIsNull:array[i][@"price"]];
        model.order_num = [self handleStringIsNull:array[i][@"order_num"]];

        model.choose = NO;
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getQuestionIdModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        QuestionId *model = [QuestionId new];
        
        model.question_id = [self handleStringIsNull:array[i][@"question_id"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.isEightRow = NO;
        model.choose = NO;
        model.isTextField = NO;
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getFirstPageManyItemModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        FirstPageManyItemModel *model = [FirstPageManyItemModel new];
        
        model.item_id = [self handleStringIsNull:array[i][@"item_id"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.icon = [self handleStringIsNull:array[i][@"icon"]];
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
        model.cat_id = [self handleStringIsNull:array[i][@"cat_id"]];

        model.price = [self handleStringIsNull:array[i][@"price"]];
        model.ad = [self handleStringIsNull:array[i][@"ad"]];

        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getRightNowConsultModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        RightNowConsultModel *model = [RightNowConsultModel new];
        
        model.cat_id = [self handleStringIsNull:array[i][@"cat_id"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
         model.items = [[self alloc] getRightNowConsultModelArrayWithResponseObject:array[i][@"items"]];
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
- (NSMutableArray *)getRightNowConsultModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        RightNowConsultModel *model = [RightNowConsultModel new];
        
        model.item_id = [self handleStringIsNull:array[i][@"item_id"]];
        model.subTitle = [self handleStringIsNull:array[i][@"title"]];
model.icon = [self handleStringIsNull:array[i][@"icon"]];
        model.ad = [self handleStringIsNull:array[i][@"ad"]];
        model.explain = [self handleStringIsNull:array[i][@"explain"]];
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getWuLiuSubModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        WuLiuSubModel *model = [WuLiuSubModel new];
        
        model.time = [self handleStringIsNull:array[i][@"time"]];
        model.context = [self handleStringIsNull:array[i][@"context"]];
        
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getQuestionModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        QuestionModel *model = [QuestionModel new];
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.content = [self handleStringIsNull:array[i][@"content"]];
        model.create_time = [self handleStringIsNull:array[i][@"v"]];
        
       
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getAllOrderModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        AllOrderModel *model = [AllOrderModel new];
        
        model.order_id = [self handleStringIsNull:array[i][@"order_id"]];
        model.total_price = [self handleStringIsNull:array[i][@"total_price"]];
        model.creat_time = [self handleStringIsNull:array[i][@"creat_time"]];
        
       
        model.status = [self handleStringIsNull:array[i][@"status"]];
        model.goods = [[self alloc] getAllOrderModelArrayWithResponseObject:array[i][@"goods"]];
       
       
       
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getAllSubOrderModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        AllOrderModel *model = [AllOrderModel new];
        
        
        
        model.goods_id = [self handleStringIsNull:array[i][@"goods_id"]];
        model.goods_name = [self handleStringIsNull:array[i][@"goods_name"]];
        model.goods_img = [self handleStringIsNull:array[i][@"goods_img"]];
        model.goods_price = [self handleStringIsNull:array[i][@"goods_price"]];
        model.quantity = [self handleStringIsNull:array[i][@"quantity"]];
        
        model.goods_attr_name = [self handleStringIsNull:array[i][@"goods_attr_name"]];
        model.goods_attr_value = [self handleStringIsNull:array[i][@"goods_attr_value"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
- (NSMutableArray *)getAllOrderModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        AllOrderModel *model = [AllOrderModel new];
        
        
      
        model.goods_id = [self handleStringIsNull:array[i][@"goods_id"]];
        model.goods_name = [self handleStringIsNull:array[i][@"goods_name"]];
        model.goods_img = [self handleStringIsNull:array[i][@"goods_img"]];
        model.goods_price = [self handleStringIsNull:array[i][@"goods_price"]];
        model.quantity = [self handleStringIsNull:array[i][@"quantity"]];
        
        model.goods_attr_name = [self handleStringIsNull:array[i][@"goods_attr_name"]];
        model.goods_attr_value = [self handleStringIsNull:array[i][@"goods_attr_value"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getShopDetailAttrModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DaShiListItemModel *model = [DaShiListItemModel new];
        
        model.i = [self handleStringIsNull:array[i][@"i"]];
        model.v = [self handleStringIsNull:array[i][@"v"]];
        model.k = [self handleStringIsNull:array[i][@"k"]];
        
        model.choose = NO;
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getShopManyProductModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        ShopManyProductModel *model = [ShopManyProductModel new];
        
        model.goods_id = [self handleStringIsNull:array[i][@"goods_id"]];
        model.goods_name = [self handleStringIsNull:array[i][@"goods_name"]];
        model.img = [self handleStringIsNull:array[i][@"img"]];
        
        model.sell_price = [self handleStringIsNull:array[i][@"sell_price"]];
        
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
        NSNumber *status = array[i][@"newspro"];
        
        if ([status isEqualToNumber:@1]) {
            model.newspro = YES;
        } else {
            model.newspro = NO;
        }
        NSNumber *best = array[i][@"newspro"];
        
        if ([best isEqualToNumber:@1]) {
            model.newspro = YES;
        } else {
            model.newspro = NO;
        }
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getCSProductItemModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        CSProductItemModel *model = [CSProductItemModel new];
        
        model.idString = [self handleStringIsNull:array[i][@"id"]];
        model.class_name = [self handleStringIsNull:array[i][@"class_name"]];
        model.sort = [self handleStringIsNull:array[i][@"sort"]];
        
        model.img = [self handleStringIsNull:array[i][@"img"]];
    
        
       
        
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
    
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getHomePageADModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        HomePageADModel *model = [HomePageADModel new];
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.image = [self handleStringIsNull:array[i][@"image"]];
        model.url = [self handleStringIsNull:array[i][@"url"]];
        
        model.descriptionString = [self handleStringIsNull:array[i][@"description"]];
        model.content = [self handleStringIsNull:array[i][@"content"]];
        

         model.goods_id = [self handleStringIsNull:array[i][@"goods_id"]];
        
        model.goods_name = [self handleStringIsNull:array[i][@"goods_name"]];
        
        model.adimg = [self handleStringIsNull:array[i][@"adimg"]];
        
          model.intro = [self handleStringIsNull:array[i][@"intro"]];
      
           model.sell_price = [self handleStringIsNull:array[i][@"sell_price"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getGoodsModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        GoodsModel *model = [GoodsModel new];
        
        model.price = [self handleStringIsNull:array[i][@"price"]];
        model.img = [self handleStringIsNull:array[i][@"img"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        
        model.quantity = [self handleStringIsNull:array[i][@"quantity"]];
        model.attr = [self handleStringIsNull:array[i][@"attr"]];

        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getAddressModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        AddressModel *model = [AddressModel new];
        
        model.shipp_name = [self handleStringIsNull:array[i][@"shipp_name"]];
        model.shipp_phone = [self handleStringIsNull:array[i][@"shipp_phone"]];
        model.shipp_address = [self handleStringIsNull:array[i][@"shipp_address"]];
        
        model.shipp_id = [self handleStringIsNull:array[i][@"shipp_id"]];
       
        NSNumber *status = array[i][@"status"];
        
        if ([status isEqualToNumber:@1]) {
            model.status = YES;
        } else {
            model.status = NO;
        }
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getGouWuCheModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        GouWuCheModel *model = [GouWuCheModel new];
        
        model.img = [self handleStringIsNull:array[i][@"img"]];
        model.quantity = [self handleStringIsNull:array[i][@"quantity"]];
        model.price = [self handleStringIsNull:array[i][@"price"]];
        
        model.cart_id = [self handleStringIsNull:array[i][@"cart_id"]];
        model.goods_name = [self handleStringIsNull:array[i][@"goods_name"]];
        
        model.i = [self handleStringIsNull:array[i][@"i"]];
        model.v = [self handleStringIsNull:array[i][@"v"]];
        model.willBuyNum = model.quantity;
        model.choose = NO;
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getDengPriceModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DengPriceModel *model = [DengPriceModel new];
        
        model.price_id = [self handleStringIsNull:array[i][@"price_id"]];
        model.day = [self handleStringIsNull:array[i][@"day"]];
        model.price = [self handleStringIsNull:array[i][@"price"]];
        
        model.start = [self handleStringIsNull:array[i][@"start"]];
        model.end = [self handleStringIsNull:array[i][@"end"]];
        
        NSNumber *number = array[i][@"is_rec"];
        
        if ([number isEqualToNumber:@1]) {
            model.recommend = YES;
        } else {
            model.recommend = NO;

        }
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getDengModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DengModel *model = [DengModel new];
        
        model.lamp_id = [self handleStringIsNull:array[i][@"lamp_id"]];
        model.name = [self handleStringIsNull:array[i][@"name"]];
        model.icon = [self handleStringIsNull:array[i][@"icon"]];
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}

+ (NSMutableArray *)getGongPingDetailArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DaShiListItemModel *model = [DaShiListItemModel new];
        
        model.title = [self handleStringIsNull:array[i][@"tribute_name"]];
        model.idString = [self handleStringIsNull:array[i][@"ctime"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}

+ (NSMutableArray *)getQiYuanJiLuModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        QiYuanJiLuModel *model = [QiYuanJiLuModel new];
        
        model.supplication_id = [self handleStringIsNull:array[i][@"supplication_id"]];
        model.buddha_name = [self handleStringIsNull:array[i][@"buddha_name"]];
        model.img = [self handleStringIsNull:array[i][@"img"]];
        model.duration = [self handleStringIsNull:array[i][@"duration"]];
        model.acc = [self handleStringIsNull:array[i][@"acc"]];
        model.wish = [self handleStringIsNull:array[i][@"wish"]];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
       
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getQuickWishModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DaShiListItemModel *model = [DaShiListItemModel new];
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.idString = [self handleStringIsNull:array[i][@"id"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getFoAndShenXianModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        FoAndShenXianModel *model = [FoAndShenXianModel new];
        
        
        
        model.buddha_id = [self handleStringIsNull:array[i][@"buddha_id"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
        model.power = [self handleStringIsNull:array[i][@"power"]];
        model.img = [self handleStringIsNull:array[i][@"img"]];
        model.duration = [self handleStringIsNull:array[i][@"duration"]];
      
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getGongPingModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        GongPingModel *model = [GongPingModel new];
        
        
        
        model.idString = [self handleStringIsNull:array[i][@"id"]];
        model.name = [self handleStringIsNull:array[i][@"name"]];
        
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
        model.icon = [self handleStringIsNull:array[i][@"icon"]];
        model.price = [self handleStringIsNull:array[i][@"price"]];
           model.valid = [self handleStringIsNull:array[i][@"valid"]];
        model.cat_id = [self handleStringIsNull:array[i][@"cat_id"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.ident = [self handleStringIsNull:array[i][@"ident"]];

        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getYiDaoKeTangJudgeModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        JudgeModel *model = [JudgeModel new];
        
        
        
        model.evaluate_id = [self handleStringIsNull:array[i][@"evaluate_id"]];
        model.nickname = [self handleStringIsNull:array[i][@"nickname"]];
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        model.content = [self handleStringIsNull:array[i][@"content"]];
       
        
        NSDictionary *reply = array[i][@"reply"];
        
        
        if (reply) {
            model.reply = [JudgeModel new];
             model.reply.nickname = [self handleStringIsNull:reply[@"nickname"]];
             model.reply.avatar = [self handleStringIsNull:reply[@"avatar"]];
             model.reply.ctime = [self handleStringIsNull:reply[@"ctime"]];
             model.reply.content = [self handleStringIsNull:reply[@"content"]];
        }
       
  
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getYiDaoKeTangModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        YiDaoKeTangModel *model = [YiDaoKeTangModel new];
        
        
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.class_id = [self handleStringIsNull:array[i][@"class_id"]];
     
        model.img = [self handleStringIsNull:array[i][@"img"]];
        model.intro = [self handleStringIsNull:array[i][@"intro"]];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        model.focus = [self handleStringIsNull:array[i][@"focus"]];
        model.fee = [self handleStringIsNull:array[i][@"fee"]];
        model.master = [self handleStringIsNull:array[i][@"master"]];
        model.discount = [self handleStringIsNull:array[i][@"discount"]];
        model.count = [self handleStringIsNull:array[i][@"count"]];
        NSNumber *number = array[i][@"is_apply"];
        if ([number isEqualToNumber:@1]) {
            model.is_apply = YES;
        } else {
            model.is_apply = NO;
        }
        
      NSNumber *number1 = array[i][@"is_hot"];
        if ([number1 isEqualToNumber:@1]) {
            model.is_hot = YES;
        } else {
            model.is_hot = NO;
        }
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getPersonalTitleCollectionModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        PersonalTitleCollectionModel *model = [PersonalTitleCollectionModel new];
        
        
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.idString = [self handleStringIsNull:array[i][@"id"]];
       
        if (i == 0) {
            model.choose = YES;
        } else {
            model.choose = NO;
        }
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}

+ (NSMutableArray *)getQiFUModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        QiFUModel *model = [QiFUModel new];
        
        
        
        model.supplication_id = [self handleStringIsNull:array[i][@"supplication_id"]];
        model.buddha_name = [self handleStringIsNull:array[i][@"buddha_name"]];
        model.buddha_id = [self handleStringIsNull:array[i][@"buddha_id"]];
        model.img = [self handleStringIsNull:array[i][@"img"]];
        model.acc = [self handleStringIsNull:array[i][@"acc"]];
        model.item = [[self alloc] getQiFUModelArrayWithResponseObject:array[i][@"item"]];
        
        
        QiFuDianDengItemModel *subModel = [QiFuDianDengItemModel new];
        
        
        
        subModel.etime = [self handleStringIsNull:array[i][@"etime"]];
        subModel.name = [self handleStringIsNull:array[i][@"name"]];
        subModel.suit = [self handleStringIsNull:array[i][@"suit"]];
        subModel.bless = [self handleStringIsNull:array[i][@"bless"]];
        subModel.intro = [self handleStringIsNull:array[i][@"intro"]];
        subModel.icon = [self handleStringIsNull:array[i][@"icon"]];
        model.lampModel = subModel;
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
- (NSMutableArray *)getQiFUModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        GongPingModel *model = [GongPingModel new];
        
        
        
        model.tribute_id = [self handleStringIsNull:array[i][@"tribute_id"]];
        if ([model.tribute_id isEqualToString:@"0"]) {
            model.tribute_id = @"";
        }
        model.tribute_name = [self handleStringIsNull:array[i][@"tribute_name"]];
        model.tribute_icon = [self handleStringIsNull:array[i][@"tribute_icon"]];

        NSString *start = [NSString stringWithFormat:@"%@",array[i][@"start"]];
        
        if (csCharacterIsBlank(start)) {
            model.start = @"0";
        } else {
            
            int time = start.intValue / 3600;
            
            
            
            model.start = [NSString stringWithFormat:@"%d",time];
        }
        
        
        NSNumber *valid = array[i][@"valid"];
        
        if ([valid isEqualToNumber:@1]) {
            model.valid = YES;
        } else {
            model.valid = NO;
        }
        model.cat_id = [self handleStringIsNull:array[i][@"cat_id"]];
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getYiDaoYuanCollectionModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        YiDaoYuanCollectionModel *model = [YiDaoYuanCollectionModel new];
        
        
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];

        model.money = [self handleStringIsNull:array[i][@"coin"]];
        model.RMB = [self handleStringIsNull:array[i][@"price"]];
        model.sales = [self handleStringIsNull:array[i][@"discount"]];
        if (csCharacterIsBlank(model.sales)) {
            model.showSales = NO;
        } else {
            model.showSales = YES;
        }
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getFuGouBangModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        FuGouBangModel *model = [FuGouBangModel new];
        
        
        
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        model.name = [self handleStringIsNull:array[i][@"name"]];
        model.grade = [self handleStringIsNull:array[i][@"grade"]];
        model.order_num = [self handleStringIsNull:array[i][@"order_num"]];
        model.keep_num = [self handleStringIsNull:array[i][@"keep_num"]];
        model.master_id = [self handleStringIsNull:array[i][@"master_id"]];
        
        model.is_auth = [CSUtility handleNumber:array[i][@"is_auth"]];
        
        model.skille = array[i][@"skille"];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getIndustryNewsModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        IndustryNewsModel *model = [IndustryNewsModel new];
        
        
        
        model.news_id = [self handleStringIsNull:array[i][@"news_id"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.excerpt = [self handleStringIsNull:array[i][@"excerpt"]];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        model.thumb = [self handleStringIsNull:array[i][@"thumb"]];
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (FirstPageModel *)getPunLunSingleModelArrayWithResponseObject:(id)result {
    FirstPageModel *model = [FirstPageModel new];

    if (![result isKindOfClass:[NSDictionary class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return model;
    }
    
        model.skille = result[@"skille"];
        
        model.imgs = result[@"imgs"];
    model.grade = [self handleStringIsNull:result[@"grade"]];

        model.nickname = [self handleStringIsNull:result[@"nickname"]];
        model.avatar = [self handleStringIsNull:result[@"avatar"]];
        model.title = [self handleStringIsNull:result[@"title"]];
        model.content = [self handleStringIsNull:result[@"content"]];
        model.ctime = [self handleStringIsNull:result[@"ctime"]];
        model.master_avatar = [self handleStringIsNull:result[@"master_avatar"]];
        model.master_name = [self handleStringIsNull:result[@"master_name"]];
        model.evaluation_id = [self handleStringIsNull:result[@"evaluation_id"]];
    
    
    return model;
}
+ (NSMutableArray *)getUserPingLunFirstPageModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        FirstPageModel *model = [FirstPageModel new];
        
        model.skille = array[i][@"skille"];

        model.imgs = array[i][@"imgs"];
        model.grade = [self handleStringIsNull:array[i][@"grade"]];
        model.reply= [self handleStringIsNull:array[i][@"reply"]];

        model.nickname = [self handleStringIsNull:array[i][@"nickname"]];
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.content = [self handleStringIsNull:array[i][@"content"]];
         model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        model.master_avatar = [self handleStringIsNull:array[i][@"master_avatar"]];
        model.master_name = [self handleStringIsNull:array[i][@"master_name"]];
        model.evaluation_id = [self handleStringIsNull:array[i][@"evaluation_id"]];
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getDaShiFirstPageModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        FirstPageModel *model = [FirstPageModel new];
        
        
        
        model.master_id = [self handleStringIsNull:array[i][@"master_id"]];
        model.skille = array[i][@"skille"];
        model.name = [self handleStringIsNull:array[i][@"name"]];
        model.grade = [self handleStringIsNull:array[i][@"grade"]];
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
      
        NSString *auth = [self handleStringIsNull:array[i][@"is_auth"]];
       
        if ([auth isEqualToString:@"1"]) {
            
            model.is_auth = @"1";

        } else {
            model.is_auth = @"0";

        }
       
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getConsultModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        ConsultModel *model = [ConsultModel new];
       
  
        model.user_id = [self handleStringIsNull:array[i][@"user_id"]];

        model.order_id = [self handleStringIsNull:array[i][@"order_id"]];
        model.skille = array[i][@"skille"];
        model.master_id = [self handleStringIsNull:array[i][@"master_id"]];
        model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        model.name = [self handleStringIsNull:array[i][@"name"]];
        model.price = [self handleStringIsNull:array[i][@"price"]];
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        model.grade = [self handleStringIsNull:array[i][@"grade"]];

        model.status = [self handleStringIsNull:array[i][@"status"]];
        model.statusTitle = [self handleStringIsNull:array[i][@"statusTitle"]];

        model.user_nickname = [self handleStringIsNull:array[i][@"user_nickname"]];
        model.item_title = [self handleStringIsNull:array[i][@"item_title"]];
        NSString *qa = [self handleStringIsNull:array[i][@"content"]];
        if (csCharacterIsBlank(qa)) {
            model.content = @"";
        } else {
            model.content = [NSString stringWithFormat:@"咨询问题：%@",qa];
        }
        

        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getDaShiListItemModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        DaShiListItemModel *model = [DaShiListItemModel new];
        
        model.title = [self handleStringIsNull:array[i][@"name"]];
        
        model.idString = [self handleStringIsNull:array[i][@"id"]];
        
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getMyCollectModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        MyCollectModel *model = [MyCollectModel new];
        
        model.create_time = [self handleStringIsNull:array[i][@"create_time"]];
        
        model.title = [self handleStringIsNull:array[i][@"title"]];
        
        
        model.descriptionString = [self handleStringIsNull:array[i][@"description"]];
        
        
        model.thumbnail = [self handleStringIsNull:array[i][@"thumbnail"]];
        
        model.table_name = [self handleStringIsNull:array[i][@"table_name"]];
        
        
        model.object_id = [self handleStringIsNull:array[i][@"object_id"]];
        
        model.keep = [self handleStringIsNull:array[i][@"keep"]];
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
+ (NSMutableArray *)getAreaModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        CSAreaModel *model = [CSAreaModel new];
        
        model.idString = [self handleStringIsNull:array[i][@"id"]];
        
        model.name = [self handleStringIsNull:array[i][@"name"]];
        
        
        model.spell = [self handleStringIsNull:array[i][@"spell"]];
        
        
        [mutableArray addObject:model];
        
    }
    return mutableArray;
}
- (NSString *)handleStringIsNull:(id)string {
    if (csCharacterIsBlank(string)) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",string];
}
+ (NSString *)handleStringIsNull:(id)string {
    if (csCharacterIsBlank(string)) {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",string];
}
@end
