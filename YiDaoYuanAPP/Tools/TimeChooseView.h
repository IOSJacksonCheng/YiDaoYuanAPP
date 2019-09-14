//
//  TimeChooseView.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/7.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TimeChooseViewDelegate <NSObject>

- (void)passTime:(NSString *)time;

@end
@interface TimeChooseView : UIView
@property (nonatomic, weak) id<TimeChooseViewDelegate> csTimeDelegate;
@end

NS_ASSUME_NONNULL_END
