//
//  ShengXiaoViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/3.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShengXiaoViewController.h"

#import "ShengXiaoTableViewCell.h"

#import "ShengXiaoProductTableViewCell.h"
#import "ShengXiaoModel.h"

@interface ShengXiaoViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@end

@implementation ShengXiaoViewController
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
        
        ShengXiaoModel *model1 = [ShengXiaoModel new];
        model1.titleColor = @"#FA8217";
        model1.title = @"子鼠";
        model1.chooseImage = @"icon_1_zishu_pre";
        model1.choose = YES;
        model1.image = @"icon_1_zishu";
        
        ShengXiaoModel *model2 = [ShengXiaoModel new];
        model2.titleColor = @"#D76CA7";
        model2.title = @"丑牛";
        model2.chooseImage = @"icon_2_chouniu_pre";
        model2.choose = NO;
        model2.image = @"icon_2_chouniu";
        
        ShengXiaoModel *model3 = [ShengXiaoModel new];
        model3.titleColor = @"#4C0B1B";
        model3.title = @"寅虎";
        model3.chooseImage = @"icon_3_yinhu_pre";
        model3.choose = NO;
        model3.image = @"icon_3_yinhu";
        
        
        ShengXiaoModel *model4 = [ShengXiaoModel new];
        model4.titleColor = @"#90802A";
        model4.title = @"卯兔";
        model4.chooseImage = @"icon_4_maotu_pre";
        model4.choose = NO;
        model4.image = @"icon_4_maotu";
        
        
        ShengXiaoModel *model5 = [ShengXiaoModel new];
        model5.titleColor = @"#291552";
        model5.title = @"辰龙";
        model5.chooseImage = @"icon_5_chenlong_pre";
        model5.choose = NO;
        model5.image = @"icon_5_chenlong";
        
        ShengXiaoModel *model6 = [ShengXiaoModel new];
        model6.titleColor = @"#0198C2";
        model6.title = @"巳蛇";
        model6.chooseImage = @"icon_6_sishe_pre";
        model6.choose = NO;
        model6.image = @"icon_6_sishe";
        
        ShengXiaoModel *model7 = [ShengXiaoModel new];
        model7.titleColor = @"#427E3A";
        model7.title = @"午马";
        model7.chooseImage = @"icon_7_wuma_pre";
        model7.choose = NO;
        model7.image = @"icon_7_wuma";
        
        ShengXiaoModel *model8 = [ShengXiaoModel new];
        model8.titleColor = @"#95201A";
        model8.title = @"未羊";
        model8.chooseImage = @"icon_8_weiyang_pre";
        model8.choose = NO;
        model8.image = @"icon_8_weiyang";
        
        ShengXiaoModel *model9 = [ShengXiaoModel new];
        model9.titleColor = @"#EA3632";
        model9.title = @"申猴";
        model9.chooseImage = @"icon_9_shenhou_pre";
        model9.choose = NO;
        model9.image = @"icon_9_shenhou";
        
        ShengXiaoModel *model10 = [ShengXiaoModel new];
        model10.titleColor = @"#56B152";
        model10.title = @"酉鸡";
        model10.chooseImage = @"icon_10_youji_pre";
        model10.choose = NO;
        model10.image = @"icon_10_youji";
        
        ShengXiaoModel *model11 = [ShengXiaoModel new];
        model11.titleColor = @"#AB6C20";
        model11.title = @"戌狗";
        model11.chooseImage = @"icon_11_xugou_pre";
        model11.choose = NO;
        model11.image = @"icon_11_xugou";
        
        ShengXiaoModel *model12 = [ShengXiaoModel new];
        model12.titleColor = @"#046879";
        model12.title = @"亥猪";
        model12.chooseImage = @"icon_12_haizhu_pre";
        model12.choose = NO;
        model12.image = @"icon_12_haizhu";
        
        [_itemArray addObject:model1];
        [_itemArray addObject:model2];

        [_itemArray addObject:model3];

        [_itemArray addObject:model4];

        [_itemArray addObject:model5];

        [_itemArray addObject:model6];

        [_itemArray addObject:model7];

        [_itemArray addObject:model8];

        [_itemArray addObject:model9];
        [_itemArray addObject:model10];

        [_itemArray addObject:model11];

        [_itemArray addObject:model12];

    }
    return _itemArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
        [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShengXiaoTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShengXiaoTableViewCell)];

     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShengXiaoProductTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShengXiaoProductTableViewCell)];
}

- (void)configSubViews {
    
    
}

- (void)configNavigationBar {
    
    
    self.title = @"生肖";
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ShengXiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShengXiaoTableViewCell)];
        cell.itemArray = self.itemArray;
        return cell;
    }
    ShengXiaoProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShengXiaoProductTableViewCell)];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 105;
    }
    return 273;
}
@end
