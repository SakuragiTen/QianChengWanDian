//
//  CJWActivityIndicatorView.m
//  SELL_iOS
//
//  Created by Yunxin.Li on 16/4/5.
//  Copyright © 2016年 CJW. All rights reserved.
//

#import "CJWActivityIndicatorView.h"

@interface CJWActivityIndicatorView ()

@property (nonatomic) CALayer *backgroundLayer;
@property (nonatomic) CAShapeLayer *progressLayer;

@end

@implementation CJWActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    
    self.lineWidth = 3 * SCREEN_SCALE;
    self.tintColor = [UIColor colorWithRed:181.0 / 255.0 green:182.0 / 255.0 blue:183.0 / 255.0 alpha:1.0];
    self.radius = 14.0;
    
    [self.backgroundLayer addSublayer:self.progressLayer];
    
    self.backgroundView = [self defaultBackgroundView];
    
    self.hidden = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapButt;
    path.lineWidth = self.lineWidth;
    [path addArcWithCenter:self.backgroundView.center radius:self.radius + self.lineWidth / 2 startAngle:-M_PI_2 endAngle:M_PI + M_PI_2 clockwise:YES];
    
    self.progressLayer.path = path.CGPath;
}

#pragma mark -

- (UIView *)defaultBackgroundView {
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor clearColor];
    
    return backgroundView;
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (_backgroundView.superview) {
        [_backgroundView removeFromSuperview];
    }
    
    backgroundView.frame = self.bounds;
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.backgroundLayer removeFromSuperlayer];
    [backgroundView.layer addSublayer:self.backgroundLayer];
    
    [self addSubview:backgroundView];
    
    _backgroundView = backgroundView;
}

- (CALayer *)backgroundLayer {
    if (!_backgroundLayer) {
        _backgroundLayer = [CALayer layer];
        _backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _backgroundLayer;
}

- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor clearColor].CGColor;
        _progressLayer.strokeColor = self.tintColor.CGColor;
        _progressLayer.lineWidth = self.lineWidth;
        _progressLayer.strokeStart = 0.05;
        _progressLayer.strokeEnd = 0.95;
    }
    return _progressLayer;
}

#pragma mark -

- (CGFloat)lineWidth {
    return self.progressLayer.lineWidth;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.progressLayer.lineWidth = lineWidth;
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self setNeedsLayout];
}

- (UIColor *)tintColor {
    return [UIColor colorWithCGColor:self.progressLayer.strokeColor];
}

- (void)setTintColor:(UIColor *)tintColor {
    _progressLayer.strokeColor = tintColor.CGColor;
}

#pragma mark -
- (void)startAnimating {
    self.hidden = NO;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.toValue = @(M_PI);
    animation.duration = 0.25;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.repeatCount = MAXFLOAT;
    animation.cumulative = YES;
    
    [self.backgroundLayer addAnimation:animation forKey:nil];
}

- (void)stopAnimating {
    [self.backgroundLayer removeAllAnimations];
    
    self.hidden = YES;
}

@end
