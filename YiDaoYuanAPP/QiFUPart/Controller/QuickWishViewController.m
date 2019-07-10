//
//  QuickWishViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QuickWishViewController.h"

#import "DaShiItemCollectionViewCell.h"
@interface QuickWishViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;
@property (nonatomic, strong) NSMutableArray *itemMutableArray;
- (IBAction)clickRightNowWishButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *remindLabel;
@property (weak, nonatomic) IBOutlet UITextView *wishTextView;

@end

@implementation QuickWishViewController
- (NSMutableArray *)itemMutableArray {
    
    if (!_itemMutableArray) {
    
        _itemMutableArray = @[].mutableCopy;
        
    }
    
    return _itemMutableArray;
}

- (IBAction)clickRightNowWishButtonDone:(id)sender {
    
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"buddha_id"] = self.passBuddaId;
    
    para[@"wish"] = self.wishTextView.text;

    
    NSMutableArray *array = @[].mutableCopy;
    for (DaShiListItemModel *model in self.itemMutableArray) {
        if (model.choose) {
            [array addObject:model.idString];
        }
    }
    
    for (int i = 0; i < array.count; i ++) {
        
        para[[NSString stringWithFormat:@"wish_ids[%d]",i]] = array[i];

    }
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Supplication Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            if (self.fromDeng) {
                [self sendDianDengRequest:[NSString stringWithFormat:@"%@",CSGetResult[@"supplication_id"]]];
            } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    

    
}
- (void)sendDianDengRequest:(NSString *)supplicationId {
    
    NSMutableDictionary *para = @{}.mutableCopy;
    
    para[@"supplication_id"] = supplicationId;
    para[@"price_id"] = self.passPriceId;

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Consecrate_Addlamp Pameters:para success:^(id  _Nonnull responseObject) {
        
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
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self sendGetRequest];
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Hotwish Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.itemMutableArray = [CSParseManager getQuickWishModelArrayWithResponseObject:CSGetResult[@"lists"]];
            [self.itemCollectionView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)configTableView {
    self.itemCollectionView.delegate = self;
    self.itemCollectionView.dataSource = self;

    self.itemCollectionView.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.itemCollectionView registerNib:[UINib nibWithNibName:CSCellName(DaShiItemCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell)];
    
    self.itemCollectionView.showsHorizontalScrollIndicator = NO;
    self.itemCollectionView.showsVerticalScrollIndicator = NO;
    
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    self.title = @"快速许愿";
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    
   
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.row];
    
    float wordWidth = 15;
    
    
    
    return CGSizeMake(wordWidth * model.title.length, 26);
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
//    return UIEdgeInsetsMake(5, 5, 5, 5);
        return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.itemMutableArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DaShiItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(DaShiItemCollectionViewCell) forIndexPath:indexPath];
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.row];
    
    cell.wishModel = model;
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DaShiListItemModel *model = self.itemMutableArray[indexPath.row];
    
    
    
    
    
    model.choose = !model.choose;
    
    
    
    
    [self.itemCollectionView reloadData];
    
}
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length != 0) {
        self.remindLabel.hidden = YES;
    } else {
        self.remindLabel.hidden = NO;
    }
}
@end
