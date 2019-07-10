//
//  QingFoViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "QingFoViewController.h"


#import "QingFoViewCollectionViewCell.h"

#import "QingShengViewController.h"
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
@property (nonatomic, strong) NSMutableArray *leftArray;

@property (nonatomic, strong) NSMutableArray *rightArray;

@property (nonatomic, assign) BOOL clickLeftButton;

@property (nonatomic, strong) FoAndShenXianModel *recordModel;
@end

@implementation QingFoViewController
- (FoAndShenXianModel *)recordModel {
    if (!_recordModel) {
        _recordModel = [FoAndShenXianModel new];
    }
    return _recordModel;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.clickLeftButton = YES;
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self sendGetRequest];
    
}
- (void)sendGetRequest {
    NSMutableDictionary *para = @{}.mutableCopy;
   
    para[@"type_id"] = self.passTag;
    
    [CSNetManager sendGetRequestWithNeedToken:NO Url:CSURL_Portal_Consecrate_Buddha Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            
            
            NSArray *listArray = CSGetResult[@"lists"];
            
            if (listArray.count == 0) {
                return;
            }
            [self.fozuButton setTitle:[NSString stringWithFormat:@"%@",listArray[0][@"title"]] forState:UIControlStateNormal];
            self.leftArray = [CSParseManager getFoAndShenXianModelArrayWithResponseObject:listArray[0][@"buddhas"]];
            
            self.rightArray = [CSParseManager getFoAndShenXianModelArrayWithResponseObject:listArray[1][@"buddhas"]];
            [self.shengxiaoButton setTitle:[NSString stringWithFormat:@"%@",listArray[1][@"title"]] forState:UIControlStateNormal];

            [self.collectionView reloadData];
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
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
    
    self.leftArray = @[].mutableCopy;
    
    self.rightArray = @[].mutableCopy;
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
    if (self.clickLeftButton) {
        return self.leftArray.count;
    }
    return self.rightArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QingFoViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(QingFoViewCollectionViewCell) forIndexPath:indexPath];
    FoAndShenXianModel *model = [FoAndShenXianModel new];
    
    
    if (self.clickLeftButton) {
        model =  self.leftArray[indexPath.row];
    } else {
        model =  self.rightArray[indexPath.row];

    }
    cell.model = model;

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    FoAndShenXianModel *model = [FoAndShenXianModel new];
    
    
    if (self.clickLeftButton) {
        model =  self.leftArray[indexPath.row];
    } else {
        model =  self.rightArray[indexPath.row];
        
    }
    self.recordModel = model;
   [self performSegueWithIdentifier:@"QingShengViewController" sender:self];
    
}


- (IBAction)clickYiXuXinYuanButtonDone:(id)sender {
    self.clickLeftButton = YES;
    self.yixuxinyuanImageView.image = DotaImageName(@"img_xuanzhong-1");
    self.yixuxinyuanTopConstraint.constant = 20;
    
    [self.fozuButton setTitleColor:[UIColor colorWithHexString:@"763423"] forState:UIControlStateNormal];
    
    [self.shengxiaoButton setTitleColor:[UIColor colorWithHexString:@"4D3D1C"] forState:UIControlStateNormal];
    self.yiyuanmanguirenImageView.image = DotaImageName(@"img_weixuanzhong");
    self.yiyuanmanguirenTopConstraint.constant = 10;
    [self.collectionView reloadData];

}

- (IBAction)clickYiYuanManGuiRenButtonDone:(id)sender {
    
    self.clickLeftButton = NO;

    self.yixuxinyuanImageView.image = DotaImageName(@"img_weixuanzhong");
    self.yixuxinyuanTopConstraint.constant = 10;
    
    [self.fozuButton setTitleColor:[UIColor colorWithHexString:@"4D3D1C"] forState:UIControlStateNormal];
    
    [self.shengxiaoButton setTitleColor:[UIColor colorWithHexString:@"763423"] forState:UIControlStateNormal];
     
    self.yiyuanmanguirenImageView.image = DotaImageName(@"img_xuanzhong-1");
    self.yiyuanmanguirenTopConstraint.constant = 20;
    
    [self.collectionView reloadData];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"QingShengViewController"]) {
        QingShengViewController *new = segue.destinationViewController;
        new.passModel = self.recordModel;
    }
}
@end
