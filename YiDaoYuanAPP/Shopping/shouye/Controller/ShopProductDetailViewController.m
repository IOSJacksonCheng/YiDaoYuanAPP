//
//  ShopProductDetailViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/14.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopProductDetailViewController.h"
#import "ShopProductDetailTitleTableViewCell.h"
#import "ShopProductRepeatTitleTableViewCell.h"
#import "ShopProductTitleTableViewCell.h"
#import "ShopProductDetailBigImageTableViewCell.h"


#import "ZJZXFirstRowModel.h"

#import "ShopProductGuiGeTypeTableViewCell.h"
#import "ShopProductGuiGeTitleTableViewCell.h"

#import "DaShiListItemModel.h"
@interface ShopProductDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *guigeView;
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)clickDeleteButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *guigeTableView;
@property (nonatomic, strong) NSMutableArray *itemArray;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickRightNowBuyButtonDone:(id)sender;

@end

@implementation ShopProductDetailViewController
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
        
        
        NSArray *titleArray = @[@"鼠牛虎（虚空藏菩萨）", @"鼠牛虎（虚空藏菩萨）", @"鼠牛虎（虚空藏菩萨）", @"鼠牛虎（虚空藏菩萨）" ,@"鼠牛虎（虚空藏菩萨）" ,@"鼠牛虎（虚空藏菩萨）"];
        
        for (NSString *string in titleArray) {
            
            DaShiListItemModel *model = [DaShiListItemModel new];
            
            model.title = string;
            
            [_itemArray addObject:model];
        }
        
        
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
    
    self.productTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductDetailTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductDetailTitleTableViewCell)];
       [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductRepeatTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductRepeatTitleTableViewCell)];
    
      [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductTitleTableViewCell)];
    
      [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductDetailBigImageTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductDetailBigImageTableViewCell)];
    
    
    
    self.guigeTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.guigeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.guigeTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductGuiGeTypeTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductGuiGeTypeTableViewCell)];
    [self.guigeTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductGuiGeTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductGuiGeTitleTableViewCell)];
    
}

- (void)configSubViews {
    self.sureButton.layer.cornerRadius = 5;
    self.sureButton.layer.masksToBounds = YES;
    
}

- (void)configNavigationBar {
    
    
    self.title = @"详情";
    
    WhiteNavigationBarColor
    
}


- (IBAction)clickDeleteButtonDone:(id)sender {
    self.guigeView.hidden = YES;
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 0) {
        return 1;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        return 5;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 0) {
        
        if (indexPath.row == 0) {
            ShopProductDetailBigImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductDetailBigImageTableViewCell)];
            ZJZXFirstRowModel *model = [ZJZXFirstRowModel new];
            NSMutableArray *array = @[].mutableCopy;
            [array addObject:model];
            cell.adImageArray = array;
            return cell;
        } else if (indexPath.row == 1) {
            ShopProductTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductTitleTableViewCell)];
            return cell;
            
        }else if (indexPath.row == 2) {
            ShopProductRepeatTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductRepeatTitleTableViewCell)];
            return cell;
            
        }else if (indexPath.row == 3) {
            ShopProductDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductDetailTitleTableViewCell)];
            return cell;
            
        }
        
        ShopProductDetailBigImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductDetailBigImageTableViewCell)];
        ZJZXFirstRowModel *model = [ZJZXFirstRowModel new];
        NSMutableArray *array = @[].mutableCopy;
        [array addObject:model];
        cell.adImageArray = array;
        return cell;
        
    }
    if (indexPath.row == 0) {
        ShopProductGuiGeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductGuiGeTitleTableViewCell)];
        
        return cell;
    }
    
    ShopProductGuiGeTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductGuiGeTypeTableViewCell)];
    
    cell.itemMutableArray = self.itemArray;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        if (indexPath.row == 0) {
            
            return 310;
        } else if (indexPath.row == 1) {
            return 76;
            
        }else if (indexPath.row == 2) {
            return 50;
            
        }else if (indexPath.row == 3) {
            return 50;
            
        }
        
       return 310;
    }
    if (indexPath.row == 0) {
        return 117;
    }
    return 250;
}

- (IBAction)clickRightNowBuyButtonDone:(id)sender {
    
    [self performSegueWithIdentifier:@"ShopSureOrderViewController" sender:self];
    
}
@end
