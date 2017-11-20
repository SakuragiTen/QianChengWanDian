//
//  UIViewController+CJWNavigationExtension.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJWNavigationController.h"
@interface UIViewController (CJWNavigationExtension)

@property (nonatomic, assign) BOOL cjw_fullScreenPopGestureEnabled;

@property (nonatomic, strong) CJWNavigationController *cjw_navigationController;

@end
