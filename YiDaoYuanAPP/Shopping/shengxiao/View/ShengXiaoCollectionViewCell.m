//
//  ShengXiaoCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/4.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShengXiaoCollectionViewCell.h"
@interface ShengXiaoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *csImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *pinkView;

@end
@implementation ShengXiaoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(ShengXiaoModel *)model {
    
    
    _model = model;
    
    if (model.choose) {
        
        self.csImageView.image = DotaImageName(model.chooseImage);
        
        self.pinkView.hidden = NO;
        
        self.titleLabel.textColor = [UIColor colorWithHexString:model.titleColor];

    }else {
        
        self.csImageView.image = DotaImageName(model.image);
        self.pinkView.hidden = YES;
        self.titleLabel.textColor = [UIColor colorWithHexString:@"BCBCBC"];
    }
    self.titleLabel.text = model.title;
    
}
@end
