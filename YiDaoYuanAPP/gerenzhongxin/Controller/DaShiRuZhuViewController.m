//
//  DaShiRuZhuViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiRuZhuViewController.h"
#import "DaShiRuZhuTextFieldTableViewCell.h"
#import "DaShiRuZhuTextViewTableViewCell.h"
#import "DaShiRuZhuButtonTableViewCell.h"
#import "DaShiRuZhuIdCardTableViewCell.h"
#import "DaShiListItemModel.h"
#import "DaShiRuZhuIdCollectionTableViewCell.h"
@interface DaShiRuZhuViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) NSMutableArray *itemArray;
- (IBAction)clickSubmitButtonDone:(id)sender;
@end

@implementation DaShiRuZhuViewController
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[].mutableCopy;

        
        
    }
    return _itemArray;
}

- (IBAction)clickSubmitButtonDone:(id)sender {
    
    NSMutableDictionary *para = @{}.mutableCopy;

    
    for (int i = 0; i < self.listArray.count; i ++) {
        
        DaShiRuZhuModel *model = self.listArray[i];
        
        if (i == 3) {
            
            NSMutableArray *array = @[].mutableCopy;
            
            for (DaShiListItemModel *model in self.itemArray) {
                if (model.choose) {
                    [array addObject:model];
                }
            }
            
            for (int i = 0; i < array.count; i ++) {
              
                DaShiListItemModel *model = array[i];
                
                para[[NSString stringWithFormat:@"skilled_id[%d]",i]] = model.idString;
                
            }
            
        } else if (i == 7) {
            if (model.chooseLeft) {
                
                para[@"pay_term"] = @"0";

            } else {
                para[@"pay_term"] = @"1";

            }

            para[@"pay_name"] = model.Name;
            para[@"pay_num"] = model.Card;

            
        }else if (i == 8) {
           
            
            para[@"identity1"] = model.leftImageString;
            para[@"identity2"] = model.rightimageString;
            
            
        }else if (i == 9) {
            
            
            para[@"qualification1"] = model.leftImageString;
            para[@"qualification2"] = model.rightimageString;
            
            
        }else if (i == 1) {
            
            if (csCharacterIsBlank(model.content)) {
                para[model.pameterTitle] = @"0";

            } else if ([model.content containsString:@"男"]) {
                para[model.pameterTitle] = @"1";

            }else if ([model.content containsString:@"女"]) {
                para[model.pameterTitle] = @"2";
                
            } else {
                para[model.pameterTitle] = @"0";

            }
            
        } else {
            
            para[model.pameterTitle] = model.content;

        }
        
    }
    
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Masterpost Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"提交成功！");
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = @[].mutableCopy;
        
        DaShiRuZhuModel *model1 = [DaShiRuZhuModel new];
        
        model1.title = @"姓名：";
        model1.cellType = TextFieldCellType;
        model1.placeHolder = @"请输入真实姓名";
        model1.pameterTitle = @"user_name";
        DaShiRuZhuModel *model2 = [DaShiRuZhuModel new];
        
        model2.title = @"性别：";
        model2.cellType = TextFieldCellType;
        model2.placeHolder = @"请输入您的性别";
        model2.pameterTitle = @"sex";

        DaShiRuZhuModel *model3 = [DaShiRuZhuModel new];
        
        model3.title = @"电话：";
        model3.cellType = TextFieldCellType;
         model3.placeHolder = @"请输入您的电话";
        model3.pameterTitle = @"phone";

        
        DaShiRuZhuModel *model4 = [DaShiRuZhuModel new];
        
        model4.title = @"擅长领域：";
        model4.cellType = CollectionCellType;
        model4.pameterTitle = @"skilled_id[]";

        
        DaShiRuZhuModel *model5 = [DaShiRuZhuModel new];
        
        model5.title = @"特长介绍：";
        model5.cellType = TextViewCellType;
        model5.placeHolder = @"一句话介绍自己擅长的方面的闪光点，最强势的亮点！自己的优势最好是有数据支撑；获得的荣誉头衔等";
        model5.pameterTitle = @"speciality";

        DaShiRuZhuModel *model6 = [DaShiRuZhuModel new];
        
        model6.title = @"详细介绍：";
        model6.cellType = TextViewCellType;
        model6.placeHolder = @"一句话介绍自己擅长的方面的闪光点，最强势的亮点！自己的优势最好是有数据支撑；获得的荣誉头衔等";
        model6.pameterTitle = @"detailed";

        DaShiRuZhuModel *model7 = [DaShiRuZhuModel new];
        
        model7.title = @"微信号：";
        model7.cellType = TextFieldCellType;
        model7.placeHolder = @"请输入您的微信号";
        model7.pameterTitle = @"wechat";

        DaShiRuZhuModel *model8 = [DaShiRuZhuModel new];
        
        model8.title = @"收款方式：";
        model8.cellType = ButtonCellType;
        model8.chooseLeft = YES;
        model8.alipayName = @"支付宝姓名：";
        model8.alipayCard = @"支付宝账号：";
        
        DaShiRuZhuModel *model9 = [DaShiRuZhuModel new];
        
        model9.title = @"*身份证：";
        model9.cellType = ImageCellType;
        
        DaShiRuZhuModel *model10 = [DaShiRuZhuModel new];
        
        model10.title = @"*资质图片上传：";
        model10.cellType = ImageCellType;
        
        
        [_listArray addObject:model1];
        
        [_listArray addObject:model2];

        [_listArray addObject:model3];

        [_listArray addObject:model4];

        [_listArray addObject:model5];

        [_listArray addObject:model6];

        [_listArray addObject:model7];

        [_listArray addObject:model8];

        [_listArray addObject:model9];

        [_listArray addObject:model10];

    }
    return _listArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [self configNavigationBar];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self sendGetRequsetForShanChangLingYu];
}
- (void)sendGetRequsetForShanChangLingYu {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Master_Skilled_field Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            self.itemArray = [CSParseManager getDaShiListItemModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            [self.tableView reloadData];
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiRuZhuTextFieldTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiRuZhuTextFieldTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiRuZhuTextViewTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiRuZhuTextViewTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiRuZhuButtonTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiRuZhuButtonTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiRuZhuIdCardTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiRuZhuIdCardTableViewCell)];
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(DaShiRuZhuIdCollectionTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(DaShiRuZhuIdCollectionTableViewCell)];

    
}

