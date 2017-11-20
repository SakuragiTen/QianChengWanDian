//
//  CJWBaseTableViewController.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWBaseViewController.h"

@interface CJWBaseTableViewController : CJWBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

/** 一般通过 `initWithStyle:` 方法初始化，对于要生成 `UITableViewStyleGroup` 类型的列表，推荐使用 `init:` 方法 */
- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
