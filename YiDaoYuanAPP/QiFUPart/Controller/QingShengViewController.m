//
//  QingShengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QingShengViewController.h"
#import "QuickWishViewController.h"
@interface QingShengViewController ()
- (IBAction)clickQingShengGongFengButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *foImageView;
@property (weak, nonatomic) IBOutlet UILabel *foNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation QingShengViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    //    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //
    //    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MindDengTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MindDengTableViewCell)];
    //    self.tableView.rowHeight = 80;
}
- (void)configSubViews {
    
    self.foNameLabel.text = self.passModel.title;
    
    [self.foImageView sd_setImageWithURL:[NSURL URLWithString:self.passModel.img] placeholderImage:PlaceHolderImage];
    
    self.introduceLabel.text = self.passModel.intro;
    
    if (self.passModel.power.length >= 4) {
        self.titleLabel.text = [self.passModel.power substringToIndex:4];
        self.subTitleLabel.text = [self.passModel.power substringFromIndex:4];
    } else {
        self.titleLabel.text = self.passModel.power;

    }
    
    
}
- (void)configNavigationBar {
    
    self.title = @"神仙供养";
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickQingShengGongFengButtonDone:(id)sender {
    [self performSegueWithIdentifier:@"QuickWishViewController" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"QuickWishViewController"]) {
        QuickWishViewController *new = segue.destinationViewController;
        new.passBuddaId = self.passModel.buddha_id;
        
    }
}
@end
