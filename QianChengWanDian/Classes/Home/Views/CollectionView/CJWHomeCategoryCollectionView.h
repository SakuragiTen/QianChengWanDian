//
//  CJWHomeCategoryCollectionView.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJWHomeCategoryCollectionView : UICollectionView


+ (instancetype)categoryCollectionView;

/** 分类导航数组 */
@property (nonatomic, strong) NSArray *categoryArray;

@end
