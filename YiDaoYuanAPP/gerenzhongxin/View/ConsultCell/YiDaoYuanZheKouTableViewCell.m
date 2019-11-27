//
//  YiDaoYuanZheKouTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoYuanZheKouTableViewCell.h"
@interface YiDaoYuanZheKouTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *yidaoyuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *dikouLabel;
@property (weak, nonatomic) IBOutlet UILabel *renmingbiLabel;

@end
@implementation YiDaoYuanZheKouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setBeishu:(NSString *)beishu {
    _beishu = beishu;
    
    self.yidaoyuanLabel.text = CS_Coin;
    
    self.dikouLabel.text = [NSString stringWithFormat:@"%@易道元可抵扣1元",beishu];
    
    NSString *old = CS_Coin;
    
    if (old.floatValue <= 0 || csCharacterIsBlank(beishu)) {
        self.renmingbiLabel.text = @"0";

    }else {
        self.renmingbiLabel.text = [NSString stringWithFormat:@"%d",old.intValue / beishu.intValue];
    }
    
}
@end
