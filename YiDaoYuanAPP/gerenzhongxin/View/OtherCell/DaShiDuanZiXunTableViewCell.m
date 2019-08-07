//
//  DaShiDuanZiXunTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//
#import "EasyUIChatViewController.h"

#import "DaShiDuanZiXunTableViewCell.h"

#import "JinXinZhongDetailViewController.h"

NSString *dashidaihuifu = @"1";
NSString *dashijingxingzhong = @"2";
NSString *dashiyiwancheng = @"3";
@interface DaShiDuanZiXunTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end
@implementation DaShiDuanZiXunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ConsultModel *)model {
    
    _model = model;
    
    self.stateTitleLabel.text = model.statusTitle;
    
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_id];
    self.nameLabel.text = model.user_nickname;
    self.questionLabel.text = model.content;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:PlaceHolderImage];
    
    self.timeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.ctime];
    
    self.hejiLabel.text = [NSString stringWithFormat:@"合计：%@",model.price];
    
    self.itemLabel.text = model.item_title;
    if (![model.status isEqualToString:dashijingxingzhong]) {
        self.buttonView.hidden = YES;
        
        return;
    }
    
    self.buttonView.hidden = NO;
    
    for (UIView *view in self.buttonView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }else if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
        
    }
    
    NSMutableArray *buttonMutableArray = [NSMutableArray array];
    
    
    if ([model.status isEqualToString:dashijingxingzhong]) {
        
        
        UIButton *button = [self getTypeButtonWithTitle:@"继续沟通" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
        
    } else if ([model.status isEqualToString:dashidaihuifu]) {
        UIButton *button = [self getTypeButtonWithTitle:@"立即回复" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
        
        
    }
    
    
    [self configBottomViewWithButtonArray:buttonMutableArray];
    
}
- (void)configBottomViewWithButtonArray:(NSMutableArray *)newMutableArray {
    
    
    CGFloat buttonHeight = 30;
    
    CGFloat buttonInterval_X = 10;
    
    CGFloat buttonWidth = 90;
    
    if (newMutableArray.count == 1) {
        UIButton *button = newMutableArray[0];
        [self.buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(buttonWidth);
        }];
        return;
    }
    
    for (int i = 0; i < newMutableArray.count; i++) {
        
        UIButton *button = newMutableArray[i];
        
        [self.buttonView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0 - (buttonInterval_X + buttonWidth) * i);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(buttonWidth);
            make.centerY.mas_equalTo(0);
            
        }];
    }
    
}

- (UIButton *)getTypeButtonWithTitle:(NSString *)title WithCount:(int)count {
    
    UIButton *button = [[UIButton alloc] init];
    
    button.layer.cornerRadius = 14;
    
    button.titleLabel.font = csCharacterFont_14;
    
    button.layer.borderWidth = 1;
    
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(clickBottomViewButtonDone:) forControlEvents:UIControlEventTouchDown];
    
    if ([title isEqualToString:@"取消订单"] || [title isEqualToString:@"申请退款"] || [title isEqualToString:@"查看物流"]) {
        
        [button setTitleColor:cs999999Color forState:UIControlStateNormal];
        
        button.layer.borderColor = cs999999Color.CGColor;
    } else {
        [button setTitleColor:csBlueColor forState:UIControlStateNormal];
        
        button.layer.borderColor = csBlueColor.CGColor;
    }
    
    
    
    return button;
}
- (void)goToRecordChatTime {
    
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.model.order_id;;
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_consult_reply Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CSLog(@"chenggong记录大师回复时间");

        }else {
            CSLog(@"失败记录大师回复时间");

        }
    } failure:^(NSError * _Nonnull error) {
        CSLog(@"失败记录大师回复时间");
    }];
    
}
- (void)goToChatView {
    
    [self goToRecordChatTime];
    
    EasyUIChatViewController *new =  [[EasyUIChatViewController alloc] initWithConversationChatter:[NSString stringWithFormat:@"o%@",self.model.order_id] conversationType:EMConversationTypeChat];;
    
    new.name = self.model.user_nickname;
    
    new.avater = self.model.avatar;
    new.order_id = self.model.order_id;
    new.isDaShi = YES;
    
    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
    
}
- (void)clickBottomViewButtonDone:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"继续沟通"]) {
        
        if (self.zixun) {
            if (![EMClient sharedClient].isLoggedIn) {
                [[EMClient sharedClient] loginWithUsername:[NSString stringWithFormat:@"m%@",CS_UserID] password:@"123456" completion:^(NSString *aUsername, EMError *aError) {
                    if (aError) {
                        CustomWrongMessage(@"发送错误，请稍后再试");

                        CSLog(@"环信登录失败:%@",aError.errorDescription);
                    } else {
                        [self goToChatView];

                        CSLog(@"环信登录成功！");
                    }
                }];
            } else {
                [self goToChatView];

            }
            
        } else {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            JinXinZhongDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"JinXinZhongDetailViewController"];
            new.order_id = self.model.order_id;
            
            [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES
             ];

        }
       
        
    }
    
    
}
@end
