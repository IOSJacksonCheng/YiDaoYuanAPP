//
//  CSNetManager.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^successBlock)(id responseObject);
typedef void(^failureBlock)(NSError *error);
@interface CSNetManager : NSObject
/** 发送post请求 */
+ (void)sendPostRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(id)paramDic success:(successBlock)success failure:(failureBlock)failure;
/** 发送Get请求 */
+ (void)sendGetRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
/** 发送PUT请求 */
+ (void)sendPutRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(id)paramDic success:(successBlock)success failure:(failureBlock)failure;
/** 发送Delete请求 */
+ (void)sendDeleteRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
+ (void)sendPostForUploadImageWithUrl:(NSString *)urlStr headerImageFilePath:(NSString *)filePath fileName:(NSString *)fileName parpameters:(NSDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure;
@end

NS_ASSUME_NONNULL_END
