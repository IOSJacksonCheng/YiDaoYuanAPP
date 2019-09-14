//
//  GoToJudgePictureTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol GoToJudgePictureTableViewCellDelegate <NSObject>

- (void)passUrl:(NSString *)url;

@end
@interface GoToJudgePictureTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL showTitleView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, weak) id<GoToJudgePictureTableViewCellDelegate> csDelegate;
@end

NS_ASSUME_NONNULL_END
