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
#import "ZJZXBannerTableViewCell.h"


#import "ZJZXFirstRowModel.h"

#import "ShopProductGuiGeTypeTableViewCell.h"
#import "ShopProductGuiGeTitleTableViewCell.h"

#import "DaShiListItemModel.h"

#import "ShopDetailWebTableViewCell.h"

#import "ShopSureOrderViewController.h"
@interface ShopProductDetailViewController ()<UITableViewDelegate, UITableViewDataSource, ShopDetailWebTableViewCellDelegate, ShopProductGuiGeTypeTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *guigeView;
@property (weak, nonatomic) IBOutlet UITableView *productTableView;
- (IBAction)clickDeleteButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *guigeTableView;
@property (nonatomic, strong) NSMutableArray *itemArray;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
- (IBAction)clickRightNowBuyButtonDone:(id)sender;
@property (nonatomic, strong) NSMutableArray *lunboImageArray;

@property (nonatomic, strong) NSString *goods_name;
@property (nonatomic, strong) NSString *intro;

@property (nonatomic, assign) BOOL newspro;
@property (nonatomic, assign) BOOL best;

@property (nonatomic, assign) CGFloat wkwebViewHeight;

@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) NSString *sell_price;

- (IBAction)clickJianButtonDone:(id)sender;
- (IBAction)clickAddButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *numTextField;
- (IBAction)clickGuiGeSureButtonDone:(id)sender;

- (IBAction)clickLianXiKeFuButtonDone:(id)sender;
- (IBAction)clickJiaRuGouWuCheButtonDone:(id)sender;
@property (nonatomic, assign) BOOL clickJiaRuGouWuCheButtonDone;

@property (nonatomic, strong) NSString *recordOrderId;

@property (nonatomic, strong) NSString *goods_id;
@end

