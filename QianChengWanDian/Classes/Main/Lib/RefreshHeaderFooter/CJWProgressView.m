//
//  CJWProgressView.m
//  SELL_iOS
//
//  Created by Yunxin.Li on 16/4/3.
//  Copyright © 2016年 CJW. All rights reserved.
//

#import "CJWProgressView.h"

@interface CJWProgressView ()

@property (nonatomic) CALayer *backgroundLayer;

@end

@implementation CJWProgressView

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
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapButt;
    path.lineWidth = self.lineWidth;
    [path addArcWithCenter:self.backgroundView.center radius:self.radius + self.lineWidth / 2 startAngle:-M_PI_2 endAngle:M_PI + M_PI_2 clockwise:YES];
    
    self.progressLayer.path = path.CGPath;
    
    self.iconImgV.frame = CGRectMake((self.bounds.size.width-16)/2, (self.bounds.size.height-16)/2, 16, 16);
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
    
    [self.iconImgV removeFromSuperview];
    [backgroundView addSubview:self.iconImgV];
    
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

- (UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc] init];
        _iconImgV.image = [UIImage imageNamed:@"pull_refresh_arrow.png"];
    }
    return _iconImgV;
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

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:YES];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    if (_progress >= 1.0 && progress >= 1.0) {
        _progress = 1.0;
        return;
    }
    
    if (progress < 0.0) {
        progress = 0.0;
    }
    if (progress > 1.0) {
        progress = 1.0;
    }
    
    if (progress > 0.0) {
        self.hidden = NO;
    }
    
    self.progressLayer.actions = animated ? nil : @{@"strokeEnd": [NSNull null]};
    self.progressLayer.strokeEnd = progress*0.9 + 0.05;
    
    if (progress >= 1.0) {
        
    }
    
    _progress = progress;
}

@end
