//
//  ShoppingAllOrderTitleTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/16.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingAllOrderTitleTableViewCell.h"
NSString *csdaifukuang1 = @"0";
NSString *csdaifahuo1 = @"1";
NSString *csdaishouhuo1 = @"2";
NSString *csyiwancheng1 = @"10";
@interface ShoppingAllOrderTitleTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@end
@implementation ShoppingAllOrderTitleTableViewCell

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
    
    if ([model.status isEqualToString:csdaifahuo1]) {
        self.stateTitleLabel.text = @"待发货";
    }else if ([model.status isEqualToString:csdaifukuang1]) {
        self.stateTitleLabel.text = @"待付款";
    }else if ([model.status isEqualToString:csdaishouhuo1]) {
        self.stateTitleLabel.text = @"待收获";
    }else if ([model.status isEqualToString:csyiwancheng1]) {
        self.stateTitleLabel.text = @"已完成";
    }else if ([model.status isEqualToString:@"-1"]) {
        self.stateTitleLabel.text = @"已取消";
    }else if ([model.status isEqualToString:@"3"]) {
        self.stateTitleLabel.text = @"申请退款中";
    }else if ([model.status isEqualToString:@"-2"]) {
        self.stateTitleLabel.text = @"已退款";
    } else {
        self.stateTitleLabel.text = @"";
    }
    
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_id];
    
   
    
    
}
@end
