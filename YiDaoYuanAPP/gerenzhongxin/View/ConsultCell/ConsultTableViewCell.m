//
//  ConsultTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultTableViewCell.h"

NSString *daifukuang = @"0";
NSString *jinxingzhong = @"2";
NSString *yiwancheng = @"10";
NSString *tuikuang = @"-2";
@interface ConsultTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *xiadanshijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingFenLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;

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
    
    self.stateTitleLabel.text = model.statusTitle;
    
    
    self.nameLabel.text = model.name;
    
    if (model.skille.count == 0) {
        
        self.firstShanChangLabel.text = @"";
       
        self.secondShanChangLabel.text = @"";

        self.thirdShanChangLabel.text = @"";

    }
    
    if (model.skille.count >= 1) {
        self.firstShanChangLabel.text = model.skille[0];
    } else {
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 2) {
        self.secondShanChangLabel.text = model.skille[1];
    }else {
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 3) {
        self.thirdShanChangLabel.text = model.skille[2];
    }
    
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.order_id];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
   
    self.hejiLabel.text = [NSString stringWithFormat:@"合计:%@",model.price];
   
    
    self.xiadanshijianLabel.text = [NSString stringWithFormat:@"下单时间:%@",model.ctime];
    
    
    self.pingFenLabel.text = model.grade;
    
    if (model.grade.intValue == 0) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect-1");
        self.twoXingImageView.image = DotaImageName(@"icon_collect-1");
        self.threeXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fourXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect-1");

    } else if (model.grade.intValue == 1) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect-1");
        self.threeXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fourXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect-1");
        
        
    }else if (model.grade.intValue == 2) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fourXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect-1");
        
        
    }else if (model.grade.intValue == 3) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect-1");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect-1");
        
        
    }else if (model.grade.intValue == 4) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect-1");
        
        
    }else if (model.grade.intValue == 54) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_collect");
        
        
    }
    
    
    if ([model.status isEqualToString:tuikuang]) {
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
    
    
    if ([model.status isEqualToString:daifukuang]) {
        
    
        UIButton *button = [self getTypeButtonWithTitle:@"确认支付" WithCount:2];
        
        [buttonMutableArray addObject:button];
        UIButton *button1 = [self getTypeButtonWithTitle:@"取消订单" WithCount:2];
        
        [buttonMutableArray addObject:button1];
        
    } else if ([model.status isEqualToString:jinxingzhong]) {
        UIButton *button = [self getTypeButtonWithTitle:@"申请退款" WithCount:1];
        
        [buttonMutableArray addObject:button];
        
    }else if ([model.status isEqualToString:yiwancheng]) {
        
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
