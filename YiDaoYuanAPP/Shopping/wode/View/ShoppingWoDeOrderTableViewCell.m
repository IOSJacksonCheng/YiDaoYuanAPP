//
//  ShoppingWoDeOrderTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShoppingWoDeOrderTableViewCell.h"
@interface ShoppingWoDeOrderTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *allView;
@property (weak, nonatomic) IBOutlet UIView *daifukuanView;
@property (weak, nonatomic) IBOutlet UIView *daifahuoView;
@property (weak, nonatomic) IBOutlet UIView *daishouhuoView;
@property (weak, nonatomic) IBOutlet UIView *yiwanchengView;

@end
@implementation ShoppingWoDeOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAllViewDone)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.allView addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickdaifukuanViewDone)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    
    [self.daifukuanView addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickdaifahuoViewDone)];
    tap2.numberOfTapsRequired = 1;
    tap2.numberOfTouchesRequired = 1;
    
    [self.daifahuoView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickdaishouhuoViewDone)];
    tap3.numberOfTapsRequired = 1;
    tap3.numberOfTouchesRequired = 1;
    
    [self.daishouhuoView addGestureRecognizer:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickyiwanchengViewDone)];
    tap4.numberOfTapsRequired = 1;
    tap4.numberOfTouchesRequired = 1;
    
    [self.yiwanchengView addGestureRecognizer:tap4];
    
    
}
- (void)clickyiwanchengViewDone {
    [self.csDelegate goWhichTag:10];
}
- (void)clickdaishouhuoViewDone {
     [self.csDelegate goWhichTag:2];
}
- (void)clickdaifahuoViewDone {
     [self.csDelegate goWhichTag:1];
}
- (void)clickdaifukuanViewDone {
     [self.csDelegate goWhichTag:0];
}
- (void)clickAllViewDone {
    [self.csDelegate goWhichTag:100];
}

@end
