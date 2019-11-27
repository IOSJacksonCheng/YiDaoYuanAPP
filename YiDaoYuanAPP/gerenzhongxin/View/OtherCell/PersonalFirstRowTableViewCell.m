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

@property (weak, nonatomic) IBOutlet UIView *consultRedCircleView;


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
    
    
    self.consultRedCircleView.layer.cornerRadius = 4;
    
    self.consultRedCircleView.layer.masksToBounds = YES;

    
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
- (void)judgeRedViewHide {
    
    NSMutableDictionary *para = @{}.mutableCopy;
   
    if (CS_UserIsMaster) {
        para[@"is_master"] = @"1";

    }else {
        para[@"is_master"] = @"0";

    }
    
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_taskcount Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            NSString *consult = [NSString stringWithFormat:@"%@",CSGetResult[@"consult"]];
            NSString *answer = [NSString stringWithFormat:@"%@",CSGetResult[@"qa"]];

            if (consult.floatValue > 0) {
                self.consultRedCircleView.hidden = NO;
            } else {
                self.consultRedCircleView.hidden = YES;
            }
            if (answer.floatValue > 0) {
                           self.redCircleView.hidden = NO;
                       } else {
                           self.redCircleView.hidden = YES;
                       }
            
        }else {
            self.redCircleView.hidden = YES;
            
            self.consultRedCircleView.hidden = YES;
        }
    } failure:^(NSError * _Nonnull error) {
       
        self.redCircleView.hidden = YES;
        
        self.consultRedCircleView.hidden = YES;

    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setReloadRedView:(NSString *)reloadRedView {
    _reloadRedView = reloadRedView;
    [self judgeRedViewHide];
}
@end
