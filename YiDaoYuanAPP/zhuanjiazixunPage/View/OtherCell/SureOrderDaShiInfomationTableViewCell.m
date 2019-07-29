//
//  SureOrderDaShiInfomationTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/30.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "SureOrderDaShiInfomationTableViewCell.h"
@interface SureOrderDaShiInfomationTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *youhuijuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;

@end
@implementation SureOrderDaShiInfomationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DaShiOrderInfoModel *)model {
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:PlaceHolderImage];
    self.nameLabel.text = model.master_name;
    
    self.itemLabel.text = model.item_title;
    
    self.orderLabel.text = model.order_id;
    self.timeLabel.text = model.ctime;
    self.youhuijuanLabel.text = model.discounts;
    self.payLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.price];

}
@end
