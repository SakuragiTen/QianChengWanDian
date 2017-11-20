//
//  CJWHomeController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeController.h"
#import "CJWHomeCategoryCell.h"
#import "CJWAnnouncementCell.h"
@interface CJWHomeController ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *header;

@end

@implementation CJWHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupUI
{
    self.navigationController.navigationBar.hidden = YES;
    
    self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBar_Height, 0);
    
    self.tableView.tableHeaderView = _header;
    
//    [self.tableView registerClass:[CJWHomeCategoryCell class] forCellReuseIdentifier:@"cell"];

}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        //商品类目
        if (indexPath.row == 0) {
            CJWHomeCategoryCell *cell = [CJWHomeCategoryCell reuseCellWithTableView:tableView];
            return cell;
        }
        //头条 公告栏
        if (indexPath.row == 1) {
            CJWAnnouncementCell *cell = [CJWAnnouncementCell cellFromXibWithTableView:tableView];
            return cell;
        }
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
}


#pragma mark - lazyLoad
- (SDCycleScrollView *)header
{
    if (!_header) {
        _header = [[SDCycleScrollView alloc] init];
        
        _header.backgroundColor = [UIColor whiteColor];
        _header.autoScroll = YES;
        _header.showPageControl = YES;
        _header.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _header.currentPageDotColor = kCJWOrangeColor;
        _header.pageDotColor = [UIColor lightGrayColor];
        _header.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _header.autoScrollTimeInterval = 3.0f;
        _header.imageURLStringsGroup = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496926034716&di=5f208a2850a2aeb9b9184f0d1f7d2f14&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201512%2F23%2F20151223124910_WTJdf.jpeg", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496925996605&di=391d20f11010a2d8f9f288c5fde1c304&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201505%2F24%2F20150524182423_tNwRF.thumb.700_0.jpeg"];
        _header.delegate = self;
        _header.placeholderImage = [UIImage imageNamed:@""];
        _header.backgroundColor = [UIColor randomColor];
    }
    return _header;
}


@end
