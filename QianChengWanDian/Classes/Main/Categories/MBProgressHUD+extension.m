//
//  MBProgressHUD+extension.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "MBProgressHUD+extension.h"
static NSInteger const HiddleTime = 2.333;//隐藏时间

@implementation MBProgressHUD (extension)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    //先隐藏显示的HUD
    MBProgressHUD *oldHud = [self HUDForView:view];
    if (oldHud) {
        oldHud.removeFromSuperViewOnHide = YES;
        [oldHud hideAnimated:NO];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    hud.animationType = MBProgressHUDAnimationFade;
    if (icon && icon.length) {
        // 设置自定义模式
        hud.mode = MBProgressHUDModeCustomView;
        // 设置图片
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD_CJW.bundle/%@", icon]]];
        // 等待多长时间之后再消失
        [hud hideAnimated:YES afterDelay:HiddleTime];
    }
    else{
        // 设置加载菊花的模式
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
}
/** 加载 */
+ (void)showLoading:(NSString *)loading toView:(UIView *)view
{
    [self show:loading icon:nil view:view];
}

/** 成功 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"MBHUD_Success" view:view];
}

/** 错误 */

+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"MBHUD_Error" view:view];
}

/** 警告 */
+ (void)showWarning:(NSString *)info toView:(UIView *)view
{
    [self show:info icon:@"MBHUD_Warn" view:view];
}


/** 文字提示 */
+ (void)showTips:(NSString *)msg toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    //先隐藏显示的HUD
    MBProgressHUD *oldHud = [self HUDForView:view];
    if (oldHud) {
        oldHud.removeFromSuperViewOnHide = YES;
        [oldHud hideAnimated:NO];
    }
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = msg;
    hud.label.numberOfLines = 0;
    hud.contentColor = [UIColor whiteColor];
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    hud.animationType = MBProgressHUDAnimationFade;
    
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:1.5];
}
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}
@end
