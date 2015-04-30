//
//  BannerRollView.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "BannerRollView.h"

@interface BannerRollView() {
    UIImageView *currentImageView; // 当前视图
    UIImageView *nextImageView; // 下一个视图
    UIImageView *previousImageView;  // 上一个视图
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isDraging;
@property (assign, nonatomic) int currentIndex;
@end

@implementation BannerRollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BannerRollView *) initWithFrame:(CGRect)frame withPictures:(NSArray *)pictures {
    self = [super initWithFrame:frame];
    if (self) {
        self.pictures = pictures;
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(frame.size.width * 3, 0);
        _scrollView.contentOffset = CGPointMake(frame.size.width, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc] init];
        
        // 初始化上一个视图
        previousImageView = [[UIImageView alloc] init];
        previousImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        previousImageView.image = [_pictures objectAtIndex:_pictures.count-1];
        previousImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:previousImageView];
        
        // 初始化当前视图
        currentImageView = [[UIImageView alloc] init];
        currentImageView.frame = CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height);
        currentImageView.image = [_pictures objectAtIndex:0];
        currentImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:currentImageView];
        
        // 初始化下一个视图
        nextImageView = [[UIImageView alloc] init];
        nextImageView.frame = CGRectMake(frame.size.width * 2, 0, frame.size.width, frame.size.height);
        nextImageView.image = [_pictures objectAtIndex:1];
        nextImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:nextImageView];
        
        _currentIndex = 0;
    }
    [self initTimer];
    return self;
}

- (void)dealloc {
    [self endTimer];
}

#pragma mark - 计时器
- (void)initTimer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(move) userInfo:nil repeats:YES];
    }
}

- (void)endTimer {
    if (_timer != nil) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)startTimer {
    if (_timer != nil) {
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)stopTimer {
    if (_timer != nil) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}

#pragma mark - UIScrollView 代理
#pragma mark 准备开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDraging = YES;
}

#pragma amrk 停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _isDraging = NO;
}

#pragma mark 视图停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"currentIndex : %d", _currentIndex);
}

#pragma mark 视图滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = _scrollView.contentOffset.x;
    
    if (nextImageView.image == nil || previousImageView.image == nil) {
        // 加载下一个视图
        nextImageView.image = [_pictures objectAtIndex:(_currentIndex == _pictures.count-1 ? 0 : _currentIndex+1)];
        // 加载上一个视图
        previousImageView.image = [_pictures objectAtIndex:(_currentIndex == 0 ? _pictures.count-1 : _currentIndex-1)];
    }

    // 向左
    if (offset == 0) {
        currentImageView.image = previousImageView.image;
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
        previousImageView.image = nil;
        if (_currentIndex == 0) {
            _currentIndex = (int)_pictures.count-1;
        } else {
            _currentIndex -= 1;
        }
    }
    
    // 向右
    if (offset == _scrollView.frame.size.width * 2) {
        currentImageView.image = nextImageView.image;
        _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
        nextImageView.image = nil;
        if (_currentIndex == _pictures.count-1) {
            _currentIndex = 0;
        } else {
            _currentIndex += 1;
        }
    }
}

- (void)move {
    if (_isDraging) {
        return;
    }
    CGPoint offset = _scrollView.contentOffset;
    CGFloat pagewidth = _scrollView.frame.size.width;
    
    // 向右
    offset.x += pagewidth;
    
    [_scrollView setContentOffset:offset animated:YES];
}

@end
