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

@property (weak, nonatomic) IBOutlet UIPageControl *pageController;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSMutableArray *firstArray;
@property (nonatomic, strong) NSMutableArray *secondArray;
@property (nonatomic, strong) NSMutableArray *thirdArray;
@end
@implementation RightNowConsultTableViewCell
- (NSMutableArray *)firstArray {
    if (!_firstArray) {
         _firstArray = @[].mutableCopy;
        RightNowConsultModel *model1 = [RightNowConsultModel new];
        model1.title = @"婚恋情感";
        model1.imageString = @"icon_1_hunlian";
        [_firstArray addObject:model1];
        
        RightNowConsultModel *model2 = [RightNowConsultModel new];
        model2.title = @"流年运势";
        model2.imageString = @"icon_4_liunian";
        [_firstArray addObject:model2];
        
        
        RightNowConsultModel *model3 = [RightNowConsultModel new];
        model3.title = @"号码吉凶";
        model3.imageString = @"icon_7_haoma";
        [_firstArray addObject:model3];
        
        
        RightNowConsultModel *model4 = [RightNowConsultModel new];
        model4.title = @"事业财运";
        model4.imageString = @"icon_2_shiye";
        [_firstArray addObject:model4];
        
        RightNowConsultModel *model5 = [RightNowConsultModel new];
        model5.title = @"命运详批";
        model5.imageString = @"icon_5_mingyun";
        [_firstArray addObject:model5];
        
        RightNowConsultModel *model6 = [RightNowConsultModel new];
        model6.title = @"求学考试";
        model6.imageString = @"icon_8_qiuxue";
        [_firstArray addObject:model6];
        
        RightNowConsultModel *model7 = [RightNowConsultModel new];
        model7.title = @"占卜断事";
        model7.imageString = @"icon_3_zhanbu";
        [_firstArray addObject:model7];
        
        RightNowConsultModel *model8 = [RightNowConsultModel new];
        model8.title = @"八字合婚";
        model8.imageString = @"icon_6_bazi";
        [_firstArray addObject:model8];
        
        RightNowConsultModel *model9 = [RightNowConsultModel new];
        model9.title = @"健康孕育";
        model9.imageString = @"icon_9_jiankang";
        [_firstArray addObject:model9];
        
       
    }
    return _firstArray;
}
- (NSMutableArray *)secondArray {
    if (!_secondArray) {
        _secondArray = @[].mutableCopy;
        RightNowConsultModel *model1 = [RightNowConsultModel new];
        model1.title = @"婚恋情感";
        model1.imageString = @"icon_1_hunlian";
        [_secondArray addObject:model1];
        
        RightNowConsultModel *model2 = [RightNowConsultModel new];
        model2.title = @"流年运势";
        model2.imageString = @"icon_4_liunian";
        [_secondArray addObject:model2];
        
        
        RightNowConsultModel *model3 = [RightNowConsultModel new];
        model3.title = @"号码吉凶";
        model3.imageString = @"icon_7_haoma";
        [_secondArray addObject:model3];
        
        
        RightNowConsultModel *model4 = [RightNowConsultModel new];
        model4.title = @"事业财运";
        model4.imageString = @"icon_2_shiye";
        [_secondArray addObject:model4];
        
        RightNowConsultModel *model5 = [RightNowConsultModel new];
        model5.title = @"命运详批";
        model5.imageString = @"icon_5_mingyun";
        [_secondArray addObject:model5];
        
        RightNowConsultModel *model6 = [RightNowConsultModel new];
        model6.title = @"求学考试";
        model6.imageString = @"icon_8_qiuxue";
        [_secondArray addObject:model6];
        
        RightNowConsultModel *model7 = [RightNowConsultModel new];
        model7.title = @"占卜断事";
        model7.imageString = @"icon_3_zhanbu";
        [_secondArray addObject:model7];
        
        RightNowConsultModel *model8 = [RightNowConsultModel new];
        model8.title = @"八字合婚";
        model8.imageString = @"icon_6_bazi";
        [_secondArray addObject:model8];
        
        RightNowConsultModel *model9 = [RightNowConsultModel new];
        model9.title = @"健康孕育";
        model9.imageString = @"icon_9_jiankang";
        [_secondArray addObject:model9];
        
        
    }
    return _secondArray;
}
- (NSMutableArray *)thirdArray {
    if (!_thirdArray) {
        _thirdArray = @[].mutableCopy;
        RightNowConsultModel *model1 = [RightNowConsultModel new];
        model1.title = @"婚恋情感";
        model1.imageString = @"icon_1_hunlian";
        [_thirdArray addObject:model1];
        
        RightNowConsultModel *model2 = [RightNowConsultModel new];
        model2.title = @"流年运势";
        model2.imageString = @"icon_4_liunian";
        [_thirdArray addObject:model2];
        
        
        RightNowConsultModel *model3 = [RightNowConsultModel new];
        model3.title = @"号码吉凶";
        model3.imageString = @"icon_7_haoma";
        [_thirdArray addObject:model3];
        
        
        RightNowConsultModel *model4 = [RightNowConsultModel new];
        model4.title = @"事业财运";
        model4.imageString = @"icon_2_shiye";
        [_thirdArray addObject:model4];
        
        RightNowConsultModel *model5 = [RightNowConsultModel new];
        model5.title = @"命运详批";
        model5.imageString = @"icon_5_mingyun";
        [_thirdArray addObject:model5];
        
        RightNowConsultModel *model6 = [RightNowConsultModel new];
        model6.title = @"求学考试";
        model6.imageString = @"icon_8_qiuxue";
        [_thirdArray addObject:model6];
        
        RightNowConsultModel *model7 = [RightNowConsultModel new];
        model7.title = @"占卜断事";
        model7.imageString = @"icon_3_zhanbu";
        [_thirdArray addObject:model7];
        
        RightNowConsultModel *model8 = [RightNowConsultModel new];
        model8.title = @"八字合婚";
        model8.imageString = @"icon_6_bazi";
        [_thirdArray addObject:model8];
        
        RightNowConsultModel *model9 = [RightNowConsultModel new];
        model9.title = @"健康孕育";
        model9.imageString = @"icon_9_jiankang";
        [_thirdArray addObject:model9];
        
        
    }
    return _thirdArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentScrollView.contentSize = CGSizeMake(MainScreenWidth * 3, 316);
    self.contentScrollView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
//    self.contentScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    self.contentScrollView.bounces = NO;
    
    self.contentScrollView.delegate = self;
    
    CGFloat height = 100;
    
    CGFloat X_Interval = 10;
    
    CGFloat XY_Distance = 8;
    
    CGFloat width = (MainScreenWidth - X_Interval *
                     2 - XY_Distance * 2) / 3.0;
    
    NSMutableArray *array = @[self.firstArray, self.secondArray, self.thirdArray].mutableCopy;
    
    for (int j = 0; j < array.count; j ++) {
        
        NSMutableArray *subArray = array[j];
        
        for (int i = 1; i <= subArray.count; i ++) {
            
            RightNowConsultModel *model = subArray[i - 1];
            
            UIView *new = [UIView new];
            
            int x_Times = i / 3 + 1;
            if (i % 3 == 0) {
                x_Times -= 1;
            }
            int y_Times = i % 3;
            if (i % 3 == 0) {
                y_Times = 3;
            }
            
            new.frame = CGRectMake(MainScreenWidth * j + X_Interval + (width + XY_Distance) * (x_Times - 1), (height + XY_Distance) * (y_Times - 1), width, height);
            
            new.backgroundColor = UIColor.whiteColor;
           
            UILabel *label = [[UILabel alloc] init];
           
            
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:model.title attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang-SC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            label.attributedText = string;
            
            label.frame = CGRectMake(26,76,100,14);
            label.numberOfLines = 0;
            
            [new addSubview:label];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 11, 60, 60)];
            imageView.image = DotaImageName(model.imageString);
            [new addSubview:imageView];
            
            [self.contentScrollView addSubview:new];
            
            
        }
    }
    
    
    
}

- (UIView *)getTitleViewWithTitle:(NSString *)title WithImage:(NSString *)imageString {
    
    UIView *contentView = [UIView new];
    
    contentView.backgroundColor = csBlueColor;
    
    return contentView;
    
}

@end
