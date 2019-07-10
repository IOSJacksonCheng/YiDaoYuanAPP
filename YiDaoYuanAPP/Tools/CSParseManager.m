//
//  CSParseManager.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSParseManager.h"

#import "CSAreaModel.h"


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

@implementation CSParseManager
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
+ (NSMutableArray *)getUserPingLunFirstPageModelArrayWithResponseObject:(id)result {
    
    if (![result isKindOfClass:[NSArray class]]) {
        CSLog(@"\n%s数据错误\n",__func__);
        return nil;
    }
    
    NSArray *array = result;
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < array.count; i++) {
        
        FirstPageModel *model = [FirstPageModel new];
        
        
        
        model.nickname = [self handleStringIsNull:array[i][@"nickname"]];
        model.avatar = [self handleStringIsNull:array[i][@"avatar"]];
        model.title = [self handleStringIsNull:array[i][@"title"]];
        model.content = [self handleStringIsNull:array[i][@"content"]];
         model.ctime = [self handleStringIsNull:array[i][@"ctime"]];
        
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
