//
//  DaShiItemCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "DaShiItemCollectionViewCell.h"
@interface DaShiItemCollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;

@end
@implementation DaShiItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(DaShiListItemModel *)model {
    _model = model;
    self.csTitleLabel.text = model.title;
    if (model.isChoose) {
        self.backgroundColor = [UIColor colorWithHexString:@"DDEFFF"];
        self.csTitleLabel.textColor = [UIColor colorWithHexString:@"0D71C8"];
    } else {
        self.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
        self.csTitleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
}
- (void)setWishModel:(DaShiListItemModel *)wishModel {
    
    _wishModel = wishModel;
    self.backgroundColor = UIColor.clearColor;
    self.csTitleLabel.text = wishModel.title;
    if (_wishModel.isChoose) {
       
        
       
        self.csTitleLabel.textColor = csBlueColor;
       
        self.layer.cornerRadius = 5;
        
        self.layer.borderColor = csBlueColor.CGColor;
        
        self.layer.borderWidth = 1;
        
    } else {
       
       
        self.csTitleLabel.textColor = [UIColor colorWithHexString:@"#42231E"];
        
        self.layer.cornerRadius = 5;
        
        self.layer.borderColor = [UIColor colorWithHexString:@"#42231E"].CGColor;
        
        self.layer.borderWidth = 1;
    }
    
}
@end
