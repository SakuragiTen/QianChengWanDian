//
//  MBProgressHUD+extension.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (extension)

/** 加载 */
+ (void)showLoading:(NSString *)loading toView:(UIView *)view;

/** 成功 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

/** 错误 */

+ (void)showError:(NSString *)error toView:(UIView *)view;

/** 警告 */
+ (void)showWarning:(NSString *)info toView:(UIView *)view;


/** 文字提示 */
+ (void)showTips:(NSString *)msg toView:(UIView *)view;

/** 隐藏 */
+ (void)hideHUDForView:(UIView *)view;

@end
