//
//  CJWRefreshFooter.m
//  SELL_iOS
//
//  Created by Yunxin.Li on 16/3/24.
//  Copyright © 2016年 CJW. All rights reserved.
//

#import "CJWRefreshFooter.h"
#import "CJWActivityIndicatorView.h"

@interface CJWRefreshFooter()
@property (weak, nonatomic) CJWActivityIndicatorView *loading;
@property (weak, nonatomic) UIView *noMoreBgView;
@property (weak, nonatomic) UILabel *noMoreTipL;
@property (weak, nonatomic) UIView *noMoreLeftLineV;
@property (weak, nonatomic) UIView *noMoreRightLineV;
@end

@implementation CJWRefreshFooter
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    CJWActivityIndicatorView *loading = [[CJWActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    loading.radius = 12;
    [self addSubview:loading];
    self.loading = loading;
    
    UIView *tipBgView = [[UIView alloc] init];
    tipBgView.backgroundColor = [UIColor clearColor];
    [self addSubview:tipBgView];
    self.noMoreBgView = tipBgView;
    
    UILabel *tipL = [[UILabel alloc] init];
    tipL.textColor = [UIColor lightGrayColor];
    tipL.font = [UIFont systemFontOfSize:13.f];
    tipL.textAlignment = NSTextAlignmentCenter;
    tipL.text = @"亲，看完了";
    [tipBgView addSubview:tipL];
    self.noMoreTipL = tipL;
    
    UIView *leftLineV = [[UIView alloc] init];
    leftLineV.backgroundColor = [UIColor lightGrayColor];
    [tipBgView addSubview:leftLineV];
    self.noMoreLeftLineV = leftLineV;
    
    UIView *rightLineV = [[UIView alloc] init];
    rightLineV.backgroundColor = [UIColor lightGrayColor];
    [tipBgView addSubview:rightLineV];
    self.noMoreRightLineV = rightLineV;
    self.automaticallyHidden = NO;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.loading.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
    self.noMoreBgView.frame = self.bounds;
    self.noMoreTipL.frame = self.bounds;
    self.noMoreLeftLineV.frame = CGRectMake(self.mj_w * 0.5-74.f-64.f, (self.mj_h - 1.f)*0.5, 64.f, 0.8);
    self.noMoreRightLineV.frame = CGRectMake(self.mj_w * 0.5+74.f, (self.mj_h - 1.f) * 0.5, 64.f, 0.8);
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
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.loading stopAnimating];
            self.noMoreBgView.hidden = YES;
            break;
        case MJRefreshStateRefreshing:
            [self.loading startAnimating];
            self.noMoreBgView.hidden = YES;
            break;
        case MJRefreshStateNoMoreData:
            [self.loading stopAnimating];
            self.noMoreBgView.hidden = NO;
            break;
        default:
            break;
    }
}

@end
