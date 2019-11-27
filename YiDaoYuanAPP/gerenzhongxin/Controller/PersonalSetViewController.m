//
//  PersonalSetViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/25.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalSetViewController.h"

#import "PersonalSetTableViewCell.h"
#import "WkWebViewViewController.h"
#import "CSShareView.h"
@interface PersonalSetViewController ()<UITableViewDelegate, UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (nonatomic, strong) CSShareView *shareView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSString *recordTitle;
@property (nonatomic, strong) NSString *recordUrl;

@property (weak, nonatomic) IBOutlet UIButton *quitButton;
- (IBAction)clickQuitButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *changeshengFenButton;
- (IBAction)clickChangeIdentifyButtonDone:(id)sender;
@end
@implementation PersonalSetViewController

- (CSShareView *)shareView {
    if (!_shareView) {
        _shareView = [[CSShareView alloc] initWithFrame:self.view.bounds WithDelegate:self WithTitle:@"易道源" WithDescription:@"算命App" WithImage:DotaImageName(@"AppIcon") WithUrl:@"http://itunes.apple.com/cn/app/id1486602249?mt=8"];
    }
    return _shareView;
}
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[@"个人信息",@"新手指南",@"关于我们",@"分享APP",].mutableCopy;
    }
    return _listArray;
}
- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
   
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    if (!CS_UserIsMaster) {
        
        [self sendGetDashiStatus];
        
    }
}
- (void)sendGetDashiStatus {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_ismaster Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.changeshengFenButton.hidden = NO;
        }else {
            self.changeshengFenButton.hidden = YES;
        }
    } failure:^(NSError * _Nonnull error) {
        self.changeshengFenButton.hidden = YES;

    }];
}
- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
  
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PersonalSetTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PersonalSetTableViewCell)];
   
    self.tableView.rowHeight = 66;
    
    
}

- (void)clickdisappearView {
    self.shareView.hidden = YES;
}

- (void)configSubViews {
    self.quitButton.layer.cornerRadius = 5;
    self.quitButton.layer.masksToBounds = YES;
    
    self.changeshengFenButton.layer.cornerRadius = 5;
    self.changeshengFenButton.layer.masksToBounds = YES;

    if (!CS_UserIsMaster) {
        self.changeshengFenButton.hidden = YES;
    }
    if (CS_UserIsMaster) {
        [self.changeshengFenButton setTitle:@"切换至用户" forState:UIControlStateNormal];
    }else {
        [self.changeshengFenButton setTitle:@"切换至大师" forState:UIControlStateNormal];

    }
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickdisappearView)];
//
//    tap.numberOfTapsRequired = 1;
//
//    tap.numberOfTouchesRequired = 1;
//
//    [self.disappearView addGestureRecognizer:tap];
}

- (void)configNavigationBar {
    
    
    self.title = @"设置";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PersonalSetTableViewCell)];
    cell.csTitleLabel.text = self.listArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.listArray[indexPath.row];
    
    if ([title isEqualToString:@"个人信息"]) {
        [self performSegueWithIdentifier:@"PersonalInfomationViewController" sender:self];
    } else if ([title isEqualToString:@"新手指南"]) {
        self.recordUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_New_Fish];
        self.recordTitle = @"新手指南";
          [self performSegueWithIdentifier:@"WkWebViewViewController" sender:self];
    }else if ([title isEqualToString:@"关于我们"]) {
        
        self.recordUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_About_Us];
      
        self.recordTitle = @"关于我们";
        
 [self performSegueWithIdentifier:@"WkWebViewViewController" sender:self];
        
    }else if ([title isEqualToString:@"分享APP"]) {
        [self.view addSubview:self.shareView];

    }else if ([title isEqualToString:@"退出登录"]) {

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
        //2.创建界面上的按钮
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self quitLogin];
        }];
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        //3.将按钮添加到AlertController中
        [alert addAction:actionNo];
        [alert addAction:actionYes];
        //5.显示AlertController
        [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];

    }
}
- (void)quitLogin {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Logout Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            
            
            
            UINavigationController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"CSLoginNavigationController"];
            
            [[CSUtility getCurrentViewController] presentViewController:new animated:YES completion:nil];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"WkWebViewViewController"]) {
        WkWebViewViewController *new = segue.destinationViewController;
        new.passTitle = self.recordTitle;
        new.passUrl = self.recordUrl;

    }
}
- (IBAction)clickQuitButtonDone:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
    //2.创建界面上的按钮
    UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self quitLogin];
    }];
    UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //3.将按钮添加到AlertController中
    [alert addAction:actionNo];
    [alert addAction:actionYes];
    //5.显示AlertController
    [[CSUtility getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}
- (IBAction)clickChangeIdentifyButtonDone:(id)sender {
    
    
    NSMutableDictionary *para = @{}.mutableCopy;
    if (CS_UserIsMaster) {
        para[@"is_user"] = @"1";
    }else {
        para[@"is_user"] = @"0";

    }
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_portal_mcenter_getinfo Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
           
            [self handleResult:CSGetResult];
            
            if (CS_UserIsMaster) {
               
                [self.changeshengFenButton setTitle:@"切换到大师" forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"CS_UserIsMaster"];
            }else {
                
                [self.changeshengFenButton setTitle:@"切换到用户" forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"CS_UserIsMaster"];
            }

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];

    
}
- (void)handleResult:(id)result {
    
   
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"id"]] forKey:@"CS_UserID"];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"sex"]] forKey:@"CS_Sex"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"birthday"]] forKey:@"CS_Birthday"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"coin"]] forKey:@"CS_Coin"];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"balance"]] forKey:@"CS_Balance"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"user_nickname"]] forKey:@"CS_User_Nickname"];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"avatar"]] forKey:@"CS_Avatar"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",result[@"mobile"]] forKey:@"CS_Mobile"];
    
    
    
    
}
@end
