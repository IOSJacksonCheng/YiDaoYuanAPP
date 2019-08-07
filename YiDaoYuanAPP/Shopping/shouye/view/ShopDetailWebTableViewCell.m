//
//  ShopDetailWebTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/7/15.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopDetailWebTableViewCell.h"
#import <WebKit/WebKit.h>
@interface ShopDetailWebTableViewCell()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, assign) BOOL webViewHeightChanged;
@end
@implementation ShopDetailWebTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.wkWebView.scrollView.scrollEnabled = NO;
 
    [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    // Initialization code
}
- (WKWebViewConfiguration *)wkConfig {
    if (!_wkConfig) {
        _wkConfig = [[WKWebViewConfiguration alloc] init];
        _wkConfig.allowsInlineMediaPlayback = YES;
        _wkConfig.allowsPictureInPictureMediaPlayback = YES;
        
        //设置configur对象的preferences属性的信息
        WKPreferences *preferences = [[WKPreferences alloc] init];
        _wkConfig.preferences = preferences;
        
        //是否允许与js进行交互，默认是YES的，如果设置为NO，js的代码就不起作用了
        preferences.javaScriptEnabled = YES;
        //        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
    }
    return _wkConfig;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
    
        _wkWebView = [[WKWebView alloc] initWithFrame:self.bounds configuration:self.wkConfig];
       
        _wkWebView.navigationDelegate = self;
        
        _wkWebView.UIDelegate = self;
        
        [self addSubview:_wkWebView];
        
    }
    return _wkWebView;
}
- (void)dealloc {
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        
        CGSize fitSize = [self.wkWebView sizeThatFits:CGSizeZero];
        //        NSLog(@"webview fitSize:%@",NSStringFromCGSize(fitSize));
        if (self.cellHeight.floatValue > 0) {
         
            self.wkWebView.frame = CGRectMake(0, 0, fitSize.width, fitSize.height * 2);
          
            [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
            
            return;

        }
       
        
        [self.csDelegate passCellHeight:self.wkWebView.frame.size.height * 2];
       
    }
}

//这里别忘了在dealloc理移除监听

- (void)setPassUrl:(NSString *)passUrl {
    
    _passUrl = passUrl;
//    [self.wkWebView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

    [self startLoad];
}
- (void)startLoad {
    
    NSString *urlString = self.passUrl;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    request.timeoutInterval = 15.0f;
    
    [self.wkWebView loadRequest:request];
}

@end
