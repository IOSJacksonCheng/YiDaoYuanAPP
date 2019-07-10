//
//  XiaoXiViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "XiaoXiViewController.h"
#import "XiaoXiTableViewCell.h"

@interface XiaoXiViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIImageView *animationImageView;

@end

@implementation XiaoXiViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configNavigationBar];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.animationImageView startAnimating];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(XiaoXiTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(XiaoXiTableViewCell)];
    
    self.tableview.rowHeight = 87.5;
}
- (void)configSubViews {
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"消息列表";
    
    F3f3f3NavigationBarColor
    
    
//    UIButton *rightButton = [[UIButton alloc] init];
//
//    [rightButton setTitle:@"论坛" forState:UIControlStateNormal];
//    [rightButton setTitleColor:csBlueColor forState:UIControlStateNormal];
//    rightButton.titleLabel.font = csCharacterFont_18;
//
//    [rightButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
//
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//
//
//    UIButton *rightButton1 = [[UIButton alloc] init];
//
//    [rightButton1 setImage:DotaImageName(@"icon_luntan") forState:UIControlStateNormal];
//
//
//    [rightButton1 addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
//
//    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:rightButton1];
//
//    self.navigationItem.rightBarButtonItems = @[rightItem, rightItem1];
    
    NSMutableArray *allImage = @[].mutableCopy;
    
    for (int i = 1; i < 6; i ++) {
        
        NSString *rightCellName = [NSString stringWithFormat:@"论坛动图_%d",i];
        
        UIImage *image = DotaImageName(rightCellName);
        
        [allImage addObject:image];
        
    }
    
    [self.animationImageView setAnimationImages:allImage];
    
    self.animationImageView.animationRepeatCount = HUGE;
    self.animationImageView.animationDuration = 2;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightButtonDone)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.animationImageView addGestureRecognizer:tap];
}
- (void)clickRightButtonDone {
    
    [self performSegueWithIdentifier:@"LunTanViewController" sender:self];
    
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiaoXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(XiaoXiTableViewCell)];
    cell.imageView.hidden = YES;
    if (indexPath.row == 0) {
        cell.userTitle.text = @"易道源客服";
        cell.userImageView.image = DotaImageName(@"img_kefu");
        cell.userContent.text = @"新用户赠送您100易道元";
        cell.tiXingImageView.hidden = NO;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"AfterPayMoneyChatViewController" sender:self];
}
@end
