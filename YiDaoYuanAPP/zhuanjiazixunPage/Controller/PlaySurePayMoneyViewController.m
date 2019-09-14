//
//  PlaySurePayMoneyViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlaySurePayMoneyViewController.h"

#import "PlaySurePayMoneyTableViewCell.h"
#import "PayMoneyWaysTableViewCell.h"
#import "JinXinZhongDetailViewController.h"
#import "InputThreeNumTableViewCell.h"

#import "WXApi.h"

#import <AlipaySDK/AlipaySDK.h>
@interface PlaySurePayMoneyViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
- (IBAction)clickSureButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UITextField *birdayTextField;

@property (nonatomic, assign) BOOL chooseBoy;

@property (nonatomic, strong) UITextField *chushengdiTextField;
@property (nonatomic, strong) UITextField *firstTextField;
@property (nonatomic, strong) UITextField *secondTextField;

@property (nonatomic, strong) UITextField *thirdTextField;
@property (nonatomic, assign) NSInteger currentClickIndex;

@property (nonatomic, assign) BOOL chooseGender;

@property (nonatomic, strong) NSString *orderid;

@property (weak, nonatomic) IBOutlet UIView *dateView;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
- (IBAction)clickCancelTimeButton:(id)sender;
- (IBAction)clickSureTimeButton:(id)sender;

@end

@implementation PlaySurePayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.chooseGender = NO;
    [self.tableView reloadData];
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlaySurePayMoneyTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
  
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PayMoneyWaysTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(InputThreeNumTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(InputThreeNumTableViewCell)];
}
- (void)configSubViews {
    self.timePicker.maximumDate = [NSDate date];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"WXpayResult_Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"AlipayResult_Notification" object:nil];
}
- (void)configNavigationBar {
   
    F3f3f3NavigationBarColor
    
    self.title = @"确认支付";
}

- (IBAction)clickSureButtonDone:(id)sender {
    
    [self.view endEditing:YES];
    
    if (csCharacterIsBlank(self.chushengdiTextField.text) || csCharacterIsBlank(self.birdayTextField.text) || (csCharacterIsBlank(self.firstTextField.text) && csCharacterIsBlank(self.secondTextField.text) && csCharacterIsBlank(self.thirdTextField.text)) || !self.chooseGender) {
        CustomWrongMessage(@"请填写相关信息");
        return;
    }
    if (self.currentClickIndex != 1 && self.currentClickIndex != 2 && self.currentClickIndex != 3 && self.currentClickIndex != 4) {
        CustomWrongMessage(@"请选择支付方式");
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"cat_id"] = self.csCat_id;
    para[@"addr"] = self.chushengdiTextField.text;
    para[@"master_id"] = self.dashiID;
    para[@"birthday"] = self.birdayTextField.text;
    para[@"num1"] = self.firstTextField.text;
    para[@"num2"] = self.secondTextField.text;
    para[@"num3"] = self.thirdTextField.text;
    if (self.chooseBoy) {
        para[@"sex"] = @"1";

    } else {
        para[@"sex"] = @"0";

    }
    if (!csCharacterIsBlank(self.passQuestion_id)) {
        para[@"question_id"] = self.passQuestion_id;

    }else {
        para[@"content"] = self.personalQuestion;

    }
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_Qa_order Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.orderid = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            [self payMoneyWithOrderId:[NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]]];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
       
        if (indexPath.row == 0) {
            PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
            cell.buttonView.hidden = YES;
            cell.csTitleLabel.text = @"阴历生日";
            cell.csImageView.image = DotaImageName(@"icon_1_birthday");
            self.birdayTextField = cell.csTitletextField;
            self.birdayTextField.delegate = self;
             return cell;
        } else if (indexPath.row == 1) {
            PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
            
            cell.csTitleLabel.text = @"性别";
            cell.csImageView.image = DotaImageName(@"icon_2_sex");
            cell.buttonView.hidden = NO;
            if (self.chooseGender) {
                if (self.chooseBoy) {
                    cell.boyButton.selected = YES;
                    cell.girlButton.selected = NO;
                    
                } else {
                    cell.girlButton.selected = YES;
                    cell.boyButton.selected = NO;
                    
                }
            } else {
                cell.girlButton.selected = NO;
                cell.boyButton.selected = NO;
            }
           
            [cell.boyButton addTarget:self action:@selector(clickBoyButtonDone) forControlEvents:UIControlEventTouchDown];
            [cell.girlButton addTarget:self action:@selector(clickGirlButtonDone) forControlEvents:UIControlEventTouchDown];
             return cell;
        } else if (indexPath.row == 2) {
            PlaySurePayMoneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlaySurePayMoneyTableViewCell)];
            cell.buttonView.hidden = YES;
            cell.csTitleLabel.text = @"出生地";
            cell.csImageView.image = DotaImageName(@"icon_3_site");
            self.chushengdiTextField = cell.csTitletextField;

             return cell;
        }
        InputThreeNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(InputThreeNumTableViewCell)];
       
        self.firstTextField = cell.firstTextField;
        self.secondTextField = cell.secondTexField;
        self.thirdTextField = cell.thirdTextField;
        return cell;
    }
    
    PayMoneyWaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PayMoneyWaysTableViewCell)];
    cell.explainLabel.hidden = YES;
   // icon_xuanze
    //icon_weixuanze
    if (indexPath.row == 0) {
        cell.titleImageView.image = DotaImageName(@"icon_yu e");
        cell.titleLabel.text = @"余额支付";
    } else if (indexPath.row == 1) {
        cell.titleImageView.image = DotaImageName(@"icon_yidaoyuan");
        cell.titleLabel.text = @"易道源支付";
        cell.explainLabel.hidden = NO;
    } else if (indexPath.row == 2) {
        cell.titleImageView.image = DotaImageName(@"icon_zhifubao");
        cell.titleLabel.text = @"支付宝支付";
    } else if (indexPath.row == 3) {
        cell.titleImageView.image = DotaImageName(@"icon_weixin");
        cell.titleLabel.text = @"微信支付";
    }
    if (self.currentClickIndex == indexPath.row + 1) {
        cell.chooseImageView.image = DotaImageName(@"icon_xuanze");
    } else {
        cell.chooseImageView.image = DotaImageName(@"icon_weixuanze");
    }
    return cell;
    
}
- (void)clickBoyButtonDone {
    self.chooseBoy = YES;
    self.chooseGender = YES;
    [self.view endEditing:YES];
    [self.tableView reloadData];

}
- (void)clickGirlButtonDone {
    self.chooseBoy = NO;
    self.chooseGender = YES;

    [self.view endEditing:YES];

    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        self.currentClickIndex = indexPath.row + 1;
        [self.tableView reloadData];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 55;
    }
    if (indexPath.row == 3) {
        return 87.5;
    }
    return 51;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.whiteColor;
    UILabel *label = UILabel.new;
    label.text = @"支付方式";
    label.font = csCharacterFont_18;
    label.textColor = cs333333Color;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.centerY.mas_equalTo(0);
    }];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 0;
}
#pragma mark -- 支付
- (void)payMoneyWithOrderId:(NSString *)orderId {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"order_id"] = orderId;
    para[@"payType"] = [NSString stringWithFormat:@"%ld",self.currentClickIndex];
    para[@"orderType"] = @"1";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Index_Createpay Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [self configMoneyWith:CSGetResult];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configMoneyWith:(id)result {
    
    if (self.currentClickIndex == 1) {
        
        
        
        [[NSUserDefaults standardUserDefaults] setValue:result[@"balance"] forKey:@"CS_Balance"];
        
        [self goToSuccessViewController];
        
    } else if (self.currentClickIndex == 2) {
        [[NSUserDefaults standardUserDefaults] setValue:result[@"balance"] forKey:@"CS_Coin"];
        
 [self goToSuccessViewController];
        
    } else if (self.currentClickIndex == 3) {
        
        [self getAlipayPay:result];
    } else if (self.currentClickIndex == 4) {
        
        [self getWeiXinPay:result];
        
        
    }
    
    
}

