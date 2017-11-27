//
//  CJWRefreshHeader.m
//  ManufacturerNet
//
//  Created by Yunxin.Li on 15/9/1.
//  Copyright (c) 2015年 CJW. All rights reserved.
//

#import "CJWRefreshHeader.h"
#import "CJWProgressView.h"
#import "CJWActivityIndicatorView.h"

@interface CJWRefreshHeader()
@property (weak, nonatomic) CJWProgressView *indicator;
@property (weak, nonatomic) CJWActivityIndicatorView *loadingView;
@end

@implementation CJWRefreshHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 60;
    
    CJWProgressView *indicator = [[CJWProgressView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:indicator];
    self.indicator = indicator;
    
    CJWActivityIndicatorView *loadingView = [[CJWActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self addSubview:loadingView];
    self.loadingView = loadingView;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.indicator.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.loadingView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.indicator.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.indicator.hidden = NO;
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.indicator.hidden = NO;
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0;
        [self.loadingView startAnimating];
        
        self.indicator.alpha = 1.0;
        self.indicator.progressLayer.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.indicator.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.indicator.alpha = 1.0;
            self.indicator.progressLayer.hidden = NO;
            self.indicator.hidden = YES;
        }];
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    [_indicator setProgress:pullingPercent];
}

@end