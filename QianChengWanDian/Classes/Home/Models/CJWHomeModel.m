//
//  CJWHomeBannerModel.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeModel.h"

#pragma mark - 顶部轮播图
@implementation CJWHomeBannerModel

@end




#pragma mark - 分类导航
@implementation CJWHomeCategoryModel

@end


#pragma mark - 头条公告
@implementation CJWHomeHeadLineModel

+ (NSArray *)titleArrayWithArray:(NSArray *)array
{
    NSMutableArray *temp = [NSMutableArray array];
    for (CJWHomeHeadLineModel *model in array) {
        [temp addObject:model.title];
    }
    return temp;
}

@end

#pragma mark - 首页广告  头条下面的广告位
@implementation CJWHomeAdvertisementModel


+ (NSArray *)imageUrlArrayWithArray:(NSArray *)array
{
    NSMutableArray *temp = [NSMutableArray array];
    for (CJWHomeAdvertisementModel *model in array) {
        [temp addObject:model.adsPic];
    }
    return temp;
}

@end
