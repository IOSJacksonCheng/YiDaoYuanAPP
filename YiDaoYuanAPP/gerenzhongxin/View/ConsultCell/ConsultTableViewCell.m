//
//  ConsultTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultTableViewCell.h"

#import "AfterChatJudgeViewController.h"

#import "ShopSureOrderPayMoneyWayViewController.h"
//        //-2已退款 -1已取消 0 未支付 1 已支付等待填写信息 2进行中 3申请退款中 10已完成
#import "GoToJudgeViewController.h"
NSString *daifukuang = @"0";
NSString *jinxingzhong = @"2";
NSString *yiwancheng = @"10";
NSString *tuikuang = @"-2";
@interface ConsultTableViewCell()<ShopSureOrderPayMoneyWayViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *stateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdShanChangLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UILabel *xiadanshijianLabel;
@property (weak, nonatomic) IBOutlet UILabel *hejiLabel;
@property (weak, nonatomic) IBOutlet UILabel *pingFenLabel;

@property (weak, nonatomic) IBOutlet UIImageView *oneXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fourXingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fiveXingImageView;
@property (weak, nonatomic) IBOutlet UILabel *qaLabel;

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
    
    self.qaLabel.text = model.content;
    self.nameLabel.text = model.name;
     [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:CSUserImagePlaceHolder];
    if (model.skille.count == 0) {
        
        self.firstShanChangLabel.text = @"";
       
        self.secondShanChangLabel.text = @"";

        self.thirdShanChangLabel.text = @"";

    }
    
    if (model.skille.count >= 1) {
        self.firstShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[0]];
    } else {
        self.secondShanChangLabel.text = @"";
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 2) {
        self.secondShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[1]];
    }else {
        
        self.thirdShanChangLabel.text = @"";
    }
    if (model.skille.count >= 3) {
        self.thirdShanChangLabel.text = [NSString stringWithFormat:@"%@",model.skille[2]];
    }
    
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单编号:%@",model.order_id];
    
   
   
    self.hejiLabel.text = [NSString stringWithFormat:@"合计:%@",model.price];
   
    
    self.xiadanshijianLabel.text = [NSString stringWithFormat:@"下单时间:%@",model.ctime];
    
    
    self.pingFenLabel.text = model.grade;
    
    if (model.grade.intValue == 0) {
        self.oneXingImageView.image = DotaImageName(@"icon_weishou");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");

    } else if (model.grade.intValue == 1) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_weishou");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 2) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_weishou");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 3) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_weishou");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 4) {
        self.oneXingImageView.image = DotaImageName(@"icon_collect");
        self.twoXingImageView.image = DotaImageName(@"icon_collect");
        self.threeXingImageView.image = DotaImageName(@"icon_collect");
        self.fourXingImageView.image = DotaImageName(@"icon_collect");
        self.fiveXingImageView.image = DotaImageName(@"icon_weishou");
        
        
    }else if (model.grade.intValue == 5) {
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
        
    } else if ([model.status isEqualToString:jinxingzhong] && self.zixun) {
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
        [self.simpleDelegate passModel:self.model];
        if (self.zixun) {
            [[CSUtility getCurrentViewController] performSegueWithIdentifier:@"SureOrderViewController" sender:self];
            
            
            return;
        }
        UIStoryboard *shopping = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
        ShopSureOrderPayMoneyWayViewController *new = [shopping instantiateViewControllerWithIdentifier:@"ShopSureOrderPayMoneyWayViewController"];
        new.csDelegate = self;
        new.passOrderId = self.model.order_id;
       
            new.passOrderType = @"1";

        
        [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
    } else if ([sender.titleLabel.text isEqualToString:@"取消订单"]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定取消订单吗？" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建界面上的按钮
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendCancelGetRequest];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        [alert addAction:actionNo];
        [alert addAction:actionYes];
        //5.显示AlertController
        [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
        
    } else if ([sender.titleLabel.text isEqualToString:@"申请退款"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定退款吗？" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建界面上的按钮
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self sendTuiKuanGetRequest];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        [alert addAction:actionNo];
        [alert addAction:actionYes];
        //5.显示AlertController
        [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
    }else if ([sender.titleLabel.text isEqualToString:@"评价"]) {
//        [self.simpleDelegate passModel:self.model];
//
//        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//        AfterChatJudgeViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"AfterChatJudgeViewController"];
//
//        new.model = self.model;
        GoToJudgeViewController *new = [GoToJudgeViewController new];
        new.order_id = self.model.order_id;
        if (self.zixun) {
            new.typestring = @"1";

        }else {
            new.typestring = @"3";
        }

        [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
    }
}
- (void)sendTuiKuanGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.model.order_id;
    NSString *url = CSURL_consult_refund;
   
    [CSNetManager sendPostRequestWithNeedToken:YES Url:url Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"申请退款提交成功!");
            [self.simpleDelegate refreshCurrentView];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendCancelGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = self.model.order_id;
    NSString *url = CSURL_consult_cancel;
    if (!self.zixun) {
        url = CSURL_qa_cancel;
        
    }
    [CSNetManager sendGetRequestWithNeedToken:YES Url:url Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"订单取消成功!");
            [self.simpleDelegate refreshCurrentView];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)successGoBack {
    [self.simpleDelegate refreshCurrentView];
}
@end
