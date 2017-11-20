//
//  AppDelegate+cjw.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "AppDelegate+cjw.h"

#define kVersionKey @"version"
@implementation AppDelegate (cjw)


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //运行APP
    [self lanuchApp];
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)lanuchApp
{
    //判断当前版本是不是最新
    
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
    
    BOOL newVersion = ![currentVersion isEqualToString:lastVersion];
    
    if (newVersion) {
        //新版本  进入引导页
//        LWLeadPageController *leadVC = [[LWLeadPageController alloc] init];
//        self.window.rootViewController = leadVC;
        [CJWApplicationTool chooseRootViewController:self.window];
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
        
        
    } else {
        [CJWApplicationTool chooseRootViewController:self.window];
    }
}

@end
