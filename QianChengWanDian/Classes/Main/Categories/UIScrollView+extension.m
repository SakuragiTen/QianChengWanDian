//
//  UIScrollView+extension.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//œ

#import "UIScrollView+extension.h"

@implementation UIScrollView (extension)

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_11_0
+ (void)load {
    [super load];
    //因为是为了适配iOS11 所以只有在系统是iOS11的时候用过运行时修改这个值
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) {
        Method originalM = class_getInstanceMethod([self class], @selector(initWithFrame:));
        Method exchangeM = class_getInstanceMethod([self class], @selector(cjw_initWithFrame:));
        method_exchangeImplementations(originalM, exchangeM);
    }
}

- (instancetype)cjw_initWithFrame:(CGRect)frame {
    
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    return [self cjw_initWithFrame:frame];
}

#endif

@end
