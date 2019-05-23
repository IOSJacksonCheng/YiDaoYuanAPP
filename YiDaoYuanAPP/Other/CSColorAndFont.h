//
//  CSColorAndFont.h
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#ifndef CSColorAndFont_h
#define CSColorAndFont_h

//font
#define csCharacterFont_15     [UIFont systemFontOfSize:15]
#define csCharacterFont_12     [UIFont systemFontOfSize:12]
#define csCharacterFont_18     [UIFont systemFontOfSize:18]
#define csCharacterFont_16     [UIFont systemFontOfSize:16]

//color
#define CSColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define csBlueColor [UIColor colorWithHexString:@"0D71C8"]
#define csLightBlueColor [UIColor colorWithHexString:@"599AD6"]
#define csf1f1f1Color [UIColor colorWithHexString:@"f1f1f1"]
#define cs999999Color [UIColor colorWithHexString:@"999999"]
#define csf4f4f4Color [UIColor colorWithHexString:@"F4F4F4"]
#define csNavigationBarColor [UIColor colorWithHexString:@"ff6347"]

#define csMoneyLabelColor [UIColor colorWithHexString:@"CA1715"]
#define csLineColor [UIColor colorWithHexString:@"F0F1F2"]

#define DotaImageName(name) [UIImage imageNamed:name]
#define PlaceHolderImage [UIImage imageNamed:@""]
#endif /* CSColorAndFont_h */
