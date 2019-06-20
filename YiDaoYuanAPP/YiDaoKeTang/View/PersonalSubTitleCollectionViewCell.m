//
//  PersonalSubTitleCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/18.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//


#import "PersonalSubTitleCollectionViewCell.h"
@interface PersonalSubTitleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *pinkView;
@end
@implementation PersonalSubTitleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(PersonalTitleCollectionModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    if (model.choose) {
        self.pinkView.hidden = NO;
       
        self.titleLabel.textColor = [UIColor colorWithHexString:@"0F71C7"];
       
        
    }else {
        self.pinkView.hidden = YES;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
}
@end
