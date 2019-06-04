//
//  DaShiDuanZiXunTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiDuanZiXunTableViewCell.h"
NSString *dashidaihuifu = @"1";
NSString *dashijingxingzhong = @"2";
NSString *dashiyiwancheng = @"3";
@interface DaShiDuanZiXunTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;
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
- (void)setModel:(AllOrderModel *)model {
    
    _model = model;
    
    self.stateTitleLabel.text = model.statTitle;
    
    if ([model.state isEqualToString:dashiyiwancheng]) {
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
    
    
    if ([model.state isEqualToString:dashijingxingzhong]) {
        
        
        UIButton *button = [self getTypeButtonWithTitle:@"继续沟通" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
        
    } else if ([model.state isEqualToString:dashidaihuifu]) {
        UIButton *button = [self getTypeButtonWithTitle:@"立即回复" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
        
        
    }
    
    
    [self configBottomViewWithButtonArray:buttonMutableArray];
    
}
- (void)configBottomViewWithButtonArray:(NSMutableArray *)newMutableArray {
    
    
    CGFloat buttonHeight = 30;
    
    CGFloat buttonInterval_X = 5;
    
    CGFloat buttonWidth = 90;
    
    if (newMutableArray.count == 1) {
        UIButton *button = newMutableArray[0];
        [self.buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-9);
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
            make.right.mas_equalTo(-9 - (buttonInterval_X + buttonWidth) * i);
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
    
   
}
@end
