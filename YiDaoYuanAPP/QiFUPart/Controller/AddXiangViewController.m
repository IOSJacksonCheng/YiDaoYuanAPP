//
//  AddXiangViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AddXiangViewController.h"
#import "GongPingCollectionViewCell.h"

#import "YiDaoYuanChongZhiViewController.h"

NSString * const xianGuoString = @"献果";
NSString * const xianXiangString = @"敬香";

NSString * const xianHuaString = @"献花";
NSString * const jingShiString = @"敬食";
@interface AddXiangViewController ()<UICollectionViewDelegate ,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *moneyView;
- (IBAction)clickCloseButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *otherFuFeiImageView;
@property (weak, nonatomic) IBOutlet UILabel *otherFuFeiTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *otherFuFeiButton;
@property (weak, nonatomic) IBOutlet UILabel *otherFuFeiSubLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) GongPingModel *currentModel;
- (IBAction)clickSureButtonDone:(id)sender;
@end

@implementation AddXiangViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getNewData];
    
}

- (void)getNewData {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"cat_id"] = self.passCatId;
   
    para[@"pageSize"] = @"100";
   
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getGongPingModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.collectionView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
- (void)configTableView {
  

    self.listArray = @[].mutableCopy;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //创建UICollectionView
    self.collectionView.collectionViewLayout = layout;
    
    //设置位置和尺寸
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell的ID#import "GongPingCollectionViewCell.h"

    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(GongPingCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(GongPingCollectionViewCell)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = self.passString;
    
    WhiteNavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    
    
    if ([self.passString isEqualToString:xianGuoString]) {
        self.otherFuFeiImageView.image = DotaImageName(@"img_pingan-1");
        
    } else if ([self.passString isEqualToString:xianHuaString]) {
        self.otherFuFeiImageView.image = DotaImageName(@"img_huaping");
       
    } else if ([self.passString isEqualToString:jingShiString]){
        self.otherFuFeiImageView.image = DotaImageName(@"img_1_hongguo");
        
    }
}

- (IBAction)clickCloseButtonDone:(id)sender {
    
    self.moneyView.hidden = YES;
    
}

#pragma mark --UICollectionDelegate/DataSource
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(MainScreenWidth * 0.333, 270);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    GongPingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(GongPingCollectionViewCell) forIndexPath:indexPath];
    
    
        GongPingModel *model = self.listArray[indexPath.row];
    
        cell.model = model;
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GongPingModel *model = self.listArray[indexPath.row];
    
    self.currentModel = model;
    
    [self.otherFuFeiImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];
    
    self.otherFuFeiTitleLabel.text = model.name;
    self.otherFuFeiSubLabel.text = model.intro;
    self.moneyView.hidden = NO;
    
}
- (void)sendGongPing {
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"tribute_id"] = self.currentModel.idString;
    para[@"supplication_id"] = self.passSuppliationId;;
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Paytribute Pameters:para success:^(id  _Nonnull responseObject) {
        
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        
        if ([code isEqualToString:@"-1"]) {
            
            CustomWrongMessage(@"易道元不足");
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            YiDaoYuanChongZhiViewController *new = [mainStoryboard instantiateViewControllerWithIdentifier:@"YiDaoYuanChongZhiViewController"];
            
            
            new.fromGongPing = YES;
            
            [self.navigationController pushViewController:new animated:YES];
            
            return;
            
        }
        
        if (CSInternetRequestSuccessful) {
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",CSGetResult[@"coin"]] forKey:@"CS_Coin"];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (IBAction)clickSureButtonDone:(id)sender {
    
    [self sendGongPing];
}
@end
