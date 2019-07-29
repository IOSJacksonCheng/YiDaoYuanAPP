//
//  ShopSureOrderAddAddressViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopSureOrderAddAddressViewController.h"

#import "ShoppingAddressTableViewCell.h"

#import "NewAddressViewController.h"
@interface ShopSureOrderAddAddressViewController ()<UITableViewDelegate, UITableViewDataSource, ShoppingAddressTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
@property (weak, nonatomic) IBOutlet UIButton *addressButton;
- (IBAction)clickAddressButtonDone:(id)sender;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) AddressModel *recordModel;
@end

@implementation ShopSureOrderAddAddressViewController
- (AddressModel *)recordModel {
    if (!_recordModel) {
        _recordModel = AddressModel.new;
    }
    return _recordModel;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self sendGetRequest];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self sendGetRequest];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_User_Addresslist Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getAddressModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.addressTableView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    self.addressTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.addressTableView registerNib:[UINib nibWithNibName:CSCellName(ShoppingAddressTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ShoppingAddressTableViewCell)];
  
    
    
    
    
}

- (void)configSubViews {
    
    self.addressButton.layer.cornerRadius = 7;
}

- (void)configNavigationBar {
    
    
    self.title = @"收货地址";
    
    WhiteNavigationBarColor
    
}

- (IBAction)clickAddressButtonDone:(id)sender {
     [self performSegueWithIdentifier:@"NewAddressViewController" sender:self];
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ShoppingAddressTableViewCell)];
    cell.model = self.listArray[indexPath.row];
    cell.csDelegate = self;
    return cell;
}
- (void)modifyAddres:(AddressModel *)model {
    self.recordModel = model;
     [self performSegueWithIdentifier:@"NewAddressViewController" sender:nil];
}
- (void)changeAddressMoRenButton:(AddressModel *)model {
    for (AddressModel *changemodel in self.listArray) {
        if ([changemodel.shipp_id isEqualToString:model.shipp_id]) {
            changemodel.status = YES;
        } else {
            changemodel.status = NO;
        }
    }
    
    [self.addressTableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    AddressModel *model = self.listArray[indexPath.row];
    
    [self.csDelegate clickAddressModel:model];
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        AddressModel *model = self.listArray[indexPath.row];
        
        NSMutableDictionary *para = @{}.mutableCopy;
        
        para[@"shipp_id"] = model.shipp_id;
       
        [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_User_CSDeladdres Pameters:para success:^(id  _Nonnull responseObject) {
            
            if (CSInternetRequestSuccessful) {
                [self.listArray removeObjectAtIndex:indexPath.row];
                [self.addressTableView reloadData];
                
            }else {
                CSShowWrongMessage
            }
        } failure:^(NSError * _Nonnull error) {
            CSInternetFailure
        }];
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"NewAddressViewController"]) {
        NewAddressViewController *new = segue.destinationViewController;
        new.passModel = self.recordModel;
    }
}
@end
