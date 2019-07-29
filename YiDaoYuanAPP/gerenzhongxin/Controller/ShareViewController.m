//
//  ShareViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShareViewController.h"
#import "CSShareView.h"

#import "WkWebViewViewController.h"
@interface ShareViewController ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *moneyView;

- (IBAction)clickDealButtonDone:(id)sender;

- (IBAction)clickIntroduceButtonDone:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *csCopyButton;
@property (nonatomic, strong) NSDictionary *result;

@property (weak, nonatomic) IBOutlet UILabel *benyueYidaoYuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *leijiYiDaoYuanLabel;
@property (weak, nonatomic) IBOutlet UIImageView *qrImageView;
@property (nonatomic, strong) CSShareView *shareView;
@end

@implementation ShareViewController

- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    self.result = @{}.mutableCopy;
    [self getNewData];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_share_index Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.result = CSGetResult;
            
            self.benyueYidaoYuanLabel.text = [NSString stringWithFormat:@"%@易道元",CSGetResult[@"month_coin"]];
            self.leijiYiDaoYuanLabel.text = [NSString stringWithFormat:@"%@易道元",CSGetResult[@"total_coin"]];
            
            
            
            [self.qrImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", CSGetResult[@"qrcode"]]] placeholderImage:PlaceHolderImage];

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    
}
- (void)downImage {
    UIImageWriteToSavedPhotosAlbum(self.qrImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        CustomWrongMessage(@"保存成功");
    }
    
      NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    
}


- (void)configSubViews {
    
    self.qrImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downImage)];
    
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.qrImageView addGestureRecognizer:tap];
    
    
    UIView *topBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 165)];
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    
    gradient.endPoint = CGPointMake(1, 0);
    
    gradient.frame =topBackgroundView.frame;
    
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithHexString:@"0D71C8"].CGColor,(id)[UIColor colorWithHexString:@"549DDD"].CGColor,nil];
    
    
    [self.topView.layer insertSublayer:gradient atIndex:0];
    
    self.csCopyButton.layer.cornerRadius = 5;
    self.csCopyButton.layer.borderWidth = 1;
    self.csCopyButton.layer.borderColor = cs999999Color.CGColor;
    
    
    self.moneyView.layer.cornerRadius = 5;
    
}

- (void)configNavigationBar {
    
    
    self.title = @"邀请分享";
    F3f3f3NavigationBarColor
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    [rightButton setImage:DotaImageName(@"icon_share-2") forState:UIControlStateNormal];
    
    
    [rightButton addTarget:self action:@selector(clickShareButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)clickShareButtonDone {
    self.shareView = [[CSShareView alloc] initWithFrame:self.view.bounds WithDelegate:self WithTitle:@"易道源" WithDescription:@"算命App" WithImage:DotaImageName(@"AppIcon") WithUrl:self.result[@"url"]];

    [self.view addSubview:self.shareView];
}


- (IBAction)clickDealButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"ZhangDanViewController" sender:self];
    
}

- (IBAction)clickIntroduceButtonDone:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    WkWebViewViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"WkWebViewViewController"];
    
    new.passUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_Portal_Site_share_play];
    
    new.passTitle = @"分享赚";
    
    [self.navigationController pushViewController:new animated:YES];
//     [self performSegueWithIdentifier:@"FengXiangZhuangViewController" sender:self];
}
@end
