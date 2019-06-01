//
//  PlayContactStepThreeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PlayContactStepThreeViewController.h"

#import "AskStepThreeTableViewCell.h"
#import "AskStepThreeDetailInfomationTableViewCell.h"
@interface PlayContactStepThreeViewController ()<UITableViewDelegate, UITableViewDataSource>
- (IBAction)clickNextStepButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@end

@implementation PlayContactStepThreeViewController
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[].mutableCopy;
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
    [self getData];
    
    [self.tableView reloadData];
    
}
- (void)getData {
    
    for (int i = 0; i < 6; i ++) {
        PlayContactStepThreeModel *model1 = [PlayContactStepThreeModel new];
        model1.title = @"1.我什么时候结束单身";
        model1.choose = NO;
        model1.isTextField = NO;
        model1.isEightRow = NO;
        [self.titleArray addObject:model1];
    }
    PlayContactStepThreeModel *model2 = [PlayContactStepThreeModel new];
    model2.title = @"8.自定义问题（限一个问题）";
    model2.choose = NO;
    model2.isTextField = NO;
    model2.isEightRow = YES;
     [self.titleArray addObject:model2];
}
- (void)configTableView {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(AskStepThreeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(AskStepThreeTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(AskStepThreeDetailInfomationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(AskStepThreeDetailInfomationTableViewCell)];

}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    WhiteNavigationBarColor
    
    self.title = @"提问";
}

- (IBAction)clickNextStepButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"ChooseDaShiViewController" sender:self];
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return self.titleArray.count;;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        AskStepThreeDetailInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(AskStepThreeDetailInfomationTableViewCell)];
        
        return cell;
    }
    AskStepThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(AskStepThreeTableViewCell)];
    PlayContactStepThreeModel *model = self.titleArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayContactStepThreeModel *model = self.titleArray[indexPath.row];
    
    if (model.isTextField) {
        return;
    }
     model.choose = YES;
    for (int i = 0; i < self.titleArray.count; i ++) {
        PlayContactStepThreeModel *changeModel = self.titleArray[i];
        if (i != indexPath.row) {
            changeModel.choose = NO;
        }
    }
    
    
   
    if (model.isEightRow ) {
        if (self.titleArray.count != 8) {
            PlayContactStepThreeModel *model1 = [PlayContactStepThreeModel new];
            model1.title = @"";
            model1.choose = NO;
            model1.isTextField = YES;
            model1.isEightRow = NO;
            
            [self.titleArray insertObject:model1 atIndex:0];
          
        }
        
    }else {
        if (self.titleArray.count == 8) {
          
            [self.titleArray removeObjectAtIndex:0];
            
          
        }
    }
      [self.tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 170;
    }
    return 52;
}
@end
