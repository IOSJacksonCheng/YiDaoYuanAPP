//
//  ShopProductCollectionViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/13.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopProductCollectionViewCell.h"
@interface ShopProductCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIButton *shopCarButton;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *csTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *csImageView;
- (IBAction)clickShopCarButtonDone:(id)sender;

@end
@implementation ShopProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.shopCarButton.layer.cornerRadius = 29 * 0.5;
    
    self.shopCarButton.layer.masksToBounds = YES;
    
    self.typeLabel.layer.cornerRadius = 5;
    self.typeLabel.layer.borderColor = [UIColor colorWithHexString:@"#EA4141"].CGColor;
    self.typeLabel.layer.borderWidth = 1;
}
- (void)setModel:(ShopManyProductModel *)model {
    _model = model;
    
    [self.csImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:PlaceHolderImage];
    if (model.newspro) {
        self.typeLabel.text = @"  新品  ";
    } else {
        self.typeLabel.text = @"";
    }
    if (model.best) {
        self.typeLabel.text = @"  热卖商品  ";

    }else {
        self.typeLabel.text = @"";
    }

    self.csTitleLabel.text = [NSString stringWithFormat:@"%@%@",model.goods_name, model.intro];;
    
    self.moneyLabel.text = [NSString stringWithFormat:@"¥%@",model.sell_price];
    
    

}
- (IBAction)clickShopCarButtonDone:(id)sender {
    

    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"goods_id"] = self.model.goods_id;
  
    para[@"quantity"] = @"1";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Cart_addcart Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            CustomWrongMessage(@"加入购物车成功!")
        
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
}
@end
