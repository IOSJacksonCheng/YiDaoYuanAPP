//
//  ReplyDetailModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReplyDetailModel : NSObject
/**  1就代表大师回复 0用户追问 */
@property (nonatomic, assign) BOOL is_reply;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *ctime;
@end

NS_ASSUME_NONNULL_END
