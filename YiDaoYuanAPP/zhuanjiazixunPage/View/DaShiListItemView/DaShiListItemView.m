//
//  DaShiListItemView.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiListItemView.h"
#import "DaShiListCollectionView.h"
#import "DaShiListItemModel.h"
@interface DaShiListItemView()
@property (nonatomic, strong) DaShiListCollectionView *collectionView;
@end
@implementation DaShiListItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIColor *backGroundColor = [UIColor colorWithHexString:@"000000"];
        self.backgroundColor = [backGroundColor colorWithAlphaComponent:0.7];
       
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(100, 0, frame.size.width - 100, frame.size.height)];
//        whiteView.backgroundColor = UIColor.greenColor;
        whiteView.backgroundColor = UIColor.whiteColor;
//        whiteView.alpha = 1;
        [self addSubview:whiteView];
//        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(width);
//             make.top.mas_equalTo(0);
//             make.bottom.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//
//        }];
        
        self.collectionView = [[DaShiListCollectionView alloc] initWithFrame:CGRectMake(0, 0, whiteView.bounds.size.width, MainScreenHeight - 120) collectionViewLayout: [[UICollectionViewFlowLayout alloc] init]];
        self.collectionView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        [whiteView addSubview:self.collectionView];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(27, self.collectionView.bounds.size.height + 10, 100, 30)];
        
        [button setTitle:@"重置" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickRestartDone) forControlEvents:UIControlEventTouchDown];
        [button setBackgroundColor:[UIColor colorWithHexString:@"E1E1E1"]];
        
        [button setTitleColor:cs333333Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [whiteView addSubview:button];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(whiteView.bounds.size.width - 27 - 100, self.collectionView.bounds.size.height + 10, 100, 30)];
        
        [button1 setTitle:@"确定" forState:UIControlStateNormal];
        [button1 addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchDown];
        [button1 setBackgroundColor:[UIColor colorWithHexString:@"0D71C8"]];
        
        [button1 setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [whiteView addSubview:button1];
        
        button.layer.cornerRadius = 5;
        
        button1.layer.cornerRadius = 5;
        
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(27);
//            make.bottom.mas_equalTo(-14);
//            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(30);
//        }];
//        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.mas_equalTo(-27);
//            make.bottom.mas_equalTo(-14);
//            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(30);
//        }];
        
        
        UIView *closeView = [UIView new];
        
        [self addSubview:closeView];
        
        [closeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(100);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCloseView)];
        
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        
        [closeView addGestureRecognizer:tap];
        
    }
    
    return self;
}
- (void)clickCloseView {
    [self.csDelegate clickCloseViewDone];
}

- (void)setQitaArray:(NSMutableArray *)qitaArray {
    _qitaArray = qitaArray;
    self.collectionView.qitaArray = qitaArray;
}
- (void)setMingLiArray:(NSMutableArray *)mingLiArray {
    _mingLiArray = mingLiArray;
    
    self.collectionView.mingLiArray = mingLiArray;
}
- (void)setShengxiaoArray:(NSMutableArray *)shengxiaoArray {
    _shengxiaoArray = shengxiaoArray;
    self.collectionView.shengxiaoArray = shengxiaoArray;
}
- (void)clickSureButton {
    [self.csDelegate clickSureButton];
}
- (void)clickRestartDone {
    for (DaShiListItemModel *model in self.shengxiaoArray) {
        model.choose = NO;
    }
    for (DaShiListItemModel *model in self.qitaArray) {
        model.choose = NO;
    }
    for (DaShiListItemModel *model in self.mingLiArray) {
        model.choose = NO;
    }
    [self.collectionView refreshView];
}
@end
