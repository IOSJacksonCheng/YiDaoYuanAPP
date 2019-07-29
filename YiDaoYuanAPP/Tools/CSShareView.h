//
//  CSShareView.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CSShareViewDelegate <NSObject>

//- (void)clickCloseViewDone;

@end
@interface CSShareView : UIView

@property (nonatomic, weak) id<CSShareViewDelegate>  csDelegate;
- (instancetype)initWithFrame:(CGRect)frame WithDelegate:(id)delegate WithTitle:(NSString *)shareTitle WithDescription:(NSString *)descr WithImage:(UIImage *)image WithUrl:(NSString *)url;
@end

NS_ASSUME_NONNULL_END
