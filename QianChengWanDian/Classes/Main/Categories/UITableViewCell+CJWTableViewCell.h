//
//  UITableViewCell+CJWTableViewCell.h
//  AgriculturalProduct
//
//  Created by Fireloli on 17/8/18.
//  Copyright © 2017年 cjwsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (CJWTableViewCell)


/* 纯代码创建的 */
+ (instancetype)reuseCellWithTableView:(UITableView *)tableView;

/* Xib创建的 */
+ (instancetype)cellFromXibWithTableView:(UITableView *)tableView;

@end
