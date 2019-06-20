//
//  QingFoViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QingFoViewController.h"


#import "QingFoViewCollectionViewCell.h"
@interface QingFoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIButton *shengxiaoButton;
@property (weak, nonatomic) IBOutlet UIButton *fozuButton;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *yixuxinyuanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yiyuanmanguirenImageView;

- (IBAction)clickYiXuXinYuanButtonDone:(id)sender;
- (IBAction)clickYiYuanManGuiRenButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yixuxinyuanTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yiyuanmanguirenTopConstraint;
@property (nonatomic, strong) NSMutableArray *imageArray;
@end

@implementation QingFoViewController
- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"img_guangming_1",@"img_guangming_2",@"img_guangming_3",@"img_guangming_1",@"img_guangming_2",@"img_guangming_3"].mutableCopy;
    }
    return _imageArray;
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
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(QingFoViewCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(QingFoViewCollectionViewCell)];
    
}

- (void)configSubViews {
    
}
- (void)configNavigationBar {
    
    self.title = @"神仙供养";
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setImage:DotaImageName(@"img_back") forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(clickLeftButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    
}
- (void)clickLeftButtonDone {
    [self.navigationController popViewControllerAnimated:YES];
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
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QingFoViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(QingFoViewCollectionViewCell) forIndexPath:indexPath];
    NSString *image = self.imageArray[indexPath.row];
    cell.csImageView.image = DotaImageName(image);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
   [self performSegueWithIdentifier:@"QingShengViewController" sender:self];
    
}


- (IBAction)clickYiXuXinYuanButtonDone:(id)sender {
    
    self.yixuxinyuanImageView.image = DotaImageName(@"img_xuanzhong-1");
    self.yixuxinyuanTopConstraint.constant = 20;
    
    [self.fozuButton setTitleColor:[UIColor colorWithHexString:@"763423"] forState:UIControlStateNormal];
    
    [self.shengxiaoButton setTitleColor:[UIColor colorWithHexString:@"4D3D1C"] forState:UIControlStateNormal];
    self.yiyuanmanguirenImageView.image = DotaImageName(@"img_weixuanzhong");
    self.yiyuanmanguirenTopConstraint.constant = 10;
    
}

- (IBAction)clickYiYuanManGuiRenButtonDone:(id)sender {
    
    self.yixuxinyuanImageView.image = DotaImageName(@"img_weixuanzhong");
    self.yixuxinyuanTopConstraint.constant = 10;
    
    [self.fozuButton setTitleColor:[UIColor colorWithHexString:@"4D3D1C"] forState:UIControlStateNormal];
    
    [self.shengxiaoButton setTitleColor:[UIColor colorWithHexString:@"763423"] forState:UIControlStateNormal];
     
    self.yiyuanmanguirenImageView.image = DotaImageName(@"img_xuanzhong-1");
    self.yiyuanmanguirenTopConstraint.constant = 20;
}
@end