@implementation ShopProductDetailViewController
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;
        
        
    }
    return _itemArray;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    self.lunboImageArray = @[].mutableCopy;
    
    self.wkwebViewHeight = 0;
    
    [self sendGetRequest];
    
}
- (void)sendGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"goods_id"] = self.passID;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Goods_GoodsDetail Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.lunboImageArray = [CSParseManager getShoppingDetailHomePageADModelArrayWithResponseObject:CSGetResult[@"img_lists"]];
            NSString *best = [NSString stringWithFormat:@"%@",CSGetResult[@"best"]];
            if ([best isEqualToString:@"1"]) {
                self.best = YES;
            } else {
                self.best = NO;
            }
            
            NSString *newspro = [NSString stringWithFormat:@"%@",CSGetResult[@"newspro"]];
            if ([newspro isEqualToString:@"1"]) {
                self.newspro = YES;
            } else {
                self.newspro = NO;
            }
            
            self.intro = [NSString stringWithFormat:@"%@",CSGetResult[@"intro"]];
             self.goods_id = [NSString stringWithFormat:@"%@",CSGetResult[@"goods_id"]];
            self.goods_name = [NSString stringWithFormat:@"%@",CSGetResult[@"goods_name"]];

            self.img = [NSString stringWithFormat:@"%@",CSGetResult[@"img"]];

            
            self.sell_price = [NSString stringWithFormat:@"%@",CSGetResult[@"sell_price"]];

            
            self.itemArray = [CSParseManager getShopDetailAttrModelArrayWithResponseObject:CSGetResult[@"attr"]];

            
            [self.productTableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    self.productTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.productTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductDetailTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductDetailTitleTableViewCell)];
       [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductRepeatTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductRepeatTitleTableViewCell)];
    
      [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopProductTitleTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopProductTitleTableViewCell)];
    
      [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXBannerTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXBannerTableViewCell)];
    
    [self.productTableView registerNib:[UINib nibWithNibName:CSCellName(ShopDetailWebTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShopDetailWebTableViewCell)];
    
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0 && indexPath.row == 2) {
        self.guigeView.hidden = NO;
        self.sureButton.hidden = YES;
        [self.guigeTableView reloadData];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 0) {
        
        if (indexPath.row == 0) {
            ZJZXBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXBannerTableViewCell)];
            cell.adImageArray = self.lunboImageArray;
            return cell;
        } else if (indexPath.row == 1) {
            ShopProductTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductTitleTableViewCell)];
            
            NSString *title = [NSString stringWithFormat:@"%@：%@",self.goods_name, self.intro];
            
            cell.csTitleLabel.text = title;
            
            if (self.newspro && self.best) {
                
               
                
                if (self.newspro && self.best) {
                    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:title];
                    
                    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                    
                    NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
                    
                    normalAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor;
                    
                    normalAttributes[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size: 10];
                    
                    attach.image = [CSUtility csImageWithColor:[UIColor colorWithHexString:@"FF8C8C"] size:CGSizeMake(30, 20) text:@"新品" textAttributes:normalAttributes circular:YES];
                    
                    
                    
                    
                    attach.bounds = CGRectMake(0, -1, 30, 20);
                    
                    [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach] atIndex:title.length];
                    
                    NSTextAttachment *attach1 = [[NSTextAttachment alloc] init];
                    
                    NSMutableDictionary *normalAttributes1 = [NSMutableDictionary dictionary];
                    
                    normalAttributes1[NSForegroundColorAttributeName] = UIColor.whiteColor;
                    
                    normalAttributes1[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size: 10];
                    
                    attach1.image = [CSUtility csImageWithColor:[UIColor colorWithHexString:@"FF8C8C"] size:CGSizeMake(30, 20) text:@"热销" textAttributes:normalAttributes1 circular:YES];
                    
                    attach1.bounds = CGRectMake(0, -1, 30, 20);
                    
                    [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach1] atIndex:title.length];
                    
                    cell.csTitleLabel.attributedText = attriStr;
                }
                
                
                
                
            } else if (self.newspro ||self.best) {
                
                
                NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:title];
               
                NSTextAttachment *attach = [[NSTextAttachment alloc] init];
                
                NSMutableDictionary *normalAttributes = [NSMutableDictionary dictionary];
                
            normalAttributes[NSForegroundColorAttributeName] = UIColor.whiteColor;
                
                normalAttributes[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size: 10];
                if (self.newspro) {
                    attach.image = [CSUtility csImageWithColor:[UIColor colorWithHexString:@"FF8C8C"] size:CGSizeMake(30, 20) text:@"新品" textAttributes:normalAttributes circular:YES];
                }
                if (self.best) {
                    attach.image = [CSUtility csImageWithColor:[UIColor colorWithHexString:@"FF8C8C"] size:CGSizeMake(30, 20) text:@"热销" textAttributes:normalAttributes circular:YES];
                }
                
                attach.bounds = CGRectMake(0, -1, 30, 20);
                
                [attriStr insertAttributedString:[NSAttributedString attributedStringWithAttachment:attach] atIndex:title.length];
                
                cell.csTitleLabel.attributedText = attriStr;
            }
            
            
            
            return cell;
            
        }else if (indexPath.row == 2) {
            ShopProductRepeatTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductRepeatTitleTableViewCell)];
            return cell;
            
        }else if (indexPath.row == 3) {
            ShopProductDetailTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductDetailTitleTableViewCell)];
            return cell;
            
        }
        
        ShopDetailWebTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopDetailWebTableViewCell)];
        
        cell.passUrl = [NSString stringWithFormat:@"%@%@&&goods_id=%@", BASE_URL,CSURL_Site_GoodsInfo,self.passID];
        cell.cellHeight = [NSString stringWithFormat:@"%f",self.wkwebViewHeight];
        cell.csDelegate = self;
        return cell;
        
    }
    if (indexPath.row == 0) {
        
        ShopProductGuiGeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductGuiGeTitleTableViewCell)];
        
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.sell_price];;
        
        [cell.cellImageView sd_setImageWithURL:[NSURL URLWithString:self.img] placeholderImage:PlaceHolderImage];
        
        cell.csTitleLabel.text = [NSString stringWithFormat:@"%@:%@",self.goods_name, self.intro];
        
        
        return cell;
        
    }
    
    ShopProductGuiGeTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShopProductGuiGeTypeTableViewCell)];
    cell.csDelegate = self;
    cell.itemMutableArray = self.itemArray;
    
    return cell;
}
- (void)clickItemPassPrice:(DaShiListItemModel *)itemModel {
    self.sell_price = itemModel.k;
    
    [self.guigeTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (void)passCellHeight:(CGFloat)height {
    
    self.wkwebViewHeight = height;
    
    [self.productTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 0) {
        if (indexPath.row == 0) {
            
            return 310;
        } else if (indexPath.row == 1) {
            return [self accrodingTextGiveItHeightWith:[NSString stringWithFormat:@"%@：%@",self.goods_name, self.intro]] + 10;
        }else if (indexPath.row == 2) {
            return 50;
            
        }else if (indexPath.row == 3) {
            return 50;
            
        }
        
       return self.wkwebViewHeight;
    }
    if (indexPath.row == 0) {
        return 117;
    }
    return 250;
}

- (IBAction)clickRightNowBuyButtonDone:(id)sender {
    
    self.clickJiaRuGouWuCheButtonDone = NO;
    
    self.guigeView.hidden = NO;
    self.sureButton.hidden = NO;

    [self.guigeTableView reloadData];
  
   
    
    
}
- (void)jiaruGouWuCheRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"goods_id"] = self.goods_id;
    if (csCharacterIsBlank(self.numTextField.text)) {
        self.numTextField.text = @"1";
    }
    para[@"quantity"] = self.numTextField.text;
    
    if (self.itemArray.count != 0) {
        for (int i = 0; i < self.itemArray.count; i ++) {
            DaShiListItemModel *model = self.itemArray[i];
            if (model.choose) {
                para[@"attr_id"] = [NSString stringWithFormat:@"%d",i];;
                break;
            }
        }
        
    }
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Cart_addcart Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"加入购物车成功!")
            self.guigeView.hidden = YES;
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)rightNowBuyGetRequest {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"goods_id"] = self.goods_id;
    if (csCharacterIsBlank(self.numTextField.text)) {
        self.numTextField.text = @"1";
    }
    para[@"quantity"] = self.numTextField.text;

    if (self.itemArray.count != 0) {
        for (int i = 0; i < self.itemArray.count; i ++) {
            DaShiListItemModel *model = self.itemArray[i];
            if (model.choose) {
                para[@"attr_id"] = [NSString stringWithFormat:@"%d",i];;
                break;
            }
        }
        
    }
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Cart_buynow_creat_order Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.recordOrderId = [NSString stringWithFormat:@"%@",CSGetResult[@"order_id"]];
            [self performSegueWithIdentifier:@"ShopSureOrderViewController" sender:self];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    
    
    CGFloat labelWidth = MainScreenWidth - 15 - 15;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 30);
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:18];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
- (IBAction)clickJianButtonDone:(id)sender {
    
    int num = self.numTextField.text.intValue;
    
    num -= 1;
    
    if (num < 1) {
        num = 1;
    }
    
    self.numTextField.text = [NSString stringWithFormat:@"%d",num];
}

- (IBAction)clickAddButtonDone:(id)sender {
    int num = self.numTextField.text.intValue;
    
    num += 1;
    
    if (num < 1) {
        num = 1;
    }
    
    self.numTextField.text = [NSString stringWithFormat:@"%d",num];
    
}
- (IBAction)clickGuiGeSureButtonDone:(id)sender {
    
    [self.view endEditing:YES];
    
    if (self.clickJiaRuGouWuCheButtonDone) {
        [self jiaruGouWuCheRequest];
    }else {
        [self rightNowBuyGetRequest];
    }
    
}

- (IBAction)clickLianXiKeFuButtonDone:(id)sender {
    [CSUtility shoppingGoToKefuController];
}

- (IBAction)clickJiaRuGouWuCheButtonDone:(id)sender {
    
    self.clickJiaRuGouWuCheButtonDone = YES;
    
    self.guigeView.hidden = NO;
    self.sureButton.hidden = NO;

    [self.guigeTableView reloadData];
    
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShopSureOrderViewController"]) {
        ShopSureOrderViewController *new = segue.destinationViewController;
        
        new.passOrderId = self.recordOrderId;
    }
}
@end
