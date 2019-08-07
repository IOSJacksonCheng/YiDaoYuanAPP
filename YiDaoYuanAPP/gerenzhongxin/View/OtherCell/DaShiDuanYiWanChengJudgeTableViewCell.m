//
//  DaShiDuanYiWanChengJudgeTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/6.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDuanYiWanChengJudgeTableViewCell.h"
#import "QCStar.H"
@interface DaShiDuanYiWanChengJudgeTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *zixunLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuwuLabel;
@property (weak, nonatomic) IBOutlet UILabel *huifuLabel;
@property (weak, nonatomic) IBOutlet UILabel *judgeLabel;

@property (weak, nonatomic) IBOutlet UIView *zixunView;
@property (weak, nonatomic) IBOutlet UIView *huifuVIew;
@property (weak, nonatomic) IBOutlet UIView *fuwuView;
@property (nonatomic, strong) QCStar *zixunStar;
@property (nonatomic, strong) QCStar *fuwuStar;
@property (nonatomic, strong) QCStar *huifuStar;
@end
@implementation DaShiDuanYiWanChengJudgeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.zixunStar = [[QCStar alloc] initWithFrame:self.zixunView.bounds];
    self.zixunStar.scorePercent = 0.0;
    self.zixunStar.isCompleteStar = YES; //NO的话可以展示半星
    self.zixunStar.isAnimation = YES;
    self.zixunStar.isJsutDisplay = YES;
    [self.zixunView addSubview:self.zixunStar];
    
    self.fuwuStar = [[QCStar alloc] initWithFrame:self.fuwuView.bounds];
    self.fuwuStar.scorePercent = 0.0;
    self.fuwuStar.isCompleteStar = YES; //NO的话可以展示半星
    self.fuwuStar.isAnimation = YES;
    self.fuwuStar.isJsutDisplay = YES;
    [self.fuwuView addSubview:self.fuwuStar];
    
    self.huifuStar = [[QCStar alloc] initWithFrame:self.huifuVIew.bounds];
    self.huifuStar.scorePercent = 0.0;
    self.huifuStar.isCompleteStar = YES; //NO的话可以展示半星
    self.huifuStar.isAnimation = YES;
    self.huifuStar.isJsutDisplay = YES;
    [self.huifuVIew addSubview:self.huifuStar];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDict:(NSMutableDictionary *)dict {
    _dict = dict;
    self.zixunStar.scorePercent = [NSString stringWithFormat:@"%@",dict[@"quality"]].floatValue / 5;
    self.zixunLabel.text = [NSString stringWithFormat:@"%@",dict[@"quality"]];

    self.fuwuStar.scorePercent = [NSString stringWithFormat:@"%@",dict[@"serve"]].floatValue / 5;
    self.fuwuLabel.text = [NSString stringWithFormat:@"%@",dict[@"serve"]];
    
    self.huifuStar.scorePercent = [NSString stringWithFormat:@"%@",dict[@"reply"]].floatValue / 5;
    self.huifuLabel.text = [NSString stringWithFormat:@"%@",dict[@"reply"]];
    
    self.judgeLabel.text = [NSString stringWithFormat:@"%@",dict[@"content"]];

}
@end
