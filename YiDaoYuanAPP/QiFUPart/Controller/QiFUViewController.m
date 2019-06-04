//
//  QiFUViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QiFUViewController.h"
#import "AddXiangViewController.h"
@interface QiFUViewController ()
- (IBAction)qiYuanJiLuButtonDone:(id)sender;
- (IBAction)mingdengxuyuanButtonDone:(id)sender;
- (IBAction)clickXiangButtonDone:(id)sender;
- (IBAction)clickXianGuoButtonDone:(id)sender;
@property (nonatomic, strong) NSString *passString;
- (IBAction)clickXianHuaButtonDone:(id)sender;

- (IBAction)clickQingShengButtonDone:(id)sender;
- (IBAction)clickQingFuoButtonDone:(id)sender;

@end

@implementation QiFUViewController
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self configNavigationBar];
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
}

- (void)configTableView {
    
}
- (void)configSubViews {
    
}

- (void)configNavigationBar {
    
    
    self.title = @"祈福";
    
 
    [self.navigationController.navigationBar setBackgroundImage:DotaImageName(@"img_dingbu") forBarMetrics:UIBarMetricsDefault];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddXiangViewController"]) {
        AddXiangViewController *new = segue.destinationViewController;
        new.passString = self.passString;
    }
}
- (IBAction)clickXianHuaButtonDone:(id)sender {
     self.passString = @"献花";
     [self performSegueWithIdentifier:@"AddXiangViewController" sender:self];
   
}

- (IBAction)clickQingShengButtonDone:(id)sender {
    
      [self performSegueWithIdentifier:@"QingShengViewController" sender:self];
}

- (IBAction)clickQingFuoButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"QingFoViewController" sender:self];
}
@end
