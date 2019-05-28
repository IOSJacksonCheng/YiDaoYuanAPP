//
//  ConsultOrderViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/26.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ConsultOrderViewController.h"

@interface ConsultOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *fourthButton;
@property (weak, nonatomic) IBOutlet UIButton *fifthButton;
- (IBAction)clickTopViewButtonDone:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewWidth;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation ConsultOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
   
}

- (void)configTableView {
    
}
- (void)configSubViews {
    [self changeButtonStatusWithTag:0];
}
- (void)configNavigationBar {
    
    WhiteNavigationBarColor
    
    self.title = @"咨询订单";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

- (void)sendGetRequestForInfomation:(NSInteger)tag {
    
}
- (IBAction)clickTopViewButtonDone:(UIButton *)sender {
    

    [self sendGetRequestForInfomation:sender.tag];
    [self changeButtonStatusWithTag:sender.tag];
    
}
- (void)changeButtonStatusWithTag:(NSUInteger)tag {
    
    
    if (tag == 0) {
        //全部付款
        [self.firstButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    } else {
        [self.firstButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    if (tag == 1) {
        //待付款
         [self.secondButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.secondButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    
    
    if (tag == 2) {
        //进行中
         [self.thirdButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.thirdButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    if (tag == 3) {
        //已完成
         [self.fourthButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.fourthButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    
    if (tag == 4) {
        //退款
         [self.fifthButton setTitleColor:csBlueColor forState:UIControlStateNormal];
    }else {
        [self.fifthButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        CGFloat width = MainScreenWidth * 0.2;
        
        if (tag == 0) {
            
            self.lineViewWidth.constant = 60;
            
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 60 * 0.5;
            
            
        } else if (tag == 4) {
            
            self.lineViewWidth.constant = 30;
            self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 30 * 0.5;
        }  else if (tag == 1) {
                self.lineViewWidth.constant = 45;
                self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 45 * 0.5;
        } else if (tag == 2) {
                self.lineViewWidth.constant = 45;
           self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 45* 0.5;
        }  else if (tag == 3) {
            
            self.lineViewLeftConstraint.constant = self.lineViewWidth.constant = 45;
                  self.lineViewLeftConstraint.constant = width * tag + width * 0.5 - 45 * 0.5;
            
        }
        [self.view layoutIfNeeded];
        
        
        
    } completion:^(BOOL finished) {
        
    }];
   
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(2"")];
//    return cell;
    return nil;
}
@end
