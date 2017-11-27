//
//  CJW_NetAPIManager.h
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJWPathUrls.h"

@interface CJW_NetAPIManager : NSObject

SingletonInterface(Manager)

#pragma mark - =====================首页数据请求===============

/** 首页轮播广告图 */
- (void)requestHomeBannerWithHudView:(UIView *)view completionHandle:(void(^)(id data))handle;

/** 首页扥类导航 */
- (void)requestHomeCategoryWithHudView:(UIView *)view completionHandle:(void(^)(id data))handle;

/** 首页头条 公告 */
- (void)requestHomeHeadLineWithHudView:(UIView *)view completionHandle:(void(^)(id data))handle;

/** 首页广告， 头条下面的广告栏 */
- (void)requestHomeAdvertisementWithHudView:(UIView *)view completionHandle:(void(^)(id data))handle;


@end

static inline CJW_NetAPIManager * netWork() {
    return [CJW_NetAPIManager sharedManager];
}
