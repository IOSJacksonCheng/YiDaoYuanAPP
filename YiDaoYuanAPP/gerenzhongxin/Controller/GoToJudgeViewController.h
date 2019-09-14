//
//  GoToJudgeViewController.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoToJudgeViewController : BaseViewController
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, assign) BOOL isDetail;
//1 咨询评价 2 赞赏评价 3 问答评价
@property (nonatomic, strong) NSString *typestring;
@property (nonatomic, assign) BOOL fromChatView;
@property (nonatomic, assign) BOOL fromZanShangView;
@property (nonatomic, strong) NSString *passContent;
@end

NS_ASSUME_NONNULL_END
