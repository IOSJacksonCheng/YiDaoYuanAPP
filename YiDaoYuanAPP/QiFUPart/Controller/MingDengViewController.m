//
//  MingDengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MingDengViewController.h"

#import "MindDengTableViewCell.h"

#import "QuickWishViewController.h"
@interface MingDengViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickCloseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *diandengView;
- (IBAction)clickBeginDianDengDone:(id)sender;
- (IBAction)clickNextButtonDone:(UIButton *)sender;

@end

@implementation MingDengViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MindDengTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MindDengTableViewCell)];
    self.tableView.rowHeight = 80;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
   
    self.title = @"心愿点灯";
   
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickCloseButton:(id)sender {
    self.diandengView.hidden = YES;
}
- (IBAction)clickBeginDianDengDone:(id)sender {
    self.diandengView.hidden = NO;
}

- (IBAction)clickNextButtonDone:(UIButton *)sender {
    
    
    [self performSegueWithIdentifier:@"QuickWishViewController" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"QuickWishViewController"]) {
        QuickWishViewController *new = segue.destinationViewController;
        new.passTag = self.passTag;
        
    }
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MindDengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MindDengTableViewCell)];
    
    cell.xuanzhongImageView.hidden = YES;
    
    cell.csImageView.hidden = YES;
    if (indexPath.section == 2) {
        cell.csImageView.hidden = NO;
    }
    if (indexPath.section == 0) {
        
        cell.xuanzhongImageView.hidden = NO;
        
        cell.backgroundColor = [UIColor colorWithHexString:@"#F3861F"];
        UIColor *titleColor = [UIColor colorWithHexString:@"#FAFBCB"];;
        
        cell.titleLabel.textColor = titleColor;
        cell.moneyLabel.textColor = titleColor;
        cell.timeLabel.textColor = titleColor;
        
    }else {
        
        cell.backgroundColor = [UIColor colorWithHexString:@"#FFFFAC"];
        
        UIColor *titleColor = [UIColor colorWithHexString:@"#BD5F4A"];;
        
        cell.titleLabel.textColor = titleColor;
        cell.moneyLabel.textColor = titleColor;
        cell.timeLabel.textColor = titleColor;

    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = CSColorRGBA(187, 57, 35, 1);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}
@end
