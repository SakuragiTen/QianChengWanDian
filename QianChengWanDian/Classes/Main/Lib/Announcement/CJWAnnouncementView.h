//
//  CJWAnnouncementView.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CJWBulletinDirectionTop,
    CJWBulletinDirectionLeft,
    CJWBulletinDirectionDown,
    CJWBulletinDirectionRight,
} CJWAnnouncementDirectionType;


typedef void(^CJWAnnouncementBlock)(NSString *content);
@interface CJWAnnouncementView : UIView

/** 文字距离右边的距离 */
@property (nonatomic, assign) CGFloat rightSpace;

/** 公告栏的左视图 */
@property (nonatomic, strong) UIView *leftView;

/** 公告滚动的方向 */
@property (nonatomic, assign) CJWAnnouncementDirectionType direction;

/** 公告的内容 <NSString> */
@property (nonatomic, strong) NSArray<NSString *> *contentArray;

- (void)didSelectedAnnouncement:(CJWAnnouncementBlock)block;


@end
