//
//  TiXianViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "TiXianViewController.h"
#import "TiXianDetailViewController.h"
@interface TiXianViewController ()<TiXianDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *alipayView;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickSureButtonDone:(id)sender;
@property (nonatomic, strong) NSString *name;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (nonatomic, strong) NSString *order;
@end

@implementation TiXianViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    
    
}

- (void)configSubViews {
    
    self.yueLabel.text = [NSString stringWithFormat:@"余额：¥%@",CS_Balance];
    
    self.sureButton.layer.cornerRadius = 5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoAlipay)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.alipayView addGestureRecognizer:tap];
}
- (void)gotoAlipay {
    [self performSegueWithIdentifier:@"TiXianDetailViewController" sender:self];

}
- (void)configNavigationBar {
    
    
    self.title = @"支付宝提现";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}



- (IBAction)clickSureButtonDone:(id)sender {
    if (csCharacterIsBlank(self.moneyTextField.text)||csCharacterIsBlank(self.order) || csCharacterIsBlank(self.name)) {
        CustomWrongMessage(@"请填写信息");
        return;
    }
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"account"] = self.order;
    para[@"real_name"] = self.name;

    para[@"amount"] = self.moneyTextField.text;

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_withdraw Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            [self.simpleDelegate successback];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"TiXianDetailViewController"]) {
        TiXianDetailViewController *new = segue.destinationViewController;
        new.simpleDelegate = self;
    }
}
- (void)passname:(NSString *)name WithOrder:(NSString *)order {
    self.name = name;
    self.order = order;
}
@end
