//
//  System.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#ifndef System_h
#define System_h


/** screen bounds */
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds

/** screen width */
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

/** screen height */
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

/** tabBar height */
#define TabBar_Height 49.0

#define NavBar_Height 64

//基于375屏幕下的比例
#define SCREEN_SCALE  (SCREEN_WIDTH / 375.0)

#define CJWWeakSelf(weakSelf) __weak typeof(self) weakSelf = self;


#define CJW_B2C_SERVER_NAME        @"com.cjwsc.cjwapp.b2c"
#define CJW_B2C_UUID_KEY           @"com.cjwsc.cjwapp.b2c.uuid"


#endif /* System_h */
