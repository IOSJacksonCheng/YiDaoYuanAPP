//
//  XuYuanMingDengViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "XuYuanMingDengViewController.h"
#import "XuYuanMingDengCollectionViewCell.h"
#import "FirstQiYuanJiLuCollectionViewCell.h"

#import "XuYuanMingDengModel.h"

@interface XuYuanMingDengViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
- (IBAction)clickMyWishButtonDone:(id)sender;
- (IBAction)clickChooseMingDengButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL currentClickMyWish;


@property (weak, nonatomic) IBOutlet UIImageView *xuanzemingdengImageView;

@property (weak, nonatomic) IBOutlet UIImageView *wodeyuanwangImageView;
@property (weak, nonatomic) IBOutlet UIButton *mingdengButton;
@property (weak, nonatomic) IBOutlet UIButton *mywishButton;
@property (nonatomic, strong) NSMutableArray *dengArray;
@end

@implementation XuYuanMingDengViewController

- (NSMutableArray *)dengArray {
  
    if (!_dengArray) {
       
        _dengArray = @[].mutableCopy;
        for (int i = 0; i < 2; i ++) {
            XuYuanMingDengModel *model = [XuYuanMingDengModel new];
            model.imageString = @"img_pingan";
            model.title = @"平安灯";
            [_dengArray addObject:model];
            
            XuYuanMingDengModel *model1 = [XuYuanMingDengModel new];
            model1.imageString = @"img_shiye-1";
            model1.title = @"事业灯";
            [_dengArray addObject:model1];
            
            
            
            XuYuanMingDengModel *model2 = [XuYuanMingDengModel new];
            model2.imageString = @"img_yinyuan";
            model2.title = @"姻缘灯";
            [_dengArray addObject:model2];
            
            XuYuanMingDengModel *model3 = [XuYuanMingDengModel new];
            model3.imageString = @"img_jiankang";
            model3.title = @"健康灯";
            [_dengArray addObject:model3];
        }
        
        
       
    }
    
    return _dengArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(MainScreenWidth * 0.333, 192);
    //创建UICollectionView
    self.collectionView.collectionViewLayout = layout;
    
    //设置位置和尺寸
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell的ID
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(FirstQiYuanJiLuCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(FirstQiYuanJiLuCollectionViewCell)];
     [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(XuYuanMingDengCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(XuYuanMingDengCollectionViewCell)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"明灯许愿";
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self getRightButton];
    
}
- (void)getRightButton {
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"icon_more-2") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickRightButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.rightBarButtonItem = leftItem;
}
- (void)clickRightButtonDone {
    
     [self performSegueWithIdentifier:@"MingDengExplainViewController" sender:self];
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)clickMyWishButtonDone:(id)sender {
    
    self.currentClickMyWish = YES;
    self.xuanzemingdengImageView.image = DotaImageName(@"icon_weixuanze-2");
    self.wodeyuanwangImageView.image = DotaImageName(@"icon_xuazne");
    self.title = @"我的愿望";
    self.mingdengButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.mywishButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.collectionView reloadData];

}

- (IBAction)clickChooseMingDengButtonDone:(id)sender {
    self.currentClickMyWish = NO;
    self.mingdengButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.mywishButton.titleLabel.font = [UIFont systemFontOfSize:17];
    self.title = @"明灯许愿";

    self.xuanzemingdengImageView.image = DotaImageName(@"icon_xuazne");
    self.wodeyuanwangImageView.image = DotaImageName(@"icon_weixuanze-2");
     [self.collectionView reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentClickMyWish) {
       return CGSizeMake((MainScreenWidth - 5 * 3) * 0.5, 320);
    }
    return CGSizeMake((MainScreenWidth) * 0.25, 220);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.currentClickMyWish) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.currentClickMyWish) {
return 5;
        
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    if (self.currentClickMyWish) {
        return 5;
        
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dengArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentClickMyWish) {
        FirstQiYuanJiLuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(FirstQiYuanJiLuCollectionViewCell) forIndexPath:indexPath];
        
        
        return cell;
    }
    XuYuanMingDengCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(XuYuanMingDengCollectionViewCell) forIndexPath:indexPath];
    XuYuanMingDengModel *model = self.dengArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentClickMyWish) {
           [self performSegueWithIdentifier:@"QiYuanJiLuViewController" sender:self];
        return;
    }
    [self performSegueWithIdentifier:@"MingDengViewController" sender:self];
    
}
@end
