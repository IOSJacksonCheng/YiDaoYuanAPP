//
//  ShopProductDetailBigImageTableViewCell.m
//  YiDaoYuanAPP
//
//  Created by shoubin cheng on 2019/6/17.
//  Copyright © 2019年 Jackson cheng. All rights reserved.
//

#import "ShopProductDetailBigImageTableViewCell.h"
@interface ShopProductDetailBigImageTableViewCell()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
// top ad scrollview
@property (nonatomic, strong) NSTimer *adTimer;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *centerImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, assign) NSUInteger currentImageIndex;
@property (nonatomic, assign) NSUInteger imageCount;
@property (nonatomic, strong) NSDate *currentDate;
@end
@implementation ShopProductDetailBigImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bannerScrollView.contentSize = CGSizeMake(MainScreenWidth * 3, 310);
    self.bannerScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    self.bannerScrollView.bounces = NO;
    self.bannerScrollView.delegate = self;
    [self addImageViews];
    
    [self addPageControl];
}

-(void)setDefaultImage
{
    if (_imageCount < 1) {
        CSLog(@"首页广告产品数量错误");
        return;
    }
    if (_imageCount == 1) {
                NSString *model = self.adImageArray[0];
     
                [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:PlaceHolderImage];
        
        
                [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:PlaceHolderImage];
        
                [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:PlaceHolderImage];
        
    } else {
        
        NSString *model = self.adImageArray[_imageCount - 1];
        
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:PlaceHolderImage];
        
        
        model = self.adImageArray[0];
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:PlaceHolderImage];
        
        
        model = self.adImageArray[1];
        
        [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model] placeholderImage:PlaceHolderImage];
        
    }
    // 记录当前页
    _currentImageIndex = 0;
    _pageControl.currentPage = _currentImageIndex;
    _imageCount = self.adImageArray.count;
    
}

-(void)addImageViews
{
    
    
    
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 310)];
    self.leftImageView.backgroundColor = UIColor.whiteColor;
    self.leftImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.bannerScrollView addSubview:self.leftImageView];
    
    
    
    
    self.centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth, 0, MainScreenWidth, 310)];
   
    self.centerImageView.userInteractionEnabled = YES;
    self.centerImageView.contentMode = UIViewContentModeScaleToFill;
    
    [self.bannerScrollView addSubview:_centerImageView];
    
    
    
    
    
    
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2 * MainScreenWidth, 0, MainScreenWidth, 310)];
    self.rightImageView .backgroundColor = UIColor.blackColor;
    self.rightImageView .contentMode = UIViewContentModeScaleToFill
    ;
    [self.bannerScrollView addSubview:self.rightImageView ];
    
}
-(void)addPageControl
{
    
    //设置颜色
    self.pageControl.pageIndicatorTintColor = UIColor.whiteColor;
    
    self.pageControl.currentPageIndicatorTintColor = csBlueColor;
    //设置总页数
    self.pageControl.numberOfPages = _imageCount;
    
    
}


#pragma mark -- UIScrollViewDelegate
//滚动停止事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.bannerScrollView) {
        //重新加载图片
        [self reloadImage];
        //移动回中间
        self.bannerScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
        //修改分页控件上的小圆点
        self.pageControl.currentPage = _currentImageIndex;
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}
- (void)dealloc {
    [self removeTimer];
}
- (void)removeTimer {
    [self.adTimer invalidate];
    self.adTimer = nil;
}
- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.adTimer = timer;
}
- (void)nextPage {
    
    if (!self.currentDate) {
        
        self.currentDate = [NSDate date];
        
    } else {
        
        int requestInterval = (int)[[NSDate date] timeIntervalSinceDate:self.currentDate];
        
        
        if (requestInterval < 3) {
            return;
        }
        self.currentDate = [NSDate date];
    }
    
    self.bannerScrollView.contentOffset = CGPointMake(MainScreenWidth * 2, 0);
    if (self.adImageArray.count >= 1) {
        [self reloadImage];
    }
    self.bannerScrollView.contentOffset = CGPointMake(MainScreenWidth, 0);
    self.pageControl.currentPage = self.currentImageIndex;
}
- (void)reloadImage {
    if (self.currentImageIndex >= self.adImageArray.count) {
        return;
    }
    NSInteger leftImageIndex = 0;
    NSInteger rightImageIndex = 0;
    CGPoint offset = self.bannerScrollView.contentOffset;
    
    if (offset.x > MainScreenWidth) {
        self.currentImageIndex = (self.currentImageIndex + 1) % self.imageCount;
    } else if (offset.x < MainScreenWidth) {
        self.currentImageIndex = (self.currentImageIndex + self.imageCount - 1) % self.imageCount;
    }
    
    NSString *centerModel = self.adImageArray[self.currentImageIndex];
    
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:centerModel] placeholderImage:PlaceHolderImage];
    
    
    leftImageIndex = (_currentImageIndex+_imageCount-1)%_imageCount;
    rightImageIndex = (_currentImageIndex+1)%_imageCount;
    
    NSString *leftModel = self.adImageArray[leftImageIndex];
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:leftModel] placeholderImage:PlaceHolderImage];
    
    NSString *rightModel = self.adImageArray[rightImageIndex];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:rightModel] placeholderImage:PlaceHolderImage];
    
}
- (void)setAdImageArray:(NSMutableArray *)adImageArray {
    
    _adImageArray = adImageArray;
    
    _imageCount = adImageArray.count;
    
    self.pageControl.numberOfPages = _imageCount;
    
    
    [self setDefaultImage];
    
    if (adImageArray.count > 1) {
        [self adTimer];
    }
}

@end
