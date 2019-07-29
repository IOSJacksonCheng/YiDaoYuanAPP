//
//  ShopProductGuiGeCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopProductGuiGeCollectionViewCell.h"
@interface ShopProductGuiGeCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;

@end
@implementation ShopProductGuiGeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.masksToBounds = YES;
}
- (void)setModel:(DaShiListItemModel *)model {
    _model = model;
    self.csTitleLabel.text = [NSString stringWithFormat:@"%@(%@)",model.i, model.v];
    if (model.isChoose) {
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"#EFF8FF"];
        self.csTitleLabel.textColor = [UIColor colorWithHexString:@"#0D71C8"];
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#0D71C8"].CGColor;
    } else {
      
        
        self.bgView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        self.csTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.bgView.layer.borderWidth = 1;
        self.bgView.layer.borderColor = [UIColor colorWithHexString:@"#F5F5F5"].CGColor;
    }
    
    
}
@end
