//
//  AdmireMoneyViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AdmireMoneyViewController.h"
#import "PayMoneyViewController.h"
@interface AdmireMoneyViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *surePayButton;
- (IBAction)clickMoneyButtonDone:(UIButton *)sender;
- (IBAction)clickSurePayButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalPeopleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (nonatomic, strong) NSString *recordId;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;

@property (nonatomic, strong) NSString *recorMoney;

@property (nonatomic, strong) UITextView *contentTextView;

@property (nonatomic, strong) UILabel *csexplainLabel;
@end

@implementation AdmireMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getHistoryRequest];
}
- (void)getHistoryRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"master_id"] = self.master_id;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_total_praise Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.totalPeopleLabel.text = [NSString stringWithFormat:@"共%@人打赏",CSGetResult[@"c"]];
            self.totalMoneyLabel.text = [NSString stringWithFormat:@"打赏金额%@元",CSGetResult[@"total"]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
}
- (void)configSubViews {
    
    self.bgScrollView.contentSize = CGSizeMake(MainScreenWidth, 137);
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, MainScreenWidth, 137)];
    self.contentTextView.delegate = self;
    self.contentTextView.textColor = [UIColor colorWithHexString:@"999999"];
    self.contentTextView.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    self.contentTextView.font = csCharacterFont_15;
    [self.bgScrollView addSubview:self.contentTextView];
    self.csexplainLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 200, 40)];
    self.csexplainLabel.text = @"大师说的很好，赞一个！";
    self.csexplainLabel.textColor = [UIColor colorWithHexString:@"999999"];
    
    self.csexplainLabel.font = csCharacterFont_15;
    [self.bgScrollView addSubview:self.csexplainLabel];
    self.recorMoney = @"10";
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:self.masterIcon] placeholderImage:PlaceHolderImage];
    self.titleLabel.text = self.masterName;
    [self changeButtonStatus:1];
    
    self.titleImageView.layer.cornerRadius = 76 * 0.5;
    self.titleImageView.layer.borderWidth = 1;
    self.titleImageView.layer.borderColor = UIColor.whiteColor.CGColor;
    self.titleImageView.layer.masksToBounds = YES;
    
    self.surePayButton.layer.cornerRadius = 5;
    
    self.button1.layer.borderWidth = 1;
    self.button1.layer.borderColor = csBlueColor.CGColor;
    self.button1.layer.cornerRadius = 5;
    
    self.button2.layer.borderWidth = 1;
    self.button2.layer.borderColor = csBlueColor.CGColor;
    self.button2.layer.cornerRadius = 5;
    
    self.button3.layer.borderWidth = 1;
    self.button3.layer.borderColor = csBlueColor.CGColor;
    self.button3.layer.cornerRadius = 5;
    
    self.button4.layer.borderWidth = 1;
    self.button4.layer.borderColor = csBlueColor.CGColor;
    self.button4.layer.cornerRadius = 5;
    
    self.button5.layer.borderWidth = 1;
    self.button5.layer.borderColor = csBlueColor.CGColor;
    self.button5.layer.cornerRadius = 5;
    
    self.button6.layer.borderWidth = 1;
    self.button6.layer.borderColor = csBlueColor.CGColor;
    self.button6.layer.cornerRadius = 5;
    
    self.button7.layer.borderWidth = 1;
    self.button7.layer.borderColor = csBlueColor.CGColor;
    self.button7.layer.cornerRadius = 5;
    
    self.button8.layer.borderWidth = 1;
    self.button8.layer.borderColor = csBlueColor.CGColor;
    self.button8.layer.cornerRadius = 5;
    
    
    self.inputTextView.delegate = self;
}

- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"赞赏";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (IBAction)clickMoneyButtonDone:(UIButton *)sender {
    
    NSString *money = sender.titleLabel.text;
    
    money = [money substringFromIndex:1];
    
    self.recorMoney = money;
    [self changeButtonStatus:sender.tag];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PayMoneyViewController"]) {
        PayMoneyViewController *new = segue.destinationViewController;
        new.master_id = self.master_id;
        new.masterIcon = self.masterIcon;
        new.masterName = self.masterName;
        new.orderId = self.recordId;
        new.money = self.recorMoney;
        new.dashangren = self.totalPeopleLabel.text;
        new.dashangqian = self.totalMoneyLabel.text;
        new.fromZanShang = YES;
        new.content = self.contentTextView.text;
    }
}
- (IBAction)clickSurePayButtonDone:(UIButton *)sender {
    if (self.recorMoney.floatValue <= 0) {
        CustomWrongMessage(@"请选择金额");
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"master_id"] = self.master_id;
    para[@"price"] = self.recorMoney;
    para[@"content"] = self.contentTextView.text;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_master_praise Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.recordId = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            [self performSegueWithIdentifier:@"PayMoneyViewController" sender:self];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
    
}
- (void)changeButtonStatus:(NSInteger)tag {
    if (tag == 1) {
        self.button1.backgroundColor = csBlueColor;
        [self.button1 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button1.backgroundColor = UIColor.whiteColor;
        [self.button1 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 2) {
        self.button2.backgroundColor = csBlueColor;
        [self.button2 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button2.backgroundColor = UIColor.whiteColor;
        [self.button2 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 3) {
        self.button3.backgroundColor = csBlueColor;
        [self.button3 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button3.backgroundColor = UIColor.whiteColor;
        [self.button3 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 4) {
        self.button4.backgroundColor = csBlueColor;
        [self.button4 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button4.backgroundColor = UIColor.whiteColor;
        [self.button4 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
    if (tag == 5) {
        self.button5.backgroundColor = csBlueColor;
        [self.button5 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button5.backgroundColor = UIColor.whiteColor;
        [self.button5 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 6) {
        self.button6.backgroundColor = csBlueColor;
        [self.button6 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button6.backgroundColor = UIColor.whiteColor;
        [self.button6 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 7) {
        self.button7.backgroundColor = csBlueColor;
        [self.button7 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button7.backgroundColor = UIColor.whiteColor;
        [self.button7 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    if (tag == 8) {
        self.button8.backgroundColor = csBlueColor;
        [self.button8 setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    } else {
        self.button8.backgroundColor = UIColor.whiteColor;
        [self.button8 setTitleColor:csBlueColor forState:UIControlStateNormal];
    }
    
    
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.csexplainLabel.hidden = YES;
    } else {
        self.csexplainLabel.hidden = NO;
    }
}

@end