- (void)getAlipayPay:(id)responseObject {
    
    NSString *string = responseObject[@"code"];
    
    NSString *appScheme = @"alisdkdemo";
    
    [[AlipaySDK defaultService] payOrder:string fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        int resultStatus = [[resultDic objectForKey:@"resultStatus"]intValue];
        
        if (resultStatus == 9000) {
            
            [self goToSuccessViewController];

        }
        
        CSLog(@"reslut = %@",resultDic);
        
    }];
    
}
- (void)getWeiXinPay:(id)responseObject {
    PayReq* wxreq             = [[PayReq alloc] init];
    //                    wxreq.openID              = responseObject[@"params"][@""];
    wxreq.partnerId           = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"partnerid"]];;
    wxreq.prepayId            = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"prepayid"]];
    wxreq.nonceStr            = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"noncestr"]];
    
    UInt32 timeStamp    = [[NSString stringWithFormat:@"%@", responseObject[@"code"][@"timestamp"]] intValue];
    
    wxreq.timeStamp           = timeStamp; //timeStamp
    
    wxreq.package             = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"package"]];
    
    wxreq.sign                = [NSString stringWithFormat:@"%@",responseObject[@"code"][@"sign"]];
    
    if ([WXApi isWXAppInstalled]) {
        CSLog(@"安装了");
    } else {
        CSLog(@"没有安装了");
    }
    
    if ([WXApi sendReq:wxreq]) {
        CSLog(@"微信支付调起成功");
    } else {
        CSLog(@"微信支付调起失败");
    }
    
}
- (void)execute:(NSNotification *)notification {
    if([notification.name isEqualToString:@"AlipayResult_Notification"])
    {
        NSDictionary *result=notification.object;
        if(result)
        {
            int resultStatus = [[result objectForKey:@"resultStatus"]intValue];
            
            if (resultStatus == 9000) {
                
                [self payResult:YES];
                
                
            } else {
                [self payResult:NO];
            }
            
            
        }
    } else if([notification.name isEqualToString:@"WXpayResult_Notification"])
    {
        [self payResult:[notification.object boolValue]];
    }
}
- (void) payResult:(BOOL)result
{
    
    if (result) {
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
        
        [self goToSuccessViewController];

        
    } else {
        
        CustomWrongMessage(@"支付失败！");
    }
}
- (void) dealloc
{
    
    
    //注销通知接收
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"WXpayResult_Notification" object:nil];//注销通知接收
    
}
- (void)goToSuccessViewController {
    
    
UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JinXinZhongDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"JinXinZhongDetailViewController"];
    new.order_id = self.orderid;
    
    [self.navigationController pushViewController:new animated:YES
     ];
    
}
- (IBAction)clickCancelTimeButton:(id)sender {
  
    self.dateView.hidden = YES;

}

- (IBAction)clickSureTimeButton:(id)sender {
    self.birdayTextField.text = [CSUtility convertDateIntoString:self.timePicker.date];
    self.dateView.hidden = YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.dateView.hidden = NO;
    return NO;
}
@end
