//
//  AfterChatJudgeViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/31.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "AfterChatJudgeViewController.h"

#import "DaShiItemCollectionReusableView.h"
#import "UploadImageCollectionViewCell.h"
@interface AfterChatJudgeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewBottomConstraint;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation AfterChatJudgeViewController

- (void)viewDidLoad {
   
    [super viewDidLoad];
   
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    
}

- (void)configTableView {
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"UploadImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"UploadImageCollectionViewCell"];
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"DaShiItemCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DaShiItemCollectionReusableView"];
    
}
- (void)configSubViews {
    
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
    
    self.showTitleView = YES;
    
    [self.submitButton addTarget:self action:@selector(clickSubmitButtonDone) forControlEvents:UIControlEventTouchDown];
}
- (void)clickSubmitButtonDone {
    
    [self changeAlreadyShowStatus];
    
}
- (void)changeAlreadyShowStatus {
    self.showTitleView = NO;
    self.inputTextView.editable = NO;
    self.inputTextView.textColor = cs333333Color;
    [self.imageCollectionView reloadData];
}
- (void)configNavigationBar {
    F3f3f3NavigationBarColor
    
    self.title = @"评论";
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
}
#pragma mark -- UICollectionViewDataSouce/Delegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (!self.showTitleView) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(self.view.width, 45);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((MainScreenWidth - 10 * 2 - 5 * 2 ) / 3.0, (MainScreenWidth - 10 * 2 - 5 * 2 ) / 3.0);
}
// CGFloat top, left, bottom, right;
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 10, 15, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 2;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UploadImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UploadImageCollectionViewCell" forIndexPath:indexPath];
    if (self.showTitleView) {
        cell.uploadImageView.image = DotaImageName(@"icon_tianjia");
        
    }else {
         cell.uploadImageView.image = DotaImageName(@"img_1-1");
    }
    
    return cell;
    
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.showTitleView) {
        return nil;
    }
    DaShiItemCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"DaShiItemCollectionReusableView" forIndexPath:indexPath];
    
    headerView.itemTitleLabel.text = @"上传图片（0/9）";
    headerView.itemTitleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    headerView.itemTitleLabel.font = csCharacterFont_18;
    headerView.backgroundColor = UIColor.whiteColor;
    
    
    
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    
   
}
@end
