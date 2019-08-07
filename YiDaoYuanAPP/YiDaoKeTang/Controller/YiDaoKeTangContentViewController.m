//
//  YiDaoKeTangContentViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/1.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "YiDaoKeTangContentViewController.h"
#import <WebKit/WebKit.h>

#import "CSShareView.h"

@interface YiDaoKeTangContentViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) WKWebViewConfiguration *wkConfig;
@property (nonatomic, strong) UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *lovebutton;
- (IBAction)clickLoveButtonDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
- (IBAction)clickCollectButtonDone:(id)sender;
@property (nonatomic, strong) CSShareView *shareView;

@end

@implementation YiDaoKeTangContentViewController
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
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    [self startLoad];
    [self checkCollectStatus];
}
- (void)configTableView {
    
}
- (void)configSubViews {
    
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 2)];
    
    self.progressView.backgroundColor = csBlueColor;
    
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    
    [self.view addSubview:self.progressView];
    
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    if (self.showBottomView) {
        self.bottomView.hidden = NO;
        [self.view bringSubviewToFront:self.bottomView];
    } else {
        self.bottomView.hidden = YES;
    }
    
}
- (void)configNavigationBar {
   
    self.title = self.passTitle;
    
    F3f3f3NavigationBarColor
    
    
    UIColor *whiteColor = [UIColor colorWithHexString:@"333333"];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:whiteColor forKey:NSForegroundColorAttributeName];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    UIButton *rightButton = [[UIButton alloc] init];
    
    
    [rightButton setImage:DotaImageName(@"icon_fenxiang") forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(clickButtonDone) forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
}

- (void)clickButtonDone {
    
    self.shareView = [[CSShareView alloc] initWithFrame:self.view.bounds WithDelegate:self WithTitle:@"易道源" WithDescription:@"算命App" WithImage:DotaImageName(@"AppIcon") WithUrl:self.passUrl];
    
    
    [self.view addSubview:self.shareView];
    
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


- (IBAction)clickLoveButtonDone:(id)sender {
    
    
}
- (IBAction)clickCollectButtonDone:(id)sender {
    [self clickCollectViewDone];
    
}
#pragma mark -- 收藏part
- (void)checkCollectStatus {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"object_id"] = self.idstring;
    para[@"table_name"] = @"class";

    [CSNetManager sendGetRequestWithNeedToken:YES Url:CSURL_Portal_user_favorites_hasFavorite Pameters:para success:^(id  _Nonnull responseObject) {
        
        if (CSInternetRequestSuccessful) {
            self.collectButton.selected = YES;
            
        }else {
            self.collectButton.selected = NO;
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)clickCancelCollect {
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"object_id"] = self.idstring;
    para[@"table_name"] = @"class";

    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_user_favorites_unset Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            
            self.collectButton.selected = NO;
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
}
- (void)clickCollectViewDone {
    if (self.collectButton.selected) {
        [self clickCancelCollect];
        return;
    }
    NSMutableDictionary *para = @{}.mutableCopy;
    para[@"object_id"] = self.idstring;
    para[@"table_name"] = @"class";
    
    [CSNetManager sendPostRequestWithNeedToken:YES Url:CSURL_Portal_user_favorites_add Pameters:para success:^(id  _Nonnull responseObject) {
        if (CSInternetRequestSuccessful) {
            self.collectButton.selected = YES;
            
        }else {
            CSShowWrongMessage
        }
    } failure:^(NSError * _Nonnull error) {
        CSInternetFailure
    }];
    
    
}
@end
