//
//  CJWAnnouncementView.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWAnnouncementView.h"
#define kSize self.frame.size
#define kLabelFont 14
@interface CJWAnnouncementView () <UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *scrollView;

/** 左侧视图的大小 */
@property (nonatomic, assign) CGSize leftSize;

/** 当前显示的label */
@property (nonatomic, strong) UIButton *currentButton;

/** 复用的label */
@property (nonatomic, strong) UIButton *reuseButton;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSUInteger timeCount;

@property (nonatomic, copy) CJWAnnouncementBlock annouceBlock;

@end

@implementation CJWAnnouncementView

- (instancetype)init
{
    if (self = [super init]) {
        //默认向上滚动
        _direction = CJWBulletinDirectionTop;
    }
    return self;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.frame = CGRectMake(_leftSize.width, 0, kSize.width - _leftSize.width, kSize.height);
        _scrollView.delegate = self;
    }
    return _scrollView;
}




- (void)layoutSubviews
{
    [self initialSubView];
}

- (void)initialSubView
{
    if (_leftView) {
        _leftSize = CGSizeMake(50, kSize.height);
        _leftView.frame = CGRectMake(0, 0, _leftSize.width, _leftSize.height);
        self.leftView.backgroundColor = [UIColor blueColor];
        [self addSubview:_leftView];
    }
    
//        self.scrollView.backgroundColor = [UIColor yellowColor];
    
    [self addSubview:self.scrollView];
    
    
    [self settingScrollView];
}

- (void)settingScrollView
{
    CGFloat vertical = 2.0;
    CGFloat horizontal = 1.0;
    if (_direction == CJWBulletinDirectionLeft || _direction == CJWBulletinDirectionRight) {
        horizontal = 2.0;
        vertical = 1.0;
    }
    
    _scrollView.contentSize = CGSizeMake((kSize.width - _leftSize.width) * horizontal, kSize.height * vertical);
    
    _currentButton = [self titleButton];
    _currentButton.frame = CGRectMake(0, 0, kSize.width, kSize.height);
//        _currentButton.backgroundColor = [UIColor orangeColor];
    
    
    
    
    _reuseButton = [self titleButton];
    _reuseButton.frame = CGRectMake(0, kSize.height, kSize.width, kSize.height);
    //    _reuseButton.backgroundColor = [UIColor cyanColor];
    
    
    if (_contentArray.count == 1) {
        [_currentButton setTitle:_contentArray[0] forState:UIControlStateNormal];
        _scrollView.scrollEnabled = NO;
    } else {
        if (_contentArray.count > 1) {
            [_currentButton setTitle:_contentArray[_timeCount % _contentArray.count] forState:UIControlStateNormal];
            [_reuseButton setTitle:_contentArray[(_timeCount + 1) % _contentArray.count] forState:UIControlStateNormal];
            
            [self timer];
        }
    }
    
    [self initialLabelFrame];
    
    [_scrollView addSubview:_currentButton];
    [_scrollView addSubview:_reuseButton];
    
    
}

- (void)setRightSpace:(CGFloat)rightSpace
{
    
}




#pragma mark - 公告标签
- (UIButton *)titleButton
{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:kLabelFont];
    [button setTitleColor:[UIColor colorWithRed:69.0 / 255 green:69.0 / 255 blue:69.0 / 255 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //写死了的数据
    button.backgroundColor = [UIColor whiteColor];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    return button;
}

- (void)buttonClicked:(UIButton *)button
{
    //    NSLog(@"%@", button.currentTitle);
    if (_annouceBlock) {
        _annouceBlock(button.currentTitle);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

/** 交换公告显示label的指针 */
- (void)changeLabelPoint
{
    UIButton *temp = _currentButton;
    _currentButton = _reuseButton;
    _reuseButton = temp;
    
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    [_currentButton setTitle:_contentArray[_timeCount % _contentArray.count] forState:UIControlStateNormal];
    [_reuseButton setTitle:_contentArray[(_timeCount + 1) % _contentArray.count] forState:UIControlStateNormal];
    
    [self initialLabelFrame];
    
}

/** 初始化label的位置 */
- (void)initialLabelFrame
{
    CGFloat  width = kSize.width - _leftSize.width;
    
    CGFloat horizontal = 0.0;
    CGFloat vertical = 1.0;
    
    if (_direction == CJWBulletinDirectionLeft) {
        horizontal = 1.0;
        vertical = 0.0;
    }
    
    if (_direction == CJWBulletinDirectionRight) {
        horizontal = -1.0;
        vertical = 0.0;
    }
    
    if (_direction == CJWBulletinDirectionDown) {
        horizontal = 0;
        vertical = -1.0;
    }
    _currentButton.frame = CGRectMake(0, 0, width, kSize.height);
    _reuseButton.frame = CGRectMake(horizontal * width, kSize.height * vertical, width, kSize.height);
}

#pragma mark - 定时器
- (NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(circlBulletin) userInfo:nil repeats:YES];
    }
    
    return _timer;
}
- (void)circlBulletin
{
    _timeCount ++;
    [UIView animateWithDuration:1 animations:^{
        _scrollView.contentOffset = _reuseButton.frame.origin;
        
    } completion:^(BOOL finished) {
        [self changeLabelPoint];
    }];
}


- (void)didSelectedAnnouncement:(CJWAnnouncementBlock)block
{
    _annouceBlock = block;
}


@end
