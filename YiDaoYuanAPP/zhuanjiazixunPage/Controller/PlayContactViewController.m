//
//  PlayContactViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactViewController.h"

#import "PlayContactTableViewCell.h"
#import "PlayContactUserTableViewCell.h"
#import "PlayContactSamplesTableViewCell.h"
@interface PlayContactViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactUserTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactUserTableViewCell)];

    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(PlayContactSamplesTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"互动咨询";
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
       
        PlayContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactTableViewCell)];
        NSString *title = @"婚恋情感";
        NSString *subTitle = @"爱情、婚姻、桃花姻缘等问题";
        NSString *imageViewString = @"img_hunlian";
         if (indexPath.row == 1) {
            
            title = @"事业财运";
            subTitle = @"职场、创业、投资理财等问题";
            imageViewString = @"img_shiye";
        }else if (indexPath.row == 2) {
            
            title = @"生活健康";
            subTitle = @"父母、子女、健康生活等问题";
            imageViewString = @"img_shenghuo";
        }else if (indexPath.row == 3) {
            
            title = @"风水诊断";
            subTitle = @"分析阴阳宅祸福吉凶等问题";
            imageViewString = @"img_fengshui";
        }
        
        cell.csTitleLabel.text = title;
        cell.csSubTitleLabel.text = subTitle;
        cell.csImageView.image = DotaImageName(imageViewString);
        return cell;
    }
    if (indexPath.row % 2 == 0) {
        PlayContactUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactUserTableViewCell)];
        
        return cell;
    }
    PlayContactSamplesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(PlayContactSamplesTableViewCell)];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    if (indexPath.row % 2 == 0) {
       return 100;
    }
    return 157;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [UIView new];
    view.backgroundColor = UIColor.whiteColor;
    UILabel *label = UILabel.new;
    label.text = @"精选案例";
    label.font = csCharacterFont_18;
    label.textColor = cs333333Color;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11);
        make.centerY.mas_equalTo(0);
    }];
    return view;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 0;
}
@end
