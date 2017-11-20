//
//  UITableViewCell+CJWTableViewCell.m
//  AgriculturalProduct
//
//  Created by Fireloli on 17/8/18.
//  Copyright © 2017年 cjwsc. All rights reserved.
//

#import "UITableViewCell+CJWTableViewCell.h"

@implementation UITableViewCell (CJWTableViewCell)


+ (instancetype)reuseCellWithTableView:(UITableView *)tableView
{
    NSString *identifier = NSStringFromClass([self class]);
    
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    
    
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}


/* Xib创建的 */
+ (instancetype)cellFromXibWithTableView:(UITableView *)tableView
{
    NSString *identifier = NSStringFromClass([self class]);
    
    [tableView registerNib:[UINib nibWithNibName:identifier bundle:nil] forCellReuseIdentifier:identifier];
    
    return [tableView dequeueReusableCellWithIdentifier:identifier];
}

@end
