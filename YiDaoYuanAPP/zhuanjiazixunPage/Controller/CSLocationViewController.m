//
//  CSLocationViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSLocationViewController.h"
#import "CSLocationTableViewCell.h"
@interface CSLocationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation CSLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
}

- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(CSLocationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(CSLocationTableViewCell)];
    self.tableview.rowHeight = 50;
}
- (void)configSubViews {
    self.inputView.layer.cornerRadius = 12;
    self.inputView.layer.masksToBounds = YES;
}
- (void)configNavigationBar {
    
    self.title = @"定位";
    
    WhiteNavigationBarColor
    
    
}
#pragma mark -- UITableViewDelegate/DataSource
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"热门城市";
    } else if (section == 1) {
        return @"更多城市";
    }
    return @"A";
}
//section行数

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 10;
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 0;
    }
    return 3;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"A",@"B",@"C",@"D",@"E"];
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CSLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(CSLocationTableViewCell) forIndexPath:indexPath];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    //获得对应的Person对象
   
    cell.textLabel.text = @"安徽";
    cell.textLabel.textColor = cs333333Color;
    cell.textLabel.font = csCharacterFont_12;
    return cell;
}
@end
