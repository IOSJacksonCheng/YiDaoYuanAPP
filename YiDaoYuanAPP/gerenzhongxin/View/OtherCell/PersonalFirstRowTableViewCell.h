//
//  PersonalFirstRowTableViewCell.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/18.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonalFirstRowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *consultView;
@property (weak, nonatomic) IBOutlet UIView *answerView;
@property (weak, nonatomic) IBOutlet UIView *myCollectView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *yuEView;
@property (weak, nonatomic) IBOutlet UIView *yidaoyuanView;
@property (weak, nonatomic) IBOutlet UILabel *yueYuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *yidaoYuanLabel;
@property (nonatomic, strong) NSString *reloadRedView;
@end

NS_ASSUME_NONNULL_END
