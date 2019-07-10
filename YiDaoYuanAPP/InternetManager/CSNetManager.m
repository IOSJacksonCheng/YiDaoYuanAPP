//
//  CSNetManager.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/19.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSNetManager.h"
#import <AFNetworking.h>
static AFHTTPSessionManager *CSManager = nil;

@implementation CSNetManager
+ (AFHTTPSessionManager *)sharedHTTPSession{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CSManager = [AFHTTPSessionManager manager];
        CSManager.requestSerializer.timeoutInterval = 15;
    });
    return CSManager;
    
}
+ (NSString *)getBaseUrl {
    
    return BASE_URL;
}
/** 发送post请求 */
+ (void)sendPostRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(id)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[self getBaseUrl],urlStr];
    
    if (needToken) {
        [manager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"XX-Token"];
         [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
         [manager.requestSerializer setValue:APIVersion forHTTPHeaderField:@"XX-Api-Version"];
    }
    
    
    
    
    CSLog(@"Para:%@", paramDic);
    
    CSLog(@"%@",url);
    
    [manager POST:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showLoginStoryBoard:responseObject];

        success(responseObject);
        
        CSLog(@"当前调用函数：%s",__func__);
        CSLog(@"\npost请求URL：%@\nresponseObject:%@",url,responseObject);
        CSLog(@"post参数:%@",paramDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
        
        
        CSLog(@"post请求URL：%@\n post参数:%@", url,paramDic);
        
        CSLog(@"Error:%@", error);
        
    }];
}
/** 发送PUT请求 */
+ (void)sendPutRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(id)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[self getBaseUrl],urlStr];
    if (needToken) {
        [manager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"XX-Token"];
        [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
        [manager.requestSerializer setValue:APIVersion forHTTPHeaderField:@"XX-Api-Version"];
    }
    CSLog(@"Para:%@", paramDic);
    CSLog(@"%@",url);
    
    [manager PUT:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showLoginStoryBoard:responseObject];

        success(responseObject);
        
        CSLog(@"当前调用函数：%s",__func__);
        CSLog(@"\nPUT请求URL：%@\nresponseObject:%@",url,responseObject);
        CSLog(@"PUT参数:%@",paramDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
        
        
        CSLog(@"PUT请求URL：%@\n PUT参数:%@", url,paramDic);
        
        CSLog(@"Error:%@", error);
    }];
    
}
/** 发送Get请求 */
+ (void)sendGetRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
    
    if (needToken) {
        [manager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"XX-Token"];
        [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
        [manager.requestSerializer setValue:APIVersion forHTTPHeaderField:@"XX-Api-Version"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[self getBaseUrl],urlStr];
    CSLog(@"Para:%@", paramDic);
    CSLog(@"%@",url);
    
    [manager GET:url parameters:paramDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self showLoginStoryBoard:responseObject];

        success(responseObject);
        
        CSLog(@"当前调用函数：%s",__func__);
        CSLog(@"\nGet请求URL：%@\nresponseObject:%@",url,responseObject);
        CSLog(@"Get参数:%@",paramDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        
        CSLog(@"Get请求URL：%@\n Get参数:%@", url,paramDic);
        
        CSLog(@"Error:%@", error);
        
    }];
    
}
+ (void)sendDeleteRequestWithNeedToken:(BOOL)needToken Url:(NSString *)urlStr Pameters:(NSMutableDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    if (paramDic == nil) {
        
        paramDic = [NSMutableDictionary dictionary];
        
    }
    
    if (needToken) {
        [manager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"XX-Token"];
        [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
        [manager.requestSerializer setValue:APIVersion forHTTPHeaderField:@"XX-Api-Version"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[self getBaseUrl],urlStr];
    CSLog(@"Para:%@", paramDic);
    CSLog(@"%@",url);
    [manager DELETE:url parameters:paramDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self showLoginStoryBoard:responseObject];
        success(responseObject);
        
        CSLog(@"当前调用函数：%s",__func__);
        
        CSLog(@"\nDelete请求URL：%@\nresponseObject:%@",url,responseObject);
        
        CSLog(@"Delete参数:%@",paramDic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        CSLog(@"Delete请求URL：%@\n Delete参数:%@", url,paramDic);
        
        CSLog(@"Error:%@", error);
        
    }];
    
    
}


+ (void)sendPostForUploadImageWithUrl:(NSString *)urlStr headerImageFilePath:(NSString *)filePath fileName:(NSString *)fileName parpameters:(NSDictionary *)paramDic success:(successBlock)success failure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    
    [manager.requestSerializer setValue:[self getToken] forHTTPHeaderField:@"XX-Token"];
    [manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"XX-Device-Type"];
    [manager.requestSerializer setValue:APIVersion forHTTPHeaderField:@"XX-Api-Version"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[self getBaseUrl],urlStr];
    
    CSLog(@"%@", paramDic);
    
    [manager POST:url parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:fileName mimeType:@"image/png" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        CSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        //请求成功
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        //请求失败
        CSLog(@"头像上传失败：%@",error);
    }];
}
+ (NSString *)getToken {
    
    CSLog(@"Token:%@", CSGetToken);
    
    return [NSString stringWithFormat:@"%@",CSGetToken];
    
}
+ (void)cancelRequest {
    
    AFHTTPSessionManager *manager = [self sharedHTTPSession];
    if ([manager.tasks count] > 0) {
        [manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    }
}
+ (void)showLoginStoryBoard:(id)result {
    
    NSString *code = [NSString stringWithFormat:@"%@",result[@"code"]];
    
    if ([code isEqualToString:@"10001"]) {
       
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"CSIsLogin"];
        
        [self cancelRequest];
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        
        
        
        UINavigationController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"CSLoginNavigationController"];
        
        [[CSUtility getCurrentViewController] presentViewController:new animated:YES completion:nil];
    }
    
    
    
    
    
}
@end
