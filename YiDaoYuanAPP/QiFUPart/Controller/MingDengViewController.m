//
//  MingDengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "MingDengViewController.h"

#import "MindDengTableViewCell.h"

#import "QuickWishViewController.h"
@interface MingDengViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickCloseButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *diandengView;
- (IBAction)clickBeginDianDengDone:(id)sender;
- (IBAction)clickNextButtonDone:(UIButton *)sender;

@property (nonatomic, strong) NSMutableArray *dengArray;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (weak, nonatomic) IBOutlet UILabel *suitPeopleLabl;
@property (weak, nonatomic) IBOutlet UIImageView *dengImageView;
@property (nonatomic, strong) NSString *recordPriceId;
@end

@implementation MingDengViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    self.dengArray = @[].mutableCopy;
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getRequest];
}
- (void)getRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"lamp_id"] = self.passLampId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Lampinfo Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.csTitleLabel.text = [NSString stringWithFormat:@"%@",CSGetResult[@"name"]];
            self.introduceLabel.text = [NSString stringWithFormat:@"%@",CSGetResult[@"intro"]];
self.suitPeopleLabl.text = [NSString stringWithFormat:@"%@",CSGetResult[@"suit"]];
            
            [self.dengImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",CSGetResult[@"icon"]]] placeholderImage:PlaceHolderImage];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableView registerNib:[UINib nibWithNibName:CSCellName(MindDengTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(MindDengTableViewCell)];
    self.tableView.rowHeight = 80;
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
   
    self.title = @"心愿点灯";
   
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)clickCloseButton:(id)sender {
    self.diandengView.hidden = YES;
}
- (IBAction)clickBeginDianDengDone:(id)sender {
    [self getLampPrice];
}

- (IBAction)clickNextButtonDone:(UIButton *)sender {
    BOOL goOn = NO;
    for (DengPriceModel *model in self.dengArray) {

        if (model.choose) {
            goOn = YES;
            break;
        }
    }
    if (!goOn) {
        CustomWrongMessage(@"请选择点灯类型");
        return;
    }
    [self sendDianDengRequest:self.supplicationId];
   
}
- (void)sendDianDengRequest:(NSString *)supplicationId {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"supplication_id"] = supplicationId;
    para[@"price_id"] = self.recordPriceId;
    
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Consecrate_Addlamp Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"coin"]] forKey:@"CS_Coin"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"QuickWishViewController"]) {
        QuickWishViewController *new = segue.destinationViewController;
        new.passBuddaId = self.passBuddahaId;
        new.passPriceId = self.recordPriceId;
    }
}
#pragma mark --UITableViewDelegate/DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    for (DengPriceModel *model in self.dengArray) {
        model.choose = NO;
    }
    DengPriceModel *model = self.dengArray[indexPath.section];

    model.choose = YES;
    self.recordPriceId = model.price_id;
    [self.tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dengArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    MindDengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(MindDengTableViewCell)];
    
    DengPriceModel *model = self.dengArray[indexPath.section];
    cell.model = model;
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = CSColorRGBA(187, 57, 35, 1);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}
- (void)getLampPrice {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"lamp_id"] = self.passLampId;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Consecrate_Lampprice Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.dengArray = [CSParseManager getDengPriceModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.tableView reloadData];
            self.diandengView.hidden = NO;

        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
@end
