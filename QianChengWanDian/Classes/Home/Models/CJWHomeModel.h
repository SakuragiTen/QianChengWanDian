//
//  CJWHomeBannerModel.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWBaseModel.h"


#pragma mark - 顶部图片轮播

@interface CJWHomeBannerModel : CJWBaseModel

/** 广告类型 */
@property (nonatomic, assign) NSInteger ads_type;

/** 广告名称 */
@property (nonatomic, copy) NSString *adsName;

/** 图片链接  */
@property (nonatomic, copy) NSString *pic;

/** 品牌id   */
@property (nonatomic, copy) NSString *brand_id;

/**  分类id */
@property (nonatomic, copy) NSString *category_id;

/** 商品id  */
@property (nonatomic, copy) NSString *product_id;

/** O2O店铺id  */
@property (nonatomic, copy) NSString *store_id;

/** 跳转链接 */
@property (nonatomic, copy) NSString *link;

/** 广告标题*/
@property (nonatomic, copy) NSString *title;


@end




#pragma mark - 分类导航
@interface CJWHomeCategoryModel : CJWBaseModel

/** 分类名 */
@property (nonatomic, copy) NSString *name;

/** 对应的图标 */
@property (nonatomic, copy) NSString *icon;

/** 分类名 */
@property (nonatomic, copy) NSString *value;



@end




#pragma mark - 头条
@interface CJWHomeHeadLineModel : CJWBaseModel

/** 创建人id*/
@property (nonatomic, copy) NSString *add_user_id;

/** 封面图片*/
@property (nonatomic, copy) NSString *cover;

/** 创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 标题*/
@property (nonatomic, copy) NSString *title;


/** 获取标题数组 */
+ (NSArray *)titleArrayWithArray:(NSArray *)array;

@end


#pragma mark - 广告 头条下面的广告

@interface CJWHomeAdvertisementModel : CJWBaseModel

/** 广告名称   */
@property (nonatomic, copy) NSString *adsName;

/** 广告图片 */
@property (nonatomic, copy) NSString *adsPic;

/** 广告类型  1、引导广告 2、首页广告 3、个人中心广告 */
@property (nonatomic, copy) NSString *adsType;

/** 跳转类型  1:商品 2：H5 3:不跳转 4：品牌 5：分类*/
@property (nonatomic, copy) NSString *linkType;

/** 适用平台 1、全部2千城万店APP、3、千城万店电子屏4、 WAP */
@property (nonatomic, strong) NSString *platform;

/** 关联内容 */
@property (nonatomic, copy) NSString *relation;

/** 适用对象 1：全部；2： 屏主； 3：普通用户 */
@property (nonatomic, copy) NSString *target;

/** 状态 1.启用；2.停用 */
@property (nonatomic, copy) NSString *status;


/** 获取图片的url数组 */
+ (NSArray *)imageUrlArrayWithArray:(NSArray *)array;

@end









