//
//  RightNowConsultTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "RightNowConsultTableViewCell.h"
#import "RightNowConsultModel.h"
@interface RightNowConsultTableViewCell()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *topLabel;

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, assign) NSInteger currentPage;
@end
@implementation RightNowConsultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    self.contentScrollView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
//    self.contentScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    self.contentScrollView.bounces = NO;
    
    self.contentScrollView.delegate = self;

    
}

- (UIView *)getTitleViewWithTitle:(NSString *)title WithImage:(NSString *)imageString {
    
    UIView *contentView = [UIView new];
    
    contentView.backgroundColor = csBlueColor;
    
    return contentView;
    
}
- (void)setItemArray:(NSMutableArray *)itemArray {
    
    _itemArray = itemArray;
    
     self.contentScrollView.contentSize = CGSizeMake(MainScreenWidth * self.itemArray.count, 316);
    self.pageController.numberOfPages = self.itemArray.count;
    
    [self configSubViews];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint offset =  scrollView.contentOffset;
    
    int page = offset.x / CGRectGetWidth(scrollView.frame);
    
    self.pageController.currentPage = page;
    
    self.currentPage = page;
    RightNowConsultModel *supModel = self.itemArray[page];

    self.topLabel.text = supModel.title;
}
- (void)configSubViews {
    CGFloat height = 100;
    
    CGFloat X_Interval = 10;
    
    CGFloat XY_Distance = 8;
    
    CGFloat width = (MainScreenWidth - X_Interval *
                     2 - XY_Distance * 2) / 3.0;
    
    NSMutableArray *array = self.itemArray;
    
    for (int j = 0; j < array.count; j ++) {
        
        RightNowConsultModel *supModel = array[j];
        
        for (int i = 1; i <= supModel.items.count; i ++) {
            
            RightNowConsultModel *model = supModel.items[i - 1];
            
            UIView *new = [UIView new];
            new.tag = i;
            int y_Times = i / 3 + 1;
            if (i % 3 == 0) {
                y_Times -= 1;
            }
            int x_Times = i % 3;
            if (i % 3 == 0) {
                x_Times = 3;
            }
            
            new.frame = CGRectMake(MainScreenWidth * j + X_Interval + (width + XY_Distance) * (x_Times - 1), (height + XY_Distance) * (y_Times - 1), width, height);
            
            new.backgroundColor = UIColor.whiteColor;
            
            UILabel *label = [[UILabel alloc] init];
            
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.subTitle attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            
            label.frame = CGRectMake(26,76,100,14);
            label.numberOfLines = 0;
            
            [new addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 11, 60, 60)];
           
           
            [new addSubview:imageView];
            
            [self.contentScrollView addSubview:new];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickView:)];
            tap.numberOfTapsRequired = 1;
            tap.numberOfTouchesRequired = 1;
            [new addGestureRecognizer:tap];
             [imageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:PlaceHolderImage];
        }
    }
}
- (void)clickView:(UITapGestureRecognizer *)tap {
    UIView *view = tap.view;
   
    CSLog(@"%ld",view.tag);
    
   BOOL jump = [[NSUserDefaults standardUserDefaults] boolForKey:@"jump"];
    if (jump) {
         [self.csDelegate passCurrentSection:self.currentPage WithRow:view.tag - 1];
        [[CSUtility getCurrentViewController] performSegueWithIdentifier:@"DaShiListViewController" sender:self];
        return;
    }
    
    [self.csDelegate passCurrentSection:self.currentPage WithRow:view.tag - 1];
}
@end
