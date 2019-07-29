//
//  ShopManyProductViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopManyProductViewController.h"
#import "ShopProductCollectionViewCell.h"

#import "ManyProductCollectionViewFlowLayout.h"

#import "ShopProductDetailViewController.h"

@interface ShopManyProductViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, ManyProductCollectionViewFlowLayoutDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSString *recordId;
@end

@implementation ShopManyProductViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
   
    self.listArray = @[].mutableCopy;
    
    [self getNewData];
}
- (void)configTableView {
    
    self.collectionView.backgroundColor = csf5f5f5Color;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
   
    ManyProductCollectionViewFlowLayout * waterFallLayout = [[ManyProductCollectionViewFlowLayout alloc]init];
    
    waterFallLayout.delegate = self;
   
    self.collectionView.collectionViewLayout = waterFallLayout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(ShopProductCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(ShopProductCollectionViewCell)];
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
    
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    self.page = 1;
   para[@"keyword"] = self.passKeyword;
    para[@"category_id"] = self.passCategoryId;

    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Goods_Goodslist Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getShopManyProductModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.collectionView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        [self endRefresh];
        
        CSInternetFailure
    }];
}
- (void)getMoreData {
    NSMutableDictionary *para = @{}.mutableCopy;
    self.page += 1;
    para[@"keyword"] = self.passKeyword;
    para[@"category_id"] = self.passCategoryId;

    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Goods_Goodslist Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getShopManyProductModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
            if (array.count == 0) {
                CustomWrongMessage(@"下面没有数据了！");
            } else {
                [self.listArray addObjectsFromArray:array];
                [self.collectionView reloadData];
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
    if (self.collectionView.mj_header.isRefreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    if (self.collectionView.mj_footer.isRefreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}
- (void)configSubViews {
    
   
}

- (void)configNavigationBar {
    
    
    self.title = @"商品分类";
    
    WhiteNavigationBarColor
    
}
#pragma mark -- UICollectionViewDataSource/Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.listArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(ShopProductCollectionViewCell) forIndexPath:indexPath];
    
    ShopManyProductModel *model = self.listArray[indexPath.row];
    
    cell.model = model;
    
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopManyProductModel *model = self.listArray[indexPath.row];
  
    self.recordId = model.goods_id;
    
    [self performSegueWithIdentifier:@"ShopProductDetailViewController" sender:self];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShopProductDetailViewController"]) {
        ShopProductDetailViewController *new = segue.destinationViewController;
        new.passID = self.recordId;
    }
}
#pragma mark  - <ManyProductCollectionViewFlowLayoutDeleaget>
- (CGFloat)waterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    ShopManyProductModel *model = self.listArray[indexPath];
    
        CGFloat height = [self accrodingTextGiveItHeightWith:[NSString stringWithFormat:@"%@%@",model.goods_name, model.intro]];
    
        if (height - 18 < 0) {
            height = 0;
        } else {
            height -= 18;
        }
        return 237 + height ;
}

- (CGFloat)rowMarginInWaterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout{
    
    return 20;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(ManyProductCollectionViewFlowLayout *)waterFallLayout{
    
    return 2;
    
}
- (CGFloat)accrodingTextGiveItHeightWith:(NSString *)text {
    
    
    
    CGFloat labelWidth = 217;
    
    NSAttributedString *test = [self attributedBodyText:text];
    
    NSStringDrawingOptions options  = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGRect rect = [test boundingRectWithSize:CGSizeMake(labelWidth, 0) options:options context:nil];
    
    
    return (CGFloat)(ceil(rect.size.height) + 20);
    
}
- (NSAttributedString *)attributedBodyText:(NSString *)text {
    
    
    UIFont *font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:15];
    
    NSDictionary *testDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:text attributes:testDic];
    
    return string;
}
@end
