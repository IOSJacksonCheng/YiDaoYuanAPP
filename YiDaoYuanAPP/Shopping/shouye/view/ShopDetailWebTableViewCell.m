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

@property (nonatomic, assign) CGFloat lastHeight;
@end
@implementation ShopDetailWebTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
 
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

        
            self.wkWebView.frame = CGRectMake(0, 0, fitSize.width, fitSize.height);
        
        [self layoutIfNeeded];
        
        CSLog(@"%f",fitSize.height);
//        if (self.lastHeight == fitSize.height) {
//
//            [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];
//
//
//
//        }

       
    }
}

//这里别忘了在dealloc理移除监听

- (void)setPassUrl:(NSString *)passUrl {
    
    _passUrl = passUrl;
//    [self.wkWebView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    self.wkWebView.scrollView.scrollEnabled = NO;

    [self startLoad];
}
- (void)startLoad {
    
    NSString *urlString = self.passUrl;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    request.timeoutInterval = 15.0f;
    
    [self.wkWebView loadRequest:request];
}
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
   
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
   
  
    [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        float addHeight = 0;
        if ([result floatValue] > 1600) {
            addHeight = 1000;
        }
        float height = [result floatValue] + addHeight;
        
        if (self.cellHeight.floatValue != height) {
            
            [self.csDelegate passCellHeight:height];

        }
        self.wkWebView.frame = self.bounds;
        [self layoutIfNeeded];
        CSLog(@"scrollHeight高度：%.2f",[result floatValue]);
    }];

}
@end
