//
//  CSTitleSearchView.m
//  ShangBiao
//
//  Created by shoubin cheng on 2018/9/17.
//  Copyright © 2018年 Jackson cheng. All rights reserved.
//

#import "CSTitleSearchView.h"



@interface CSTitleSearchView()

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
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearchButtonDone)];
        
        tap.numberOfTapsRequired = 1;
        
        tap.numberOfTouchesRequired = 1;
        
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}
- (void)clickSearchButtonDone {
    
    [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"CSSearchViewController" sender:self];
    
}

@end
