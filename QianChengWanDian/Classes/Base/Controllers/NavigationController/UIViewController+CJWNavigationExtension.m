//
//  UIViewController+CJWNavigationExtension.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "UIViewController+CJWNavigationExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (CJWNavigationExtension)


- (BOOL)cjw_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCjw_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(cjw_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (CJWNavigationController *)cjw_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setCjw_navigationController:(CJWNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(cjw_navigationController), navigationController, OBJC_ASSOCIATION_RETAIN);
}

@end
