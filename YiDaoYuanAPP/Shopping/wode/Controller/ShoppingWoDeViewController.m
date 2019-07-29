//
//  ShoppingWoDeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingWoDeViewController.h"

#import "ShoppingWoDeTableViewCell.h"
#import "ShoppingWoDeOrderTableViewCell.h"
#import "ShoppingIconTableViewCell.h"
#import "ShoppingAllOrderViewController.h"

#import "WkWebViewViewController.h"
#import "UserSuggestViewController.h"
#import "PersonalSetViewController.h"
#import "ShareViewController.h"
@interface ShoppingWoDeViewController ()<UITableViewDelegate, UITableViewDataSource, ShoppingWoDeOrderTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger passTag;

@end

@implementation ShoppingWoDeViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self.tableView reloadData];
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
        [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingWoDeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingWoDeTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingWoDeOrderTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingWoDeOrderTableViewCell)];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingIconTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingIconTableViewCell)];
}

- (void)configSubViews {
    
    
}

- (void)configNavigationBar {
    
    
    self.title = @"我的";
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"icon_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)clickLeftButtonDone {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainStoryboard"];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ShoppingIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingIconTableViewCell)];
            
            [cell.titleImageView sd_setImageWithURL:[NSURL URLWithString:CS_Avatar] placeholderImage:CSUserImagePlaceHolder];
            
            cell.nameLabel.text = CS_User_Nickname;
            
            return cell;
        }
        ShoppingWoDeOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingWoDeOrderTableViewCell)];
        cell.csDelegate = self;
        return cell;
        
    }
    ShoppingWoDeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingWoDeTableViewCell)];
    
    
    if (indexPath.section == 1) {
       
        cell.titleLabel.text = @"邀请有礼";
        cell.iconImageView.image = DotaImageName(@"icon_yaoqing");
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0 ) {
            cell.titleLabel.text = @"常见问题";
            cell.iconImageView.image = DotaImageName(@"icon_wenti");
        }else if (indexPath.row == 1 ) {
            cell.titleLabel.text = @"意见反馈";
            cell.iconImageView.image = DotaImageName(@"icon_yijian");
        }else if (indexPath.row == 2 ) {
            cell.titleLabel.text = @"关于我们";
            cell.iconImageView.image = DotaImageName(@"icon_women");
        }
    }
    
    
    
    
 
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && indexPath.row == 2) {
        //
        
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
    
        WkWebViewViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"WkWebViewViewController"];
        
        new.passUrl = [NSString stringWithFormat:@"%@%@", BASE_URL, CSURL_Portal_Site_Goodsabout];
        
        new.passTitle = @"关于我们";
        
        [self.navigationController pushViewController:new animated:YES];
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        
        UserSuggestViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserSuggestViewController"];
        
        
        new.fromShopping = YES;
        
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.section == 2 && indexPath.row == 0)  {
        
        [self performSegueWithIdentifier:@"QuestionsViewController" sender:nil];
    }else if (indexPath.section == 0 && indexPath.row == 0)  {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        PersonalSetViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"PersonalSetViewController"];
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.section == 1)  {
        
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ShareViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
        [self.navigationController pushViewController:new animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = UIView.new;
    
    view.backgroundColor = csf5f5f5Color;
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 95;
    }
    
    return 44;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShoppingAllOrderViewController"]) {
        ShoppingAllOrderViewController *new = segue.destinationViewController;
        new.passTag = self.passTag;
    }
}
#pragma mark -- csdelegate
- (void)goWhichTag:(NSInteger)tag {
    self.passTag = tag;
    [self performSegueWithIdentifier:@"ShoppingAllOrderViewController" sender:self];
}
@end
