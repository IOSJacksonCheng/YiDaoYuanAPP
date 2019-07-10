//
//  FirstQiYuanJiLuCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FirstQiYuanJiLuCollectionViewCell.h"
@interface FirstQiYuanJiLuCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
@property (weak, nonatomic) IBOutlet UILabel *cTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leijihuanyuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *haixuLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;

@end
@implementation FirstQiYuanJiLuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(QiYuanJiLuModel *)model {

    _model = model;
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    
    self.cTimeLabel.text = [NSString stringWithFormat:@"请神时间：%@",model.ctime];
    
    self.leijihuanyuanLabel.text = [NSString stringWithFormat:@"累计还愿：%@",model.acc];
    
    self.haixuLabel.text = [NSString stringWithFormat:@"还需还愿：%@天后祈愿圆满",model.duration];
    
    self.wishLabel.text = [NSString stringWithFormat:@"所求愿望：%@",model.wish];
}
@end
