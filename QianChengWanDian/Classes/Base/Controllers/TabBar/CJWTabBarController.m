//
//  CJWTabBarController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWTabBarController.h"

@interface CJWTabBarController ()


/** 控制器item */
@property (nonatomic, strong) NSArray *items;

/** 选中图片 */
@property (nonatomic, strong) NSArray *selectedImages;

/** 正常图片 */
@property (nonatomic, strong) NSArray *normalImages;

/** 标题 */
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation CJWTabBarController


+ (instancetype)cjw_tabBarController
{
    NSArray *items = @[@"CJWHomeController", @"CJWCategoryController", @"CJWSaleController", @"CJWShopCarController", @"CJWMineController"];
    NSArray *selectedImages = @[@"home_Selected", @"category_Selected", @"saleSell_Selected", @"car_Selected", @"me_Selected"];
    NSArray *normalImages = @[@"home_Normal", @"category_Normal", @"saleSell_Normal", @"car_Normal", @"me_Normal"];
    
    NSArray *titleArray = @[@"主页", @"分类", @"特卖", @"购物车", @"我的"];
    
    
    CJWTabBarController *tabBar = [self tabBarControllerWithItems:items selectedImages:selectedImages normalImages:normalImages titleArray:titleArray];
    
    return tabBar;
}

+ (instancetype)tabBarControllerWithItems:(NSArray *)items selectedImages:(NSArray *)selectedImages normalImages:(NSArray *)normalImages titleArray:(NSArray *)titleArray
{
    return [[self alloc] initWithItems:items selectedImages:selectedImages normalImages:normalImages titleArray:titleArray];
}
- (instancetype)initWithItems:(NSArray *)items selectedImages:(NSArray *)selectedImages normalImages:(NSArray *)normalImages titleArray:(NSArray *)titleArray
{
    if (self = [super init]) {
        self.items = items;
        self.selectedImages = selectedImages;
        self.normalImages = normalImages;
        self.titleArray = titleArray;
        
        // 添加所有子控制器
        [self setUpAllChildViewController];
    }
    return self;
}
- (void)setUpAllChildViewController
{
    for (int i = 0; i < _items.count; i ++) {
        
        Class itemClass = NSClassFromString(_items[i]);
        UIViewController *vc = [[itemClass alloc] init];
        
        CJWNavigationController *nav = [[CJWNavigationController alloc] initWithRootViewController:vc];
        
         [self addChildViewController:nav];
        
        nav.tabBarItem.image = [UIImage imageNamed:_normalImages[i]];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:_selectedImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.title = _titleArray[i];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(95,100,110)} forState:UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kCJWOrangeColor} forState:UIControlStateSelected];
    }
}

@end
