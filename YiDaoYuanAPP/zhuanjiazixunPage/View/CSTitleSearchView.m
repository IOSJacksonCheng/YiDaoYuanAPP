//
//  CSTitleSearchView.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "CSTitleSearchView.h"
#import "Masonry.h"

//#import "MakeDealViewController.h"
@interface CSTitleSearchView()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *brandButton;
@property (nonatomic, strong) UITextField *keywordTextField;
@property (nonatomic, strong) NSString *recordType;
@end
@implementation CSTitleSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = csf4f4f4Color;
         self.layer.cornerRadius = 11;
        self.layer.masksToBounds = YES;

        UIButton *searchButton = [UIButton new];
        
        [self addSubview:searchButton];
        [searchButton setImage:DotaImageName(@"icon_sousuo") forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(clickSearchButtonDone) forControlEvents:UIControlEventTouchDown];
        [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
       
     
        
     
    }
    return self;
}
- (void)clickSearchButtonDone {
  
//    UIStoryboard *sb= [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    
//    MakeDealViewController *new= [sb instantiateViewControllerWithIdentifier:@"MakeDealViewController"];
//    new.recordKeyword = self.keywordTextField.text;
//   
//    [[CSUtility getCurrentViewController].navigationController pushViewController:new animated:YES];
}

@end
