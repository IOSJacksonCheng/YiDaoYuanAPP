//
//  ZhuanJiaZiXunViewController.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/5/22.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ZhuanJiaZiXunViewController.h"
#import "CSTitleSearchView.h"

#import "ZJZXFirstRowTableViewCell.h"

#import "ZJZXFirstRowModel.h"
CGFloat const AD_Height = 160;
@interface ZhuanJiaZiXunViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

// top ad scrollview
@property (nonatomic, strong) UIView *adView;
@property (nonatomic, strong) UIScrollView *adScrollView;
@property (nonatomic, strong) NSTimer *adTimer;
@property (nonatomic, strong) NSMutableArray *adImageArray;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSUInteger currentImageIndex;
@property (nonatomic, assign) NSUInteger imageCount;
@end

@implementation ZhuanJiaZiXunViewController
- (UIView *)adView {
    if (!_adView) {
        _adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, AD_Height)];
        _adView.backgroundColor = UIColor.whiteColor;
        
        self.adScrollView = [[UIScrollView alloc] initWithFrame:_adView.bounds];
        
        [_adView addSubview:self.adScrollView];
        
        self.adScrollView.delegate = self;
        self.adScrollView.contentSize = CGSizeMake(MainScreenWidth * 3, AD_Height);
        self.adScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
        self.adScrollView.pagingEnabled = YES;
        self.adScrollView.showsVerticalScrollIndicator = NO;
        self.adScrollView.showsHorizontalScrollIndicator = NO;
        self.adScrollView.bounces = NO;
        
    }
    return _adView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillDisappear:animated];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configSubViews];
    
    [self configNavigationBar];
    
    [self configTableView];
    
    [self configADScrollView];
}
- (void)configTableView {
    

    [self.mainTableView registerNib:[UINib nibWithNibName:CSCellName(ZJZXFirstRowTableViewCell) bundle:nil] forCellReuseIdentifier:CSCellName(ZJZXFirstRowTableViewCell)];
    
}
- (void)configSubViews {
    
}

- (void)configNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[CSUtility createImageWithColor:[UIColor colorWithHexString:@"FFFFFF"]] forBarMetrics:UIBarMetricsDefault];
    
    CSTitleSearchView *searchView = [[CSTitleSearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 22)];
    
    searchView.intrinsicContentSize = CGSizeMake(self.view.width - 30, 35);
    
    self.navigationItem.titleView = searchView;
    
    
    UIButton *leftButton = [[UIButton alloc] init];
    
    [leftButton setTitle:@"北京" forState:UIControlStateNormal];
    
    [leftButton setImage:DotaImageName(@"icon_dingwei") forState:UIControlStateNormal];
    
    [leftButton setTitleColor:cs999999Color forState:UIControlStateNormal];
    leftButton.titleLabel.font = csCharacterFont_15;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    
    
    
    UIBarButtonItem *lineItem =  [[UIBarButtonItem alloc] initWithTitle:@"|" style:UIBarButtonItemStylePlain target:self action:@selector(clickLocationButtonDone)];
     [lineItem setTintColor:[UIColor colorWithHexString:@"0D71C8"]];

   
    self.navigationItem.leftBarButtonItems = @[leftItem, lineItem];
    
}
- (void)clickLocationButtonDone {
    
}
#pragma mark --UITableViewDelegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        ZJZXFirstRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(ZJZXFirstRowTableViewCell)];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CSCellName(@"")];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return 454.5;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return AD_Height;
    }
  
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return  self.adView;
    }
   
    return nil;
 
}
#pragma mark -- 配置ADScrollView
- (void)configADScrollView {
    
    _imageCount = self.adImageArray.count;
    if (self.adImageArray.count == 0) {
        _imageCount = 0;
    }
    //增加头部的广告视图
    
    [self addImageViews];
    //添加pageControl
    [self addPageControl];
    //加载默认的第一屏的三张图片
    [self setDefaultImage];
    
}
-(void)setDefaultImage
{
    if (_imageCount < 1) {
        CSLog(@"首页广告产品数量错误");
        return;
    }
    if (_imageCount == 1) {
        ZJZXFirstRowModel *model = self.adImageArray[0];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
        
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
    } else {
        
        ZJZXFirstRowModel *model = self.adImageArray[_imageCount - 1];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
        
        model = self.adImageArray[0];
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
        
        model = self.adImageArray[1];
        
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:PlaceHolderImage];
        
    }
    // 记录当前页
    _currentImageIndex = 0;
    _pageControl.currentPage = _currentImageIndex;
    _imageCount = self.adImageArray.count;
    
}

