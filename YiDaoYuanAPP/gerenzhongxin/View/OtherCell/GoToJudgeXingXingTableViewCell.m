//
//  GoToJudgeXingXingTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/27.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "GoToJudgeXingXingTableViewCell.h"
#import "QCStar.h"
@interface GoToJudgeXingXingTableViewCell()<QCStarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cstitleLabel;
@property (weak, nonatomic) IBOutlet UIView *xingView;

@property (nonatomic, strong) QCStar *qcStarView;

@end
@implementation GoToJudgeXingXingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.qcStarView = [[QCStar alloc] initWithFrame:self.xingView.bounds];
    self.qcStarView.scorePercent = 0.0;
    self.qcStarView.isCompleteStar = YES; //NO的话可以展示半星
    self.qcStarView.isAnimation = YES;
    self.qcStarView.isJsutDisplay = NO;

    self.qcStarView.starDelegate = self;
    
    
    [self.xingView addSubview:self.qcStarView];
}
- (void)passFenshu:(CGFloat)fenshu {
    self.fenshuLabel.text = [NSString stringWithFormat:@"%.1f",fenshu];
    [self.simpledelegate passFenshuWithRow:self.index WithFenshu:fenshu];
//    self.xinxinshu = fenshu;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setXinxinshu:(CGFloat)xinxinshu {
    _xinxinshu = xinxinshu;
    
    self.qcStarView.scorePercent = xinxinshu;
}
- (void)setIsjustDisplay:(BOOL)isjustDisplay {
   
    _isjustDisplay = isjustDisplay;
    
    self.qcStarView.isJsutDisplay = isjustDisplay;

}
@end
