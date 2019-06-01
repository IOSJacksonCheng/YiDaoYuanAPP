//
//  YiDaoKeTangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangViewController.h"

#import "ZJZXMoreTableViewCell.h"
#import "YiDaoKeTangTableViewCell.h"
@interface YiDaoKeTangViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UIScrollView *topButtonScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic, strong) UIView *littleWhiteView;
@property (nonatomic, strong) NSMutableArray *storeTopViewButtonArray;
@end

@implementation YiDaoKeTangViewController
- (NSMutableArray *)storeTopViewButtonArray {
    if (!_storeTopViewButtonArray) {
        _storeTopViewButtonArray = [NSMutableArray array];
    }
    return _storeTopViewButtonArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(ZJZXMoreTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXMoreTableViewCell)];
    
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(YiDaoKeTangTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
    
}
- (void)clickSearchView {
     [self performSegueWithIdentifier:@"YiDaoKeTangSearchViewController" sender:self];
}
- (void)configSubViews {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchView)];
    
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.searchView addGestureRecognizer:tap];
    
    self.searchView.layer.cornerRadius = 15;
    self.searchView.layer.masksToBounds = YES;
    
    //每个按钮的宽度
    CGFloat width = 75;

    CGFloat XInterval = 11;
    CGFloat topScrollViewHeight = 35;
    CGFloat buttonHeight = topScrollViewHeight- 2;
    NSArray *nameArray = @[@"手相面相",@"易经风水",@"起名择口",@"紫薇斗数",@"数字能量"];
    
    self.topButtonScrollView.contentSize = CGSizeMake(nameArray.count * (width + XInterval), topScrollViewHeight);
    
    self.topButtonScrollView.bounces = NO;
    
    
    for (int i = 0; i < nameArray.count; i ++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * (XInterval + width ) + XInterval, 0, width, buttonHeight)];
        
        [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
        
       [button setTitleColor:[UIColor colorWithHexString:@"0F71C7"] forState:UIControlStateSelected];
        
        button.tag = i ;
       
        [button setTitle:nameArray[i] forState:UIControlStateNormal];
        [button setTitle:nameArray[i] forState:UIControlStateSelected];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [button addTarget:self action:@selector(clickTopViewButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.topButtonScrollView addSubview:button];
       
        [self.storeTopViewButtonArray addObject:button];
    }
    
    self.littleWhiteView = [[UIView alloc] initWithFrame:CGRectMake(0, topScrollViewHeight - 1, width, 1)];
    
    
    
    self.littleWhiteView.backgroundColor = [UIColor colorWithHexString:@"96C2E7"];
    
    [self.topButtonScrollView addSubview:self.littleWhiteView];
    
    [self clickTopViewButton:self.storeTopViewButtonArray[0]];
    
}

- (void)clickTopViewButton:(UIButton *)button {
   
    button.selected = YES;
    
    for (UIButton *changeButton in self.storeTopViewButtonArray) {
        if (changeButton.tag != button.tag) {
            changeButton.selected = NO;
        }
    }
   
    [self changeLitterViewFrameWithIndex:button];
    

}
- (void)changeLitterViewFrameWithIndex:(UIButton *)index {
    
    CGFloat centerX = index.center.x;
    CGPoint center = self.littleWhiteView.center;
    center.x = centerX;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        self.littleWhiteView.center = center;
        
    } completion:nil];
    
    //    CGRect frame = self.littleWhiteView.frame;
    //    CGFloat x = frame.origin.x;
    //    x = index * BUTTON_WIDTH;
    //    frame.origin.x = x;
    //    self.littleWhiteView.frame = frame;
    //    [self.view layoutIfNeeded];
}
- (void)configNavigationBar {
    
    self.title = @"易道课堂";
    
    F3f3f3NavigationBarColor
    

    
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        ZJZXMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXMoreTableViewCell)];
        cell.csTitleLabel.text = @"热门课堂";
        cell.moreTitleLabel.hidden = YES;
        return cell;
    }
    YiDaoKeTangTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(YiDaoKeTangTableViewCell)];
   
    return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//     [self performSegueWithIdentifier:@"YiDaoKeTangDetailViewController" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 54;
    }
     return 273;
}
@end
