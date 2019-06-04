//
//  ValuationTextView.h
//  Personality Customization
//
//  Created by 指意达 on 16/9/13.
//  Copyright © 2016年 YiDa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValuationTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
@end
