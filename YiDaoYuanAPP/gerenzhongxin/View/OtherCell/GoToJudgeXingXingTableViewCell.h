//
//  GoToJudgeXingXingTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GoToJudgeXingXingTableViewCellDelegate <NSObject>

- (void)passFenshuWithRow:(NSInteger)row WithFenshu:(CGFloat)fenshu;

@end

@interface GoToJudgeXingXingTableViewCell : UITableViewCell
@property (nonatomic, assign) CGFloat xinxinshu;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fenshuLabel;
@property (nonatomic, assign) BOOL isjustDisplay;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<GoToJudgeXingXingTableViewCellDelegate> simpledelegate;



@end

NS_ASSUME_NONNULL_END
