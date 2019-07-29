//
//  ZJZXFirstRowTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/23.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZJZXFirstRowTableViewCell.h"
#import "YiDaoKeTangListViewController.h"
@interface ZJZXFirstRowTableViewCell()



@property (weak, nonatomic) IBOutlet UIView *rightNowConsultView;
@property (weak, nonatomic) IBOutlet UIView *playContactView;
@property (weak, nonatomic) IBOutlet UIView *shoppingView;



@end
@implementation ZJZXFirstRowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
   
    

    
    UITapGestureRecognizer *newsTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickRightNowConsultViewDone)];
    
    newsTap5.numberOfTapsRequired = 1;
    
    newsTap5.numberOfTouchesRequired = 1;
    
    [self.rightNowConsultView addGestureRecognizer:newsTap5];
    
    
    UITapGestureRecognizer *newsTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPlayContactViewDone)];
    
    newsTap6.numberOfTapsRequired = 1;
    
    newsTap6.numberOfTouchesRequired = 1;
    
    [self.playContactView addGestureRecognizer:newsTap6];
    
    UITapGestureRecognizer *newsTap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShoppingViewDone)];
    
    newsTap7.numberOfTapsRequired = 1;
    
    newsTap7.numberOfTouchesRequired = 1;
    
    [self.shoppingView addGestureRecognizer:newsTap7];
    
    
   
    
}



- (void)clickShoppingViewDone {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"shopping" bundle:nil];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"shoppingStoryboard"];
}
- (void)clickPlayContactViewDone {
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"PlayContactViewController" sender:self];
}
- (void)clickRightNowConsultViewDone {
    
     [[CSUtility getCurrentViewController]  performSegueWithIdentifier:@"RightNowConsultViewController" sender:self];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
