//
//  CSLocationViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSLocationViewController.h"
#import "CSLocationTableViewCell.h"
@interface CSLocationViewController ()<UITableViewDelegate, UITableViewDataSource, CSLocationTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (weak, nonatomic) IBOutlet UILabel *dingweiLabel;


@end

@implementation CSLocationViewController
- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = @[].mutableCopy;
    }
    return _hotArray;
}
- (NSMutableArray *)listArray {
    if (!_listArray) {
        
        _listArray = @[].mutableCopy;
        NSArray *titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        for (int i = 0; i < titleArray.count; i ++) {
            
            CSAreaModel *model = CSAreaModel.new;
            
            model.spell = titleArray[i];
            model.subArray = @[].mutableCopy;
            [_listArray addObject:model];
            
        }
        
    }
    return _listArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self sendGetRequest];
    
    [self sendGetHotRequest];
}
- (void)sendGetHotRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_Hot Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.hotArray = [CSParseManager getAreaModelArrayWithResponseObject:CSGetResult[@"lists"]];
            

            
            
            
            [self.tableview reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_City Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
           
            NSMutableArray *array = [CSParseManager getAreaModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            for (CSAreaModel *model in self.listArray) {
                for (CSAreaModel *subModel in array) {
                    
                    
                    if ([model.spell isEqualToString:subModel.spell]) {
                        [model.subArray addObject:subModel];
                    }
                }
            }
           
            
            NSMutableArray *lastArray = @[].mutableCopy;
            
            for (CSAreaModel *model in self.listArray) {
                if (model.subArray.count != 0) {
                    [lastArray addObject:model];
                }
            }
            
            self.listArray = lastArray;
            
            [self.tableview reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableview registerNib:[UINib nibWithNibName:CSCellName(CSLocationTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(CSLocationTableViewCell)];
    self.tableview.rowHeight = 50;
}
- (void)configSubViews {
    self.inputView.layer.cornerRadius = 12;
    self.inputView.layer.masksToBounds = YES;
    NSString *location = [[NSUserDefaults standardUserDefaults] stringForKey:@"CSLocationCity"];
    if (csCharacterIsBlank(location)) {
        self.dingweiLabel.text = @"未进行定位";
    }else {
        self.dingweiLabel.text = [NSString stringWithFormat:@"定位城市:%@",location];
    }
    
    
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
    CSAreaModel *model = self.listArray[section - 2];
    
    return model.spell;
}
//section行数

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.listArray.count + 2;
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 0;
    }
    CSAreaModel *model = self.listArray[section - 2];

    return model.subArray.count;
}
//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *array = @[].mutableCopy;
    
    for (CSAreaModel *model in self.listArray) {
        [array addObject:model.spell];
    }
    return array;
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index + 2;
}
//返回cell

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CSLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(CSLocationTableViewCell) forIndexPath:indexPath];
        cell.csDelegate = self;
        cell.itemMutableArray = self.hotArray;
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    //获得对应的Person对象
    CSAreaModel *model = self.listArray[indexPath.section - 2];
    CSAreaModel *subModel = model.subArray[indexPath.row];
    cell.textLabel.text = subModel.name;
    cell.textLabel.textColor = cs333333Color;
    cell.textLabel.font = csCharacterFont_12;
    return cell;
}
- (void)GetLocationModel:(CSAreaModel *)model {
     [[NSUserDefaults standardUserDefaults] setValue:model.name forKey:@"CSLocationCity"];
self.dingweiLabel.text = [NSString stringWithFormat:@"定位城市:%@",model.name];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CSAreaModel *model = self.listArray[indexPath.section - 2];
    
    CSAreaModel *subModel = model.subArray[indexPath.row];
    
     [[NSUserDefaults standardUserDefaults] setValue:subModel.name forKey:@"CSLocationCity"];
    self.dingweiLabel.text = [NSString stringWithFormat:@"定位城市:%@",subModel.name];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        float height = 0;
        
        height = self.hotArray.count / 5;
        
        if (self.hotArray.count % 5 != 0) {
            height += 1;
        }
        
        return 30 * height;
    }
    
    return 50;
}
@end
