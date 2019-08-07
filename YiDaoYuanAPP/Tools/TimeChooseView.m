//
//  TimeChooseView.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/8/7.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "TimeChooseView.h"
@interface TimeChooseView()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *pickView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (strong, nonatomic) NSMutableArray *yearArray; // 年数组
@property (strong, nonatomic) NSMutableArray *monthArray; // 月数组
@property (strong, nonatomic) NSMutableArray *dayArray; // 日数组
@property (strong, nonatomic) NSMutableArray *hourArray; // 时数组
@property (strong, nonatomic) NSMutableArray *minuteArray; // 分数组

@end
@implementation TimeChooseView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self configSubViewsWithFrame:frame];
    }
    
    return self;
}
- (void)configSubViewsWithFrame:(CGRect)frame {
 
    UIColor *backGroundColor = [UIColor colorWithHexString:@"000000"];
    
    self.backgroundColor = [backGroundColor colorWithAlphaComponent:0.7];
  
    CGFloat whiteviewHeight = 200;
   
    CGFloat whiteviewWidth = frame.size.width;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - whiteviewHeight, whiteviewWidth, whiteviewHeight)];
    
    
    whiteView.backgroundColor = UIColor.whiteColor;
    
    [self addSubview:whiteView];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 80, 45)];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    cancelButton.titleLabel.font = csCharacterFont_15;
    
    [cancelButton addTarget:self action:@selector(clickCancelButtonDone) forControlEvents:UIControlEventTouchDown];
    [self addSubview:cancelButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(whiteviewWidth - 20, 10, 80, 45)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    sureButton.titleLabel.font = csCharacterFont_15;
    [sureButton addTarget:self action:@selector(clickSureButtonDone) forControlEvents:UIControlEventTouchDown];

    [self addSubview:sureButton];
    
    CGFloat pickViewHeight = whiteviewHeight - 45 - 10 - 10;
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, whiteviewHeight - pickViewHeight, whiteviewWidth, pickViewHeight)];
    
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    [self addSubview:self.pickView];
    
    self.dayArray = @[self.yearArray,self.monthArray,self.dayArray,self.hourArray,self.minuteArray].mutableCopy;
    [self.pickView reloadAllComponents];
    
}
- (void)clickSureButtonDone {
    
}
- (void)clickCancelButtonDone {
    self.hidden = YES;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArray.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.dataArray[component] count];
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  self.dataArray[component][row];
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 44)];
    myView.font = [UIFont systemFontOfSize:15];
    myView.textAlignment = NSTextAlignmentCenter;
    myView.text = self.dataArray[component][row];
    return myView;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
}
@end
