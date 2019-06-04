//
//  DaShiRuZhuModel.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/2.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, CSCellType) {
    TextFieldCellType = 0,
    ButtonCellType,
    ImageCellType,
    TextViewCellType,
    CollectionCellType
};
NS_ASSUME_NONNULL_BEGIN

@interface DaShiRuZhuModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) CSCellType cellType;

@property (nonatomic, assign) BOOL chooseLeft;

@property (nonatomic, strong) NSString *leftImageString;

@property (nonatomic, strong) NSString *rightimageString;

@property (nonatomic, strong) NSString *placeHolder;

@property (nonatomic, strong) NSString *alipayName;
@property (nonatomic, strong) NSString *alipayCard;

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Card;
@end

NS_ASSUME_NONNULL_END
