//
//  PersonalTopCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/18.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "PersonalTopCollectionViewCell.h"
@interface PersonalTopCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cstitleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end
@implementation PersonalTopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(PersonalTitleCollectionModel *)model {
    _model = model;
    self.cstitleImageView.image = DotaImageName(model.imageString);
    CGFloat chooseInterval = 0;
    CGFloat noChooseInterval = 10;

    if (model.choose) {
        self.leftConstraint.constant = chooseInterval;
        self.rightConstraint.constant = chooseInterval;
        self.topConstraint.constant = chooseInterval;
        self.bottomConstraint.constant = chooseInterval;
    }else {
        self.leftConstraint.constant = noChooseInterval;
        self.rightConstraint.constant = noChooseInterval;
        self.topConstraint.constant = noChooseInterval;
        self.bottomConstraint.constant = noChooseInterval;
    }
}
@end
