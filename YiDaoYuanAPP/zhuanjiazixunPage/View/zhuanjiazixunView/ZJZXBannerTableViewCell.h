//
//  ZJZXBannerTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJZXBannerTableViewCell : UITableViewCell
@property (nonatomic, strong) NSMutableArray *adImageArray;
@property (nonatomic, assign) BOOL fromShopping;
@property (nonatomic, assign) BOOL fromHomePage;
@end

NS_ASSUME_NONNULL_END
