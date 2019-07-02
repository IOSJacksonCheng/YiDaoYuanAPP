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
@implementation CSParseManager
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
