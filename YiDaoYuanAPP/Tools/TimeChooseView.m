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
@property (copy, nonatomic) NSString *year; // 选中年
@property (copy, nonatomic) NSString *month; //选中月
@property (copy, nonatomic) NSString *day; //选中日
@property (copy, nonatomic) NSString *hour; //选中时
@property (copy, nonatomic) NSString *minute; //选中分
@end
@implementation TimeChooseView
- (NSMutableArray *)minuteArray {
    if (!_minuteArray) {
        _minuteArray = @[].mutableCopy;
        
        for (int i = 0; i <= 60; i ++) {
            
        [_minuteArray addObject:[NSString stringWithFormat:@"%d", i]];
        
        }
    }
    return _minuteArray;
}
-(NSMutableArray *)hourArray {
    if (!_hourArray) {
        _hourArray = @[].mutableCopy;
        
        for (int i = 0; i < 24; i ++) {
            [_hourArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _hourArray;
}
- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        
        _dayArray = @[].mutableCopy;
        
        for (int i = 1; i <= 31; i ++) {
            [_dayArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _dayArray;
}
- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        
        _monthArray = @[].mutableCopy;
        
        for (int i = 1; i <= 12; i ++) {
            [_monthArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
        
    }
    return _monthArray;
}
- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        
        _yearArray = @[].mutableCopy;
       
        NSString *maxyear = [CSUtility getCurrentDate];
        
       int year = [[maxyear substringToIndex:4] intValue];
        
        for (int i = year; i >= 1950; i --) {
            [_yearArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        
    }
    
    return _yearArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self configSubViewsWithFrame:frame];
        
        [self initData];
        [self refreshView];
    }
    
    return self;
}
- (void)initData {
    
    self.year = self.yearArray[0];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init]; //初始化格式器。
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm"];
    
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    

    self.month = [NSString stringWithFormat:@"%d",[currentTime substringWithRange:NSMakeRange(5, 2)].intValue];
    
    NSString *day = [currentTime substringWithRange:NSMakeRange(8, 2)];
    
    self.day = [NSString stringWithFormat:@"%d",day.intValue];
    
    NSString *hour = [currentTime substringWithRange:NSMakeRange(11, 2)];

    self.hour = [NSString stringWithFormat:@"%d",hour.intValue];
    NSString *minute = [currentTime substringWithRange:NSMakeRange(14, 2)];
   
    self.minute = [NSString stringWithFormat:@"%d",minute.intValue];
}
- (void)configSubViewsWithFrame:(CGRect)frame {
 
    UIColor *backGroundColor = [UIColor colorWithHexString:@"000000"];
    
    self.backgroundColor = [backGroundColor colorWithAlphaComponent:0.7];
  
    CGFloat whiteviewHeight = 250;
   
    CGFloat whiteviewWidth = frame.size.width;
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - whiteviewHeight, whiteviewWidth, whiteviewHeight)];
    
    
    whiteView.backgroundColor = UIColor.whiteColor;
    
    [self addSubview:whiteView];
    CGFloat buttonHeight = 40;
    CGFloat buttonYInterval = 5;
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(20, buttonYInterval, 80, buttonHeight)];
    
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    cancelButton.titleLabel.font = csCharacterFont_15;
    
    [cancelButton addTarget:self action:@selector(clickCancelButtonDone) forControlEvents:UIControlEventTouchDown];
    [whiteView addSubview:cancelButton];
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(whiteviewWidth - 20 - 80, buttonYInterval, 80, buttonHeight)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:cs333333Color forState:UIControlStateNormal];
    
    sureButton.titleLabel.font = csCharacterFont_15;
    [sureButton addTarget:self action:@selector(clickSureButtonDone) forControlEvents:UIControlEventTouchDown];

    [whiteView addSubview:sureButton];
    
    CGFloat pickViewHeight = whiteviewHeight - buttonHeight - buttonYInterval - buttonYInterval;
    
    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, whiteviewHeight - pickViewHeight, whiteviewWidth, pickViewHeight)];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    
    [whiteView addSubview:self.pickView];
    
    self.dataArray = @[self.yearArray,self.monthArray,self.dayArray,self.hourArray,self.minuteArray].mutableCopy;
    [self.pickView reloadAllComponents];
    
}
- (void)clickSureButtonDone {
    [self.csTimeDelegate passTime:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",self.year,self.month,self.day,self.hour,self.minute]];
    self.hidden = YES;
    
}
- (void)clickCancelButtonDone {
    self.hidden = YES;
}
#pragma mark - UIPickerViewDelegate and UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataArray.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [self.dataArray[component] count];
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 44)];
    myView.font = [UIFont systemFontOfSize:15];
    myView.textColor = UIColor.blackColor;
    myView.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
       
        myView.text = [NSString stringWithFormat:@"%@年",self.dataArray[component][row]];
    }else if (component == 1) {
       
        myView.text = [NSString stringWithFormat:@"%@月",self.dataArray[component][row]];

    }else if (component == 2) {
        
        myView.text = [NSString stringWithFormat:@"%@日",self.dataArray[component][row]];
        
    }else if (component == 3) {
        
        myView.text = [NSString stringWithFormat:@"%@时",self.dataArray[component][row]];
        
    }else {
        myView.text = [NSString stringWithFormat:@"%@分",self.dataArray[component][row]];

    }
    return myView;
}
- (void)refreshView {
    
    
    
    [self.pickView selectRow:[self.yearArray indexOfObject:self.year] inComponent:0 animated:YES];
    /// 重新格式化转一下，是因为如果是09月/日/时，数据源是9月/日/时,就会出现崩溃
    [self.pickView selectRow:[self.monthArray indexOfObject:self.month] inComponent:1 animated:YES];
    [self.pickView selectRow:[self.dayArray indexOfObject:self.day] inComponent:2 animated:YES];
    [self.pickView selectRow:[self.hourArray indexOfObject:self.hour] inComponent:3 animated:YES];
      [self.pickView selectRow:[self.minuteArray indexOfObject:self.minute] inComponent:4 animated:YES];;
    
    /// 刷新日
    [self refreshDay];
}
- (void)refreshDay {
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i < [self getDayNumber:self.year.integerValue month:self.month.integerValue].integerValue + 1; i ++) {
        [arr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    [self.dataArray replaceObjectAtIndex:2 withObject:arr];
    [self.pickView reloadComponent:2];
}

- (NSString *)getDayNumber:(NSInteger)year month:(NSInteger)month{
    NSArray *days = @[@"31", @"28", @"31", @"30", @"31", @"30", @"31", @"31", @"30", @"31", @"30", @"31"];
    if (2 == month && 0 == (year % 4) && (0 != (year % 100) || 0 == (year % 400))) {
        return @"29";
    }
    return days[month - 1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSMutableArray *array = self.dataArray[component];
    
    NSString *timeString = array[row];
    
    switch (component) {
        case 0: { // 年
            
            self.year = timeString;
         
                /// 刷新日
                /// 根据当前选择的年份和月份获取当月的天数
                NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            if (self.day.integerValue > dayStr.integerValue) {
               
                self.day = dayStr;
               
                [self refreshDay];

                [self refreshView];
            }
    
            
        } break;
        case 1: {
            
            self.month = timeString;
            NSString *dayStr = [self getDayNumber:[self.year integerValue] month:[self.month integerValue]];
            if (self.day.integerValue > dayStr.integerValue) {
                
                self.day = dayStr;
                
                [self refreshDay];
                
                [self refreshView];
            }
            
        } break;
        case 2: {
            
            self.day = timeString;
            
        } break;
        case 3: {
            self.hour = timeString;
            
        } break;
        case 4: {
            
            self.minute = timeString;
            
        } break;
        default: break;
    }
}
@end
