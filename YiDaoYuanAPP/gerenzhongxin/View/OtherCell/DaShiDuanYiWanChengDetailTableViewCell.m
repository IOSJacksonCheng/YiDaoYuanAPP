//
//  DaShiDuanYiWanChengDetailTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/6.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDuanYiWanChengDetailTableViewCell.h"
@interface DaShiDuanYiWanChengDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTitleLabel;

@end
@implementation DaShiDuanYiWanChengDetailTableViewCell

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
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:PlaceHolderImage];
    
    self.nameLabel.text = model.user_nickname;
    
    self.itemLabel.text = model.item_title;
    
    self.hejiLabel.text = [NSString stringWithFormat:@"合计：¥%@",model.price];
    
    self.timeLabel.text = [NSString stringWithFormat:@"下单时间：%@",model.ctime];
    
    self.orderLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.order_id];

    self.statusTitleLabel.text = model.statusTitle;
}
@end
