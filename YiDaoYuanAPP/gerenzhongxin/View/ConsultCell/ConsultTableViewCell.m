//
//  ConsultTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultTableViewCell.h"

NSString *daifukuang = @"1";
NSString *jinxingzhong = @"2";
NSString *yiwancheng = @"3";
NSString *tuikuang = @"4";
@interface ConsultTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;

@end
@implementation ConsultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ConsultModel *)model {
    
    _model = model;
    
    self.stateTitleLabel.text = model.statTitle;
    
    if ([model.state isEqualToString:tuikuang]) {
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
    
    
    if ([model.state isEqualToString:daifukuang]) {
        
    
        UIButton *button = [self getTypeButtonWithTitle:@"确认支付" WithCount:2];
        
        [buttonMutableArray addObject:button];
        UIButton *button1 = [self getTypeButtonWithTitle:@"取消订单" WithCount:2];
        
        [buttonMutableArray addObject:button1];
        
    } else if ([model.state isEqualToString:jinxingzhong]) {
        UIButton *button = [self getTypeButtonWithTitle:@"申请退款" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
    }else if ([model.state isEqualToString:yiwancheng]) {
        
        UIButton *button = [self getTypeButtonWithTitle:@"评价" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
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
    
    if ([title isEqualToString:@"取消订单"] || [title isEqualToString:@"申请退款"]) {
        
        [button setTitleColor:cs999999Color forState:UIControlStateNormal];
        
        button.layer.borderColor = cs999999Color.CGColor;
    } else {
        [button setTitleColor:csBlueColor forState:UIControlStateNormal];
        
        button.layer.borderColor = csBlueColor.CGColor;
    }
    
  
    
    return button;
}

- (void)clickBottomViewButtonDone:(UIButton *)sender {
    
    if ([sender.titleLabel.text isEqualToString:@"确认支付"]) {
        [[CSUtility getCurrentViewController] performSegueWithIdentifier:@"SureOrderViewController" sender:self];
    } 
}

@end
