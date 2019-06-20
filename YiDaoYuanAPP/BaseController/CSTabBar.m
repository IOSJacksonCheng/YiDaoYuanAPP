//
//  CSTabBar.m
//  pgapp
//
//  Created by 指意达 on 17/2/15.
//  Copyright © 2017年 shoubinCheng. All rights reserved.
//

#import "CSTabBar.h"
@interface CSTabBar ()
//@property(nonatomic,weak)UIButton *centerButton;
@property (nonatomic, weak) UILabel *centerLabel;

@end
@implementation CSTabBar
@dynamic delegate;
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
        //创建一个UIButton的实例
        
        
        
        UIButton *centerButton = [[UIButton alloc]init];
        
        UIImage *customImg = [UIImage animatedImageNamed:@"icon_qifu_1" duration:2];
        [centerButton setImage:DotaImageName(@"icon_qifu_1") forState:UIControlStateNormal];
        [centerButton setImage:customImg forState:UIControlStateHighlighted];
//        centerButton.frame = CGRectMake(0, 0, centerButton.currentImage.size.width, centerButton.currentImage.size.height);
        centerButton.frame = CGRectMake(0, 0, 40, 40);
        //以子视图的形式添加到TabBar中
        [self addSubview:centerButton];
        self.centerButton = centerButton;

        //为button添加点击事件
        [centerButton addTarget:self action:@selector(centerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 10)];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"祈福" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 10],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
        
        label.attributedText = string;
        [self addSubview:label];
        
        self.centerLabel = label;
//        self.centerImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"icon_qifu_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//
//        self.centerImageView.frame = CGRectMake(0, -25, 50, 50);
//
//        NSMutableArray *allImage = [NSMutableArray array];
//
//        for (int i = 1; i < 6; i ++) {
//
//            NSString *rightCellName = [NSString stringWithFormat:@"icon_qifu_%d",i];
//
//            UIImage *image = [UIImage imageNamed:rightCellName];
//
//            [allImage addObject:image];
//
//        }
//
//        [self.centerImageView setAnimationImages:allImage];
//
//        self.centerImageView.animationRepeatCount = 0;
//
//        self.centerImageView.animationDuration = 0.2 * 3 ;
//
//
//        [self addSubview:self.centerImageView];
//
        
    }
    return self;
}
-(void)centerButtonClick
{
    if([self.delegate respondsToSelector:@selector(tabBarDidClickCenterButton:)]){
        [self.delegate tabBarDidClickCenterButton:self];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1.设置中间按钮的位置
    if (IPHONE_X) {
        self.centerButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5 - 30);
          self.centerLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    } else {
        self.centerButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5 - 15);
         self.centerLabel.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5 + 15);
    }
    
//    self.centerImageView.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    //计算每个UITabBarButton的宽
    CGFloat tabbarButtonW = self.bounds.size.width/5;
    CGFloat buttonIndex = 0;
    CGFloat labelIndex = 0;
   
    
    //2.设置系统根据子vc创建的4个UITabBarButton的位置
    for (UIView *child in self.subviews) {
        //根据字符串做类名，找到该类型的类型信息
        Class class = NSClassFromString(@"UITabBarButton");
        Class class1 = NSClassFromString(@"UITabBarLabel");
        if ([child isKindOfClass:class1]) {
            CGRect frame = child.frame;
            //改子视图的宽
            frame.size.width = tabbarButtonW;
            //改子视图的x
            frame.origin.x = buttonIndex*tabbarButtonW;
            //再把改完的frame赋会给button
            child.frame = frame;
            labelIndex++;
            if (labelIndex==2) {
                labelIndex++;
            }
        }
        //判断当前遍历到的子视图是否是class类型
        if ([child isKindOfClass:class]) {
            //先拿出button原有的frame
            CGRect frame = child.frame;
            //改子视图的宽
            frame.size.width = tabbarButtonW;
            //改子视图的x
            frame.origin.x = buttonIndex*tabbarButtonW;
            //再把改完的frame赋会给button
            child.frame = frame;
            buttonIndex++;
            if (buttonIndex==2) {
                buttonIndex++;
            }
        }
    }
}


@end
