//
//  FirstShenXianQiYuanJiLuViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/20.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "FirstShenXianQiYuanJiLuViewController.h"

#import "FirstQiYuanJiLuCollectionViewCell.h"

#import "QiYuanJiLuViewController.h"
@interface FirstShenXianQiYuanJiLuViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *yixuxinyuanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yiyuanmanguirenImageView;

- (IBAction)clickYiXuXinYuanButtonDone:(id)sender;
- (IBAction)clickYiYuanManGuiRenButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yixuxinyuanTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yiyuanmanguirenTopConstraint;
@property (weak, nonatomic) IBOutlet UIButton *yixuxinyuanButton;
@property (weak, nonatomic) IBOutlet UIButton *yiyuanmanguirenButton;

@property (nonatomic, assign) BOOL clickLeft;

@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, assign) int page;

@property (nonatomic, strong) NSString *recordPassId;
@end

@implementation FirstShenXianQiYuanJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listArray = @[].mutableCopy;
    self.clickLeft = YES;
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self getNewData];
}
- (void)getNewData {
    NSMutableDictionary *para = @{}.mutableCopy;
    self.page = 1;
    if (self.clickLeft) {
        para[@"status"] = @"1";

    } else {
        para[@"status"] = @"2";

    }
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Record Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            self.listArray = [CSParseManager getQiYuanJiLuModelArrayWithResponseObject:CSGetResult[@"lists"]];
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
    if (self.clickLeft) {
        para[@"status"] = @"1";
        
    } else {
        para[@"status"] = @"2";
        
    }
    para[@"page"] = [NSString stringWithFormat:@"%d",self.page];
    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_Consecrate_Record Pameters:para success:^(id  _Nonnull responseObject) {
        [self endRefresh];
        if (CSInternetRequestSuccessful) {
            NSMutableArray *array = [CSParseManager getQiYuanJiLuModelArrayWithResponseObject:CSGetResult[@"lists"]];
            
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
- (void)configTableView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((MainScreenWidth - 10 * 3) * 0.5, 320);
    //创建UICollectionView
    self.collectionView.collectionViewLayout = layout;
    
    //设置位置和尺寸
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册cell的ID
    [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(FirstQiYuanJiLuCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(FirstQiYuanJiLuCollectionViewCell)];
    
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreData)];
}
- (void)configSubViews {
    
}
- (void)configNavigationBar {
    self.title = @"祈愿记录";
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
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    FirstQiYuanJiLuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(FirstQiYuanJiLuCollectionViewCell) forIndexPath:indexPath];
    
    QiYuanJiLuModel *model = self.listArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QiYuanJiLuModel *model = self.listArray[indexPath.row];
    
    self.recordPassId = model.supplication_id;
    
    [self performSegueWithIdentifier:@"QiYuanJiLuViewController" sender:self];
    
}


- (IBAction)clickYiXuXinYuanButtonDone:(id)sender {
    self.clickLeft = YES;
    self.yixuxinyuanImageView.image = DotaImageName(@"img_xuanzhong-2");
    self.yixuxinyuanTopConstraint.constant = 12;
    
    [self.yixuxinyuanButton setTitleColor:[UIColor colorWithHexString:@"763423"] forState:UIControlStateNormal];
    
    [self.yiyuanmanguirenButton setTitleColor:[UIColor colorWithHexString:@"4D3D1C"] forState:UIControlStateNormal];
    self.yiyuanmanguirenImageView.image = DotaImageName(@"img_xuanzhong-3");
    self.yiyuanmanguirenTopConstraint.constant = 8;
    
    [self getNewData];
}

- (IBAction)clickYiYuanManGuiRenButtonDone:(id)sender {
    self.clickLeft = NO;

    self.yixuxinyuanImageView.image = DotaImageName(@"img_xuanzhong-3");
    self.yixuxinyuanTopConstraint.constant = 8;
    
    [self.yixuxinyuanButton setTitleColor:[UIColor colorWithHexString:@"4D3D1C"] forState:UIControlStateNormal];
    
    [self.yiyuanmanguirenButton setTitleColor:[UIColor colorWithHexString:@"763423"] forState:UIControlStateNormal];
    
    self.yiyuanmanguirenImageView.image = DotaImageName(@"img_xuanzhong-2");
    
    self.yiyuanmanguirenTopConstraint.constant = 12;
    
    [self getNewData];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QiYuanJiLuViewController"]) {
        QiYuanJiLuViewController *new = segue.destinationViewController;
        new.pass_ID = self.recordPassId;
    }
}
@end