-(void)addPageControl
{
    if (_pageControl.numberOfPages < 1) {
        _pageControl.numberOfPages = _imageCount;
    }
    if (_pageControl) {
        return;
    }
    _pageControl = [[UIPageControl alloc]init];
    //此方法可以根据小圆点页数返回最适合UIPageControl的大小
    CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];
    //为了定位可使用bounds+center
    //定视图的位置时，为了居中，可以通过设置视图的中心点
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    
    _pageControl.center = CGPointMake(MainScreenWidth*0.5, AD_Height-20);
    
    
    //设置颜色
    _pageControl.pageIndicatorTintColor = UIColor.whiteColor;
    
    _pageControl.currentPageIndicatorTintColor = CSColorRGBA(255, 102, 0, 1);
    //设置总页数
    _pageControl.numberOfPages = _imageCount;
    [self.adView addSubview:_pageControl];
}
-(void)addImageViews
{
    
    
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, AD_Height)];
        
        _leftImageView.contentMode = UIViewContentModeScaleToFill;
        
        [self.adScrollView addSubview:_leftImageView];
        
    }
    
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth, 0, MainScreenWidth, AD_Height)];
        
        _centerImageView.userInteractionEnabled = YES;
        _centerImageView.contentMode = UIViewContentModeScaleToFill;
        
        [self.adScrollView addSubview:_centerImageView];
        
    }
    
    
    
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2 * MainScreenWidth, 0, MainScreenWidth, AD_Height)];
        
        _rightImageView.contentMode = UIViewContentModeScaleToFill
        ;
        [self.adScrollView addSubview:_rightImageView];
    }
}
#pragma mark -- UIScrollViewDelegate
//滚动停止事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.adScrollView) {
        //重新加载图片
        [self reloadImage];
        //移动回中间
        self.adScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
        //修改分页控件上的小圆点
        _pageControl.currentPage = _currentImageIndex;
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}
- (void)removeTimer {
    [self.adTimer invalidate];
    self.adTimer = nil;
}
- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.adTimer = timer;
}
- (void)nextPage {
    self.adScrollView.contentOffset = CGPointMake(MainScreenWidth * 2, 0);
    if (self.adImageArray.count >= 1) {
        [self reloadImage];
    }
    self.adScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    self.pageControl.currentPage = self.currentImageIndex;
}
- (void)reloadImage {
    if (self.currentImageIndex >= self.adImageArray.count) {
        return;
    }
    NSInteger leftImageIndex = 0;
    NSInteger rightImageIndex = 0;
    CGPoint offset = self.adScrollView.contentOffset;
    
    if (offset.x > MainScreenWidth) {
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageCount;
    } else if (offset.x < MainScreenWidth) {
        self.currentImageIndex = (self.currentImageIndex + self.imageCount - 1) % self.imageCount;
    }
    
    ZJZXFirstRowModel *centerModel = self.adImageArray[self.currentImageIndex];
    
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:centerModel.url] placeholderImage:PlaceHolderImage];
    
    
    leftImageIndex = (_currentImageIndex+_imageCount-1)%_imageCount;
    rightImageIndex = (_currentImageIndex+1)%_imageCount;
    
    ZJZXFirstRowModel *leftModel = self.adImageArray[leftImageIndex];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel.url] placeholderImage:PlaceHolderImage];
    
    ZJZXFirstRowModel *rightModel = self.adImageArray[rightImageIndex];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel.url] placeholderImage:PlaceHolderImage];
    
}
@end
