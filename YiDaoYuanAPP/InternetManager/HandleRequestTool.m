//
//  HandleRequestTool.m
//  BaiYeSheng
//
//  Created by 指意达 on 2018/1/17.
//  Copyright © 2018年 Yida. All rights reserved.
//

#import "HandleRequestTool.h"

@implementation HandleRequestTool
+ (BOOL)requestIsSuccessful:(id)responseObject {
    int state = [responseObject[@"code"] intValue];
    
    if (state == SuccessfulCode) {
        return YES;
    }
    return NO;
}

+ (BOOL)requestNotSubmit:(id)responseObject {
    int state = [responseObject[@"code"] intValue];
    if (state == NotSubmitCode) {
        return YES;
    }
    ;
    return NO;
}
+ (id)requestSuccessGetResult:(id)responseObject {
    return responseObject[@"data"];
}
@end
