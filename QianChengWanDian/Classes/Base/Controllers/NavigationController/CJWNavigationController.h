//
//  CJWNavigationController.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface CJWWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (CJWWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface CJWNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *cjw_viewControllers;

@end
