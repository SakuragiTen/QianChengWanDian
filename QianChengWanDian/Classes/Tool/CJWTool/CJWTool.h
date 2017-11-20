//
//  CJWTool.h
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJWTool : NSObject

SingletonInterface(Tool)


/** 获取IP地址 */
+ (NSString *)getIPAddress;

/** 获取设备号 */
+ (NSString *)getDeviceIdentifier;

@end