- (void)configSubViews {
    
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
}

- (void)configNavigationBar {
    
    
    self.title = @"大师入驻";
    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}

#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiRuZhuModel *model = self.listArray[indexPath.row];
    if (model.cellType == TextFieldCellType) {
        
        DaShiRuZhuTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiRuZhuTextFieldTableViewCell) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    } else if (model.cellType == TextViewCellType) {
        DaShiRuZhuTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiRuZhuTextViewTableViewCell) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    } else if (model.cellType == ButtonCellType) {
        DaShiRuZhuButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiRuZhuButtonTableViewCell) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }else if (model.cellType == CollectionCellType) {
        DaShiRuZhuIdCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiRuZhuIdCollectionTableViewCell) forIndexPath:indexPath];
        cell.itemMutableArray = self.itemArray;
        return cell;
    }
    DaShiRuZhuIdCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(DaShiRuZhuIdCardTableViewCell) forIndexPath:indexPath];
     cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DaShiRuZhuModel *model = self.listArray[indexPath.row];
    if (model.cellType == TextFieldCellType) {
        
        return 45;
    } else if (model.cellType == TextViewCellType) {
      
        
        return 100;
    } else if (model.cellType == ButtonCellType) {
 
        return 113;
    }else if (model.cellType == CollectionCellType) {
       
        return 150;
    }
    
    
    return 149;
}
@end
