//
//  CJW_NetAPIManager.m
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJW_NetAPIManager.h"

#import "CJWNetAPIClient.h"

@implementation CJW_NetAPIManager

SingletonImplementation(Manager)

/** 首页轮播广告图 */
- (void)requestHomeBannerWithHudView:(UIView *)view completionHandle:(void (^)(id))handle
{

    [[CJWNetAPIClient sharedClient] requestDataWithUrl:Home_Banner_Url params:nil requestMethod:Post requestType:Java handleCompletion:^(id data, NSError *error) {
        id newData = [self configData:data error:error view:view];
        if ([self checkResponseData:newData withKey:@"ads_list"]) handle(newData[@"ads_list"]);
    }];
}


/** 首页扥类导航 */
- (void)requestHomeCategoryWithHudView:(UIView *)view completionHandle:(void (^)(id))handle
{

    [[CJWNetAPIClient sharedClient] requestDataWithUrl:Home_Category_Nav_Url params:nil requestMethod:Post requestType:Java handleCompletion:^(id data, NSError *error) {
        id newData = [self configData:data error:error view:view];
        if ([self checkResponseData:newData withKey:@"list"]) handle(newData[@"list"]);
    }];
}

/** 首页头条 公告 */
- (void)requestHomeHeadLineWithHudView:(UIView *)view completionHandle:(void(^)(id data))handle
{
    //lists
    [[CJWNetAPIClient sharedClient] requestDataWithUrl:Home_TouTiao_Url params:nil requestMethod:Post requestType:Java handleCompletion:^(id data, NSError *error) {
        id newData = [self configData:data error:error view:view];
        if ([self checkResponseData:newData withKey:@"lists"]) handle(newData[@"lists"]);
    }];
}

/** 首页广告， 头条下面的广告栏 */
- (void)requestHomeAdvertisementWithHudView:(UIView *)view completionHandle:(void(^)(id data))handle
{
    [[CJWNetAPIClient sharedClient] requestDataWithUrl:Home_Advertisement_Url params:@{@"adsType" : @"2"} requestMethod:Post requestType:Java handleCompletion:^(id data, NSError *error) {
        id newData = [self configData:data error:error view:view];
        if ([self checkResponseData:newData withKey:@"list"]) handle(newData[@"list"]);
    }];
}




#pragma mark - 请求不成功时  读取后台返回的信息
- (id)configData:(id)response error:(NSError *)error view:(UIView *)view
{
    if (response) {
        if ([response[CJWSTATUS] integerValue] != 200) {
            [MBProgressHUD showError:response[@"message"] toView:view];
            
        } else {
            if ([response[@"data"] isKindOfClass:[NSNull class]]) {
                return @"null";
            }
            return response[@"data"] ;
        }
        
    } else {
        NSString *errorStr = @"接口请求出错";
        if (error)  errorStr = error.userInfo[@"message"] ? : error.localizedDescription;
        
        [MBProgressHUD showError:errorStr toView:view];
    }
    
    return nil;
}

- (BOOL)checkResponseData:(id)data withKey:(NSString *)key
{
    if (key.length == 0) {
        return [data isKindOfClass:[NSDictionary class]];
    } else {
        if ([data isKindOfClass:[NSDictionary class]]) {
            return data[key];
        } else {
            return NO;
        }
    }
}


@end


