//
//  PersonalFirstRowTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/18.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalFirstRowTableViewCell.h"
@interface PersonalFirstRowTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *whiteBgView;
@property (weak, nonatomic) IBOutlet UIImageView *greenImageView;
@property (weak, nonatomic) IBOutlet UIView *redCircleView;



@end
@implementation PersonalFirstRowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.greenImageView.image = [CSUtility createImageWithColor:[UIColor colorWithHexString:@"0D71C8"]];
    self.whiteBgView.layer.cornerRadius = 10;
    self.whiteBgView.layer.masksToBounds = YES;
    
    self.redCircleView.layer.cornerRadius = 4;
    
    self.redCircleView.layer.masksToBounds = YES;
    
    self.headImageView.layer.cornerRadius = 68 * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    
    self.redCircleView.hidden = YES;
    
//    NSMutableDictionary *para = @{}.mutableCopy;

//    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_msg_unread Pameters:para success:^(id  _Nonnull responseObject) {
//
//        if (CSInternetRequestSuccessful) {
//            NSString *badgeNum =[NSString stringWithFormat:@"%@",CSGetResult[@"count"]];
//
//            int badgeValue = [badgeNum intValue];
//
//            if (badgeValue >0) {
//
//                self.redCircleView.hidden = NO;
//
//            }else{
//
//                self.redCircleView.hidden = YES;
//
//                }
//
//
//        }
//    } failure:^(NSError * _Nonnull error) {
//    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
