//
//  CSTabBar.h
//  pgapp
//
//  Created by 指意达 on 17/2/15.
//  Copyright © 2017年 shoubinCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSTabBar;

@protocol CSTabBarDelegate <UITabBarDelegate>

-(void)tabBarDidClickCenterButton:(CSTabBar *)tabBar;

@end
@interface CSTabBar : UITabBar
@property(nonatomic,weak) id<CSTabBarDelegate> delegate;
@property(nonatomic,strong)UIButton *centerButton;

@end
