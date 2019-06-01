//
//  ChatModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, CSMessageType) {
    CSMessageTextType,
    CSMessageImageType,
    CSMessageVoiceType,
    CSMessageJudgeType
};
@interface ChatModel : NSObject
@property (nonatomic, assign)  BOOL left;
@property (nonatomic, strong) NSString *imageString;
@property (nonatomic, strong) NSString *contentString;
@property (nonatomic, assign) CSMessageType messageType;
@end

NS_ASSUME_NONNULL_END
