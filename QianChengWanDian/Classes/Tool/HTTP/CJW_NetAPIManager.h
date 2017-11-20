//
//  CJW_NetAPIManager.h
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CJW_NetAPIManager : NSObject

SingletonInterface(Manager)

@end

static inline CJW_NetAPIManager * netWork() {
    return [CJW_NetAPIManager sharedManager];
}
