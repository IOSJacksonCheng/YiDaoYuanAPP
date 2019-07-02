//
//  QiFUViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QiFUViewController.h"
#import "AddXiangViewController.h"

#import "QingFoViewController.h"

@interface QiFUViewController ()
- (IBAction)qiYuanJiLuButtonDone:(id)sender;
- (IBAction)mingdengxuyuanButtonDone:(id)sender;
- (IBAction)clickXiangButtonDone:(id)sender;
- (IBAction)clickXianGuoButtonDone:(id)sender;
@property (nonatomic, strong) NSString *passString;
- (IBAction)clickXianHuaButtonDone:(id)sender;

- (IBAction)clickQingShengButtonDone:(id)sender;
- (IBAction)clickQingFuoButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *leftViewLabel;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UILabel *rightViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftSubTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
- (IBAction)clickJingShiButtonDone:(id)sender;
@property (nonatomic, assign) BOOL currentClickShenXian;

@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;
- (IBAction)clickDaoCaiButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *centerFoButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomFirstButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomSecondButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomThirdButton;
@property (nonatomic, assign) NSInteger recordBottomTag;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

@end

@implementation QiFUViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self configNavigationBar];
    [self refreshFoAndShenXianImage];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self clickLeftView];
    
    [self sendGetRequest];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Being Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.rightView addGestureRecognizer:tap];
}
- (void)refreshFoAndShenXianImage {
   
    if (csCharacterIsBlank(CS_CenterFoImage)) {
        [self.centerFoButton setImage:DotaImageName(@"img_qingshen") forState:UIControlStateNormal];
    } else {
         [self.centerFoButton setImage:DotaImageName(CS_CenterFoImage) forState:UIControlStateNormal];
    }
    
    if (csCharacterIsBlank(CS_BottomFirstShenImage)) {
        [self.bottomFirstButton setImage:DotaImageName(@"img_qingfo") forState:UIControlStateNormal];
    } else {
        CSLog(@"%@", CS_BottomFirstShenImage);

        [self.bottomFirstButton setImage:DotaImageName(CS_BottomFirstShenImage) forState:UIControlStateNormal];
    }
    if (csCharacterIsBlank(CS_BottomSecondShenImage)) {
        [self.bottomSecondButton setImage:DotaImageName(@"img_qingfo") forState:UIControlStateNormal];
    } else {
        [self.bottomSecondButton setImage:DotaImageName(CS_BottomSecondShenImage) forState:UIControlStateNormal];
    }
    
    if (csCharacterIsBlank(CS_BottomThirdShenImage)) {
        [self.bottomThirdButton setImage:DotaImageName(@"img_qingfo") forState:UIControlStateNormal];
    } else {
        [self.bottomThirdButton setImage:DotaImageName(CS_BottomThirdShenImage) forState:UIControlStateNormal];
    }
    
}
- (void)configSubViews {
    
    [self refreshFoAndShenXianImage];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLeftView)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.leftView addGestureRecognizer:tap];
    
    
    NSMutableArray *allImage = @[].mutableCopy;
    
    for (int i = 1; i < 8; i ++) {
        
        NSString *rightCellName = [NSString stringWithFormat:@"daocai%d",i];
        
        UIImage *image = DotaImageName(rightCellName);
        
        [allImage addObject:image];
        
    }
    
    [self.animationImageView setAnimationImages:allImage];
    
    self.animationImageView.animationRepeatCount = 1;
    self.animationImageView.animationDuration = 1;

}
- (void)clickLeftView {
    
    self.currentClickShenXian = NO;
    self.leftViewLabel.textColor = [UIColor colorWithHexString:@"#CC211D"];
    self.rightViewLabel.textColor = cs333333Color;
    
    self.leftTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
    self.leftSubTitleLabel.textColor = [UIColor colorWithHexString:@"#FEEBAF"];
    self.rightTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
    self.leftTitleLabel.text = @"祈\n愿\n累\n计\n天\n数";
    self.leftSubTitleLabel.text = @"1天";
    
}
- (void)clickRightView {
    
    self.currentClickShenXian = YES;

    self.rightViewLabel.textColor = [UIColor colorWithHexString:@"#CC211D"];
    self.leftViewLabel.textColor = cs333333Color;
    self.leftTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
    self.leftSubTitleLabel.textColor = [UIColor colorWithHexString:@"#FEEBAF"];
    self.rightTitleLabel.textColor = [UIColor colorWithHexString:@"#FCD65F"];
    self.leftTitleLabel.text = @"燃\n香\n时\n长";
    self.leftSubTitleLabel.text = @"1H";
    
}
- (void)configNavigationBar {
    
    
    self.title = @"祈福";
    
 
    [self.navigationController.navigationBar setBackgroundImage:DotaImageName(@"img_dingbu") forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[CSUtility createImageWithColor:[UIColor colorWithHexString:@"#180C0A"]]];
    
    UIColor *whiteColor = UIColor.whiteColor;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"img_shengying") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickRightButtonDone {
    
}
- (void)clickLeftButtonDone {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
}

- (IBAction)qiYuanJiLuButtonDone:(id)sender {
   
    if (self.currentClickShenXian) {
        
        
         [self performSegueWithIdentifier:@"FirstShenXianQiYuanJiLuViewController" sender:self];
        return;
    }
    [self performSegueWithIdentifier:@"FirstQiYuanJiLuViewController" sender:self];
}

- (IBAction)mingdengxuyuanButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"XuYuanMingDengViewController" sender:self];
}

- (IBAction)clickXiangButtonDone:(id)sender {
     self.passString = @"敬香";
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
}

- (IBAction)clickXianGuoButtonDone:(id)sender {
     self.passString = @"献果";
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
    
}


- (IBAction)clickXianHuaButtonDone:(id)sender {
     self.passString = @"献花";
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
   
}

- (IBAction)clickQingShengButtonDone:(id)sender {
    self.recordBottomTag = 0;
    [self performSegueWithIdentifier:@"QingFoViewController" sender:self];
     
}

- (IBAction)clickQingFuoButtonDone:(UIButton *)sender {
    self.recordBottomTag = sender.tag;
    [self performSegueWithIdentifier:@"QingFoViewController" sender:self];
}
- (IBAction)clickJingShiButtonDone:(id)sender {
    self.passString = @"敬食";
    [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
}
- (IBAction)clickDaoCaiButtonDone:(id)sender {
    
    self.animationImageView.hidden = NO;
    self.caiButton.hidden = YES;
    [self.animationImageView startAnimating];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"QingFoViewController"]) {
        QingFoViewController *new = segue.destinationViewController;
        new.passTag = self.recordBottomTag;
        
    }else if ([segue.identifier isEqualToString:@"AddXiangViewController"]) {
        AddXiangViewController *new = segue.destinationViewController;
        new.passString = self.passString;
    }
}
@end
