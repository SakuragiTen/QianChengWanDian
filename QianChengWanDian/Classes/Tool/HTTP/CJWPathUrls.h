//
//  CJWPathUrls.h
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#ifndef CJWPathUrls_h
#define CJWPathUrls_h

#define CJWDebug 1
#define CJWSTATUS @"status"
#define CJWCODE @"code"

//
//#define ROOT_SERVICE_INVOICE     @"http://baseservice_invoice.cjwsc.com"    //通联支付
//#define ROOT_JAVA_PORTAL            @"https://portal-web.cjwsc.com"  //javaPortal
//#define ROOT_UPLOAD     @"http://upload.cjwsc.com" //上传图片
//#define ROOT_WAP        @"http://m.cjwsc.com"   //m站
//#define ROOT_SELL       @"http://baseservice_cms.cjwsc.com" //特卖
//#define ROOT_BANNER     @"http://api.cjwsc.com"  //电子发票以及抽奖
//#define ROOT_JAVA_URL   @"https://portal-web.cjwsc.com"
//#define ROOT_PHP_URL     @"http://terminalapp.cjwsc.com"




#define ROOT_JAVA_URL  @"http://portal_order_web.jt.cjwsc.com"
#define ROOT_PHP_URL     @"http://terminalapp.test.cjwsc.com"
#define ROOT_UPLOAD                 @"http://upload.test.cjwsc.com"
#define ROOT_JAVA_PORTAL            @"http://portal_order_web.jt.cjwsc.com"
#define ROOT_WAP        @"http://m.branch1205.test.cjwsc.com"
#define ROOT_SELL       @"http://baseservice_cms.branch1205.test.cjwsc.com"
#define ROOT_BANNER     @"http://api.branch1205.test.cjwsc.com"
#define ROOT_SERVICE_INVOICE     @"http://gbaseservice_invoice.cjwsc.com"


#pragma mark - 首页 homepage

/** 首页轮播广告图 */
#define Home_Banner_Url        [NSString stringWithFormat:@"%@/home/topBanner.action",ROOT_JAVA_PORTAL]

/** 首页分类导航 */
#define Home_Category_Nav_Url  [NSString stringWithFormat:@"%@/home/navigation.action",ROOT_JAVA_PORTAL]

/** 首页最新头条 公告栏 */
#define Home_TouTiao_Url  [NSString stringWithFormat:@"%@/home/headLine.action",ROOT_JAVA_PORTAL]

/** 首页头条下面的广告 */
#define Home_Advertisement_Url  [NSString stringWithFormat:@"%@/home/terminalCmsAds.action",ROOT_JAVA_PORTAL]


#endif /* CJWPathUrls_h */
