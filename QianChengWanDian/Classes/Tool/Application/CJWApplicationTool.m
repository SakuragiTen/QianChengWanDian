//
//  CJWApplicationTool.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWApplicationTool.h"
#import "CJWTabBarController.h"
@implementation CJWApplicationTool

SingletonImplementation(ApplicationTool)


+ (void)chooseRootViewController:(UIWindow *)window
{
    CJWTabBarController *tabVC = [CJWTabBarController cjw_tabBarController];
    
    window.rootViewController = tabVC;
}

@end
