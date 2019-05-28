//
//  DaShiListItemView.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiListItemView.h"
#import "DaShiListCollectionView.h"

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
       
        
        UIView *whiteView = [UIView new];
        
        whiteView.backgroundColor = UIColor.whiteColor;
//        whiteView.alpha = 1;
        [self addSubview:whiteView];
        CGFloat width = 100;
        [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(width);
             make.top.mas_equalTo(0);
             make.bottom.mas_equalTo(0);
            make.right.mas_equalTo(0);
            
        }];
        
        self.collectionView = [[DaShiListCollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - width, frame.size.height - 46) collectionViewLayout: [[UICollectionViewFlowLayout alloc] init]];
        self.collectionView.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.collectionView.itemMutableArray = @[].mutableCopy;
        [whiteView addSubview:self.collectionView];
        
        UIButton *button = [[UIButton alloc] init];
        
        [button setTitle:@"重置" forState:UIControlStateNormal];
        
        [button setBackgroundColor:[UIColor colorWithHexString:@"E1E1E1"]];
        
        [button setTitleColor:cs333333Color forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [whiteView addSubview:button];
        
        UIButton *button1 = [[UIButton alloc] init];
        
        [button1 setTitle:@"确定" forState:UIControlStateNormal];
        
        [button1 setBackgroundColor:[UIColor colorWithHexString:@"0D71C8"]];
        
        [button1 setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [whiteView addSubview:button1];
        
        button.layer.cornerRadius = 5;
        
        button1.layer.cornerRadius = 5;
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(27);
            make.bottom.mas_equalTo(-14);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-27);
            make.bottom.mas_equalTo(-14);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(30);
        }];
        
        
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
- (void)setItemArray:(NSMutableArray *)itemArray {
  
    _itemArray = itemArray;
    
    self.collectionView.itemMutableArray = itemArray;
    
    
    
}
@end
