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
#import "ShopProductDetailViewController.h"
@interface ShengXiaoViewController ()<UITableViewDelegate, UITableViewDataSource, ShengXiaoTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) NSString *recordShengXiaoID;
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
        model1.idString = @"1";
        
        ShengXiaoModel *model2 = [ShengXiaoModel new];
        model2.titleColor = @"#D76CA7";
        model2.title = @"丑牛";
        model2.chooseImage = @"icon_2_chouniu_pre";
        model2.choose = NO;
        model2.image = @"icon_2_chouniu";
        model2.idString = @"2";

        
        ShengXiaoModel *model3 = [ShengXiaoModel new];
        model3.titleColor = @"#4C0B1B";
        model3.title = @"寅虎";
        model3.chooseImage = @"icon_3_yinhu_pre";
        model3.choose = NO;
        model3.image = @"icon_3_yinhu";
        model3.idString = @"3";

        
        ShengXiaoModel *model4 = [ShengXiaoModel new];
        model4.titleColor = @"#90802A";
        model4.title = @"卯兔";
        model4.chooseImage = @"icon_4_maotu_pre";
        model4.choose = NO;
        model4.image = @"icon_4_maotu";
        model4.idString = @"4";

        
        ShengXiaoModel *model5 = [ShengXiaoModel new];
        model5.titleColor = @"#291552";
        model5.title = @"辰龙";
        model5.chooseImage = @"icon_5_chenlong_pre";
        model5.choose = NO;
        model5.image = @"icon_5_chenlong";
        model5.idString = @"5";

        
        ShengXiaoModel *model6 = [ShengXiaoModel new];
        model6.titleColor = @"#0198C2";
        model6.title = @"巳蛇";
        model6.chooseImage = @"icon_6_sishe_pre";
        model6.choose = NO;
        model6.image = @"icon_6_sishe";
        model6.idString = @"6";

        ShengXiaoModel *model7 = [ShengXiaoModel new];
        model7.titleColor = @"#427E3A";
        model7.title = @"午马";
        model7.chooseImage = @"icon_7_wuma_pre";
        model7.choose = NO;
        model7.image = @"icon_7_wuma";
        model7.idString = @"7";

        ShengXiaoModel *model8 = [ShengXiaoModel new];
        model8.titleColor = @"#95201A";
        model8.title = @"未羊";
        model8.chooseImage = @"icon_8_weiyang_pre";
        model8.choose = NO;
        model8.image = @"icon_8_weiyang";
        model8.idString = @"8";

        ShengXiaoModel *model9 = [ShengXiaoModel new];
        model9.titleColor = @"#EA3632";
        model9.title = @"申猴";
        model9.chooseImage = @"icon_9_shenhou_pre";
        model9.choose = NO;
        model9.image = @"icon_9_shenhou";
        model9.idString = @"9";

        ShengXiaoModel *model10 = [ShengXiaoModel new];
        model10.titleColor = @"#56B152";
        model10.title = @"酉鸡";
        model10.chooseImage = @"icon_10_youji_pre";
        model10.choose = NO;
        model10.image = @"icon_10_youji";
        model10.idString = @"10";

        ShengXiaoModel *model11 = [ShengXiaoModel new];
        model11.titleColor = @"#AB6C20";
        model11.title = @"戌狗";
        model11.chooseImage = @"icon_11_xugou_pre";
        model11.choose = NO;
        model11.image = @"icon_11_xugou";
        model11.idString = @"11";

        ShengXiaoModel *model12 = [ShengXiaoModel new];
        model12.titleColor = @"#046879";
        model12.title = @"亥猪";
        model12.chooseImage = @"icon_12_haizhu_pre";
        model12.choose = NO;
        model12.image = @"icon_12_haizhu";
        model12.idString = @"12";

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
    
    self.listArray = @[].mutableCopy;
    self.recordShengXiaoID = @"1";
    [self getNewData];
}

- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
        [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShengXiaoTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShengXiaoTableViewCell)];

     [self.tableView registerNib:[UINib nibWithNibName:CSCellName(ShengXiaoProductTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShengXiaoProductTableViewCell)];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(GetMoreData)];
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.listArray.count;
}
- (void)reloadTableViewWithId:(NSString *)passId {
    self.recordShengXiaoID = passId;
    [self getNewData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        
        ShopManyProductModel *model = self.listArray[indexPath.row];
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];

        ShopProductDetailViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"ShopProductDetailViewController"];
        
        new.passID = model.goods_id;
        
        [self.navigationController pushViewController:new animated:YES];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ShengXiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShengXiaoTableViewCell)];
        cell.itemArray = self.itemArray;
        cell.csDelegate = self;
        return cell;
    }
    ShengXiaoProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShengXiaoProductTableViewCell)];
    ShopManyProductModel *model = self.listArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 105;
    }
    ShopManyProductModel *model = self.listArray[indexPath.row];
    return [self accrodingTextGiveItHeightWith:model.intro];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page = 1;
    para[@"zodiac_id"] = self.recordShengXiaoID;
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Goods_Goodslist Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            
            self.listArray = [CSParseManager getShopManyProductModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)GetMoreData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    self.page ++;
    
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    para[@"zodiac_id"] = self.recordShengXiaoID;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Goods_Goodslist Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getShopManyProductModelArrayWithResponseObject:CSGetResult[@"lists"]];
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！")
            } else {
                
                [self.listArray addObjectsFromArray:array];
                
                [self.tableView reloadData];
                
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    
    
    CGFloat labelWidth = MainScreenWidth - 20;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 10 + 10 + 136 + 10 + 17 + 10 + 18 + 10);
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:14];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
@end
