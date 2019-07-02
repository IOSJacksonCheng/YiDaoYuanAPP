//
//  WkWebViewViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/24.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "WkWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface WkWebViewViewController ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WkWebViewViewController
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
        
        if (IPHONE_X) {
            _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - 1 - 84 - 22) configuration:self.wkConfig];
        }else {
            _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - 1 - 64) configuration:self.wkConfig];
        }
        
        
        
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}
- (void)dealloc {
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNavigationBar];
    [self configSubViews];
    [self startLoad];
}
- (void)configNavigationBar {
    
    self.title = self.passTitle;

    F3f3f3NavigationBarColor
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
}
- (void)configSubViews {
    
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    
    self.progressView.backgroundColor = csBlueColor;
    
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    
    [self.view addSubview:self.progressView];
    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)startLoad {
    
    NSString *urlString = self.passUrl;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    request.timeoutInterval = 15.0f;
    
    [self.wkWebView loadRequest:request];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.wkWebView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKWKNavigationDelegate Methods

/*
 *5.在WKWebViewd的代理中展示进度条，加载完成后隐藏进度条
 */

//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
    
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;
}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    //加载失败同样需要隐藏progressView
    self.progressView.hidden = YES;
}
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
//{
//    NSURL *URL = navigationAction.request.URL;
//    
//    NSString *urlString = URL.absoluteString;
//    
//    
//    
//    NSString *baseUrl = @"http://www.kaiyigz.com/product/detail-";
//    
//    if ([urlString containsString:baseUrl]) {
//        
//        [self handleUrl:urlString WithBaseUrl:baseUrl];
//        
//        decisionHandler(WKNavigationActionPolicyCancel);
//        return;
//    }
//    
//    decisionHandler(WKNavigationActionPolicyAllow);
//}

@end
