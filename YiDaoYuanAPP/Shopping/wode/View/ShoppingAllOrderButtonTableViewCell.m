//
//  ShoppingAllOrderButtonTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/16.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAllOrderButtonTableViewCell.h"

NSString *csdaifukuang = @"0";
NSString *csdaifahuo = @"1";
NSString *csdaishouhuo = @"2";
NSString *csyiwancheng = @"10";
@interface ShoppingAllOrderButtonTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@end
@implementation ShoppingAllOrderButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(AllOrderModel *)model {
    
    _model = model;
    
    
    self.timeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.creat_time];
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"合计：¥%@",model.total_price];
    
  
    
    if ([model.status isEqualToString:csyiwancheng]) {
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
    
    
    if ([model.status isEqualToString:csdaifukuang]) {
        
        
        UIButton *button = [self getTypeButtonWithTitle:@"立即付款" WithCount:2];
        
        [buttonMutableArray addObject:button];
        UIButton *button1 = [self getTypeButtonWithTitle:@"取消订单" WithCount:2];
        
        [buttonMutableArray addObject:button1];
        
    } else if ([model.status isEqualToString:csdaishouhuo]) {
        UIButton *button = [self getTypeButtonWithTitle:@"确认收货" WithCount:2];
        
        [buttonMutableArray addObject:button];
        
        
        UIButton *button1 = [self getTypeButtonWithTitle:@"查看物流" WithCount:2];
        
        [buttonMutableArray addObject:button1];
    }else if ([model.status isEqualToString:csdaifukuang]) {
        
        UIButton *button = [self getTypeButtonWithTitle:@"取消订单" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
    }
    
    if (buttonMutableArray.count == 0) {
        self.buttonView.hidden = YES;
    } else {
        self.buttonView.hidden = NO;
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

- (void)clickBottomViewButtonDone:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"立即付款"]) {
        [self.csDelegate passOrderId:self.model.order_id];
        
    }else if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建界面上的按钮
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendCancelGetRequest];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        [alert addAction:actionNo];
        [alert addAction:actionYes];
        //5.显示AlertController
        [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
        
    }else if ([sender.titleLabel.text isEqualToString:@"申请退款"]) {
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定申请退款吗？" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建界面上的按钮
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendGetRefundOrder];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        [alert addAction:actionNo];
        [alert addAction:actionYes];
        //5.显示AlertController
        [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
        
    }else if ([sender.titleLabel.text isEqualToString:@"确认收货"]) {
        
        
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认收货吗？" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建界面上的按钮
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendQueRenSHouHuo];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        [alert addAction:actionNo];
        [alert addAction:actionYes];
        //5.显示AlertController
        [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
        
    }else if ([sender.titleLabel.text isEqualToString:@"查看物流"]) {
        
        
        
        [self.csDelegate clickCheckWuLiu];
        
    }
}
- (void)sendQueRenSHouHuo {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.model.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_affirm_order Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self.csDelegate clickCancelOrderDone];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendGetRefundOrder {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.model.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_apply_refund Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self.csDelegate clickCancelOrderDone];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendCancelGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.model.order_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Cart_cancle_order Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"订单取消成功!");
            [self.csDelegate clickCancelOrderDone];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
@end
