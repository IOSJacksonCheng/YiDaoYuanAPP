//
//  YiDaoKeTangHotTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangHotTableViewCell.h"
#import "YiDaoKeTangModel.h"

@interface YiDaoKeTangHotTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftbaomingLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftrenshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftmoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftDiscountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftzhekouImageView;


@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *rightTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightbaomingLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightrenshuLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightmoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightDiscountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightzhekouImageView;

@end
@implementation YiDaoKeTangHotTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeft)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [self.leftView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRight)];
    tap2.numberOfTapsRequired = 1;
    tap2.numberOfTouchesRequired = 1;
    
    [self.rightView addGestureRecognizer:tap2];
}
- (void)clickRight {
    YiDaoKeTangModel *leftModel = self.hotArray[1];
    [self.csDelegate goWhichIdString:leftModel.class_id];
}
- (void)clickLeft {
    YiDaoKeTangModel *leftModel = self.hotArray[0];
    [self.csDelegate goWhichIdString:leftModel.class_id];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setHotArray:(NSMutableArray *)hotArray {
    _hotArray = hotArray;
    if (hotArray.count == 0) {
        return;
    }
    
    YiDaoKeTangModel *leftModel = hotArray[0];
    
    self.leftmoneyLabel.text = [NSString stringWithFormat:@"¥%@",leftModel.fee];
    
    self.leftTitleLabel.text = [NSString stringWithFormat:@"%@%@",leftModel.title, leftModel.intro];
    if (leftModel.is_hot) {
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self.leftTitleLabel.text];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"icon_huo"];
        attach.bounds = CGRectMake(0, -1, 15, 15);
        [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach] atIndex:self.leftTitleLabel.text.length];
         self.leftTitleLabel.attributedText = attriStr;
    }
    
    
   
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.img] placeholderImage:PlaceHolderImage];
    self.leftTimeLabel.text = leftModel.ctime;
    self.leftrenshuLabel.text = [NSString stringWithFormat:@"%@人",leftModel.count];
    
    if (leftModel.is_apply) {
        self.leftbaomingLabel.text = @"已报名";

    }else {
        self.leftbaomingLabel.text = @"未报名";

    }
    
    
    if ([leftModel.discount isEqualToString:@"0"]) {
        self.leftDiscountLabel.hidden = YES;
        self.leftzhekouImageView.hidden = YES;
    } else {
        self.leftDiscountLabel.hidden = NO;
        self.leftzhekouImageView.hidden = NO;
        self.leftDiscountLabel.text = [NSString stringWithFormat:@"享%@折优惠",leftModel.discount];
    }
    
    if (hotArray.count == 1) {
        self.rightView.hidden = YES;
        return;
    }
    self.rightView.hidden = NO;
    [self configRightViewWithModel:leftModel];
    
}

- (void)configRightViewWithModel:(YiDaoKeTangModel *)leftModel {
    self.rightmoneyLabel.text = [NSString stringWithFormat:@"¥%@",leftModel.fee];
    
    self.rightTitleLabel.text = [NSString stringWithFormat:@"%@%@",leftModel.title, leftModel.intro];
    if (leftModel.is_hot) {
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:self.rightTitleLabel.text];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:@"icon_huo"];
        attach.bounds = CGRectMake(0, -1, 15, 15);
        [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach] atIndex:self.rightTitleLabel.text.length];
        
        self.rightTitleLabel.attributedText = attriStr;
        
    }
   
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.img] placeholderImage:PlaceHolderImage];
    self.rightTimeLabel.text = leftModel.ctime;
    self.rightrenshuLabel.text = [NSString stringWithFormat:@"%@人",leftModel.count];
    if (leftModel.is_apply) {
        self.rightbaomingLabel.text = @"已报名";
        
    }else {
        self.rightbaomingLabel.text = @"未报名";
        
    }
    if ([leftModel.discount isEqualToString:@"0"]) {
        self.rightDiscountLabel.hidden = YES;
        self.rightzhekouImageView.hidden = YES;
    } else {
        self.rightDiscountLabel.hidden = NO;
        self.rightzhekouImageView.hidden = NO;
        self.rightDiscountLabel.text = [NSString stringWithFormat:@"享%@折优惠",leftModel.discount];
    }
}
@end
