//
//  CSShareView.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/28.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "CSShareView.h"

#import "ShareCollectionViewCell.h"
#import "WXApi.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
NSString * const csweixin = @"微信";
NSString * const csxinlangweibo = @"新浪微博";

NSString * const cspengyouquan = @"朋友圈";

NSString * const csQQ = @"QQ好友";
NSString * const csQQZone = @"QQ空间";

NSString * const csfuzhilianjie = @"复制链接";

@interface CSShareView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,TencentSessionDelegate, TencentLoginDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *fenXiangArray;

@property (nonatomic, strong) NSString *shareTitle;

@property (nonatomic, strong) NSString *descr;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *url;

@property (nonatomic,strong) TencentOAuth *tencentOAuth;

@end
@implementation CSShareView
- (NSMutableArray *)fenXiangArray {
    if (!_fenXiangArray) {
        _fenXiangArray = @[csweixin,cspengyouquan,csQQ, csQQZone,csfuzhilianjie].mutableCopy;
//        _fenXiangArray = @[csweixin,cspengyouquan,csfuzhilianjie].mutableCopy;
    }
    return _fenXiangArray;
}
- (instancetype)initWithFrame:(CGRect)frame WithDelegate:(id<CSShareViewDelegate>)delegate WithTitle:(NSString *)shareTitle WithDescription:(NSString *)descr WithImage:(UIImage *)image WithUrl:(NSString *)url
{
    
    self = [super initWithFrame:frame];
    
    
    if (self) {
        
        self.shareTitle = shareTitle;
        
        self.descr = descr;
        
        self.image = image;
        
        self.url = url;
        
        self.csDelegate = delegate;

        UIColor *backGroundColor = [UIColor colorWithHexString:@"000000"];
        self.backgroundColor = [backGroundColor colorWithAlphaComponent:0.7];
        
        CGFloat itemHeight = 90;
        CGFloat itemWidht = MainScreenWidth * 0.25;
        CGFloat whiteviewHeight = itemHeight;
        if (self.fenXiangArray.count > 4) {
           whiteviewHeight = itemHeight * 2;
        }
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - whiteviewHeight, frame.size.width, whiteviewHeight)];
       
        whiteView.backgroundColor = UIColor.whiteColor;

        [self addSubview:whiteView];
    
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.itemSize = CGSizeMake(itemWidht, itemHeight);
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:whiteView.bounds collectionViewLayout: layout];
       
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
       self.collectionView.backgroundColor = UIColor.whiteColor;
        [self.collectionView registerNib:[UINib nibWithNibName:CSCellName(ShareCollectionViewCell) bundle:nil] forCellWithReuseIdentifier:CSCellName(ShareCollectionViewCell)];
        
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.showsVerticalScrollIndicator = NO;
        [whiteView addSubview:self.collectionView];
        UIView *closeView = [UIView new];
        [self addSubview:closeView];
        
        [closeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.bottom.mas_equalTo(-whiteviewHeight);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(MainScreenWidth);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCloseView)];
        
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        
        [closeView addGestureRecognizer:tap];
        
        [self.collectionView reloadData];
    }
    
    return self;
}
- (void)clickCloseView {
    [self removeFromSuperview];
}
#pragma mark -- UICollectionViewDataSource/Delegate
// UIEdgeInsets insets = {top, left, bottom, right};

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
//    return UIEdgeInsetsMake(10, 15, 10, 15);
     return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.fenXiangArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CSCellName(ShareCollectionViewCell) forIndexPath:indexPath];
    
    NSString *title = self.fenXiangArray[indexPath.row];
    cell.titleLabel.text = title;
    
    if ([title isEqualToString:csweixin]) {
        cell.iconImageView.image = DotaImageName(@"icon_weixng");
    }else if ([title isEqualToString:cspengyouquan]) {
        cell.iconImageView.image = DotaImageName(@"icon_pengyouquan");
    }else if ([title isEqualToString:csxinlangweibo]) {
        cell.iconImageView.image = DotaImageName(@"icon_weibo");
    }else if ([title isEqualToString:csfuzhilianjie]) {
        cell.iconImageView.image = DotaImageName(@"icon_lianjie");
    }else if ([title isEqualToString:csQQ] || [title isEqualToString:csQQZone]) {
        cell.iconImageView.image = DotaImageName(@"icon_qq");
    }
    
    
    
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.fenXiangArray[indexPath.row];
    
    if ([title isEqualToString:csweixin]) {
        [self shareWeiXin];
    }else if ([title isEqualToString:cspengyouquan]) {
        [self shareWeiXinPengyouquan];
    }else if ([title isEqualToString:csxinlangweibo]) {

    }else if ([title isEqualToString:csfuzhilianjie]) {
  
        
        UIPasteboard *pab = [UIPasteboard generalPasteboard];
        NSString *string = self.url;
        [pab setString:string];
        if (pab == nil) {
            CustomWrongMessage(@"复制失败");
        }else
        {
            CustomWrongMessage(@"已复制");

        }
        
    }else if ([title isEqualToString:csQQ]) {
        [self shareQQ];
    }else if ([title isEqualToString:csQQZone]) {
        [self shareQQZone];
    }
    
    
}
- (void)shareQQZone {
    self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:CSQQAppId andDelegate:self];
    
    //    NSMutableArray *permission = [@[] mutableCopy];
    //
    //
    //    permission = [NSMutableArray arrayWithObjects:@"get_user_info",@"add_share",nil];
    //
    //    [self.tencentOAuth authorize:permission inSafari:NO];
    NSString *utf8String = self.url;
    NSString *title = self.shareTitle;
    NSString *description = self.descr;
    NSString *previewImageUrl = @"http://cdni.wired.co.uk/620x413/k_n/NewsForecast%20copy_620x413.jpg";
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
//    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    //将内容分享到qzone
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}
- (void)shareQQ {
    
    self.tencentOAuth = [[TencentOAuth alloc]initWithAppId:CSQQAppId andDelegate:self];

//    NSMutableArray *permission = [@[] mutableCopy];
//
//
//    permission = [NSMutableArray arrayWithObjects:@"get_user_info",@"add_share",nil];
//
//    [self.tencentOAuth authorize:permission inSafari:NO];
    NSString *utf8String = self.url;
    NSString *title = self.shareTitle;
    NSString *description = self.descr;
    NSString *previewImageUrl = @"http://cdni.wired.co.uk/620x413/k_n/NewsForecast%20copy_620x413.jpg";
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    
    //将内容分享到qzone
//    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
    
}
- (void)shareWeiXin {
    WXMediaMessage *message = [WXMediaMessage message];
    
    message.title = self.shareTitle;
    
    message.description = self.descr;
    
    UIImage *convertImage = [self compressImage:self.image toByte:1024 * 8];
    
    [message setThumbImage:convertImage];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    
    webpageObject.webpageUrl = self.url;
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    /** 发送的目标场景，可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline)。 默认发送到会话。
     * @see WXScene
     */
//    if ([scene isEqualToString:CSWXSceneTimeline]) {
//        req.scene = WXSceneTimeline;
//    }else {
        req.scene = WXSceneSession;
//    }
    [WXApi sendReq:req];
}
- (void)shareWeiXinPengyouquan {
    WXMediaMessage *message = [WXMediaMessage message];
    
    message.title = self.shareTitle;
    
    message.description = self.descr;
    
    UIImage *convertImage = [self compressImage:self.image toByte:1024 * 8];
    
    [message setThumbImage:convertImage];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    
    webpageObject.webpageUrl = self.url;
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    /** 发送的目标场景，可以选择发送到会话(WXSceneSession)或者朋友圈(WXSceneTimeline)。 默认发送到会话。
     * @see WXScene
     */
    //    if ([scene isEqualToString:CSWXSceneTimeline]) {
    //        req.scene = WXSceneTimeline;
    //    }else {
    req.scene = WXSceneTimeline;
    //    }
    [WXApi sendReq:req];
}

- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}
@end
