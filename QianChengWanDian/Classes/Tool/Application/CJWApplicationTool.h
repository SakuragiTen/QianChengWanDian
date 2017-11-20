//
//  CJWApplicationTool.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJWApplicationTool : NSObject

SingletonInterface(ApplicationTool)


+ (void)chooseRootViewController:(UIWindow *)window;

@end
