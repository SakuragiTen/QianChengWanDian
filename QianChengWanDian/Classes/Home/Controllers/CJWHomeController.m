//
//  CJWHomeController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/16.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeController.h"

//所有的cell
#import "CJWHomeCellHeader.h"
//所有的子控制器（首页跳转的页面）
#import "CJWHomeSubControllerHeader.h"
//首页的model
#import "CJWHomeModel.h"

@interface CJWHomeController ()<SDCycleScrollViewDelegate>

/** header图片轮播 */
@property (nonatomic, strong) SDCycleScrollView *header;

/** 图片轮播数组 */
@property (nonatomic, strong) NSArray *bannerArray;



@end

@implementation CJWHomeController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.设置界面
    [self setupUI];
    
    //2.请求数据
    [self requestHomeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)setupUI
{
    //隐藏导航栏
    self.navigationController.navigationBar.hidden = YES;
    
    //图片大小 750*436  等比例缩放
    self.header.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.581);
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TabBar_Height, 0);
    
    self.tableView.tableHeaderView = _header;
    
    //添加下拉刷新
    [self settingHeaderFooterRefresh];
    

}
- (void)settingHeaderFooterRefresh
{
    
    CJWWeakSelf(weakSelf)
    CJWRefreshHeader *header = [CJWRefreshHeader headerWithRefreshingBlock:^{
        //重新请求数据
        [weakSelf requestHomeData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    
    self.tableView.mj_header = header;
    
    CJWRefreshFooter *footer = [CJWRefreshFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        });
    }];
    
    self.tableView.mj_footer = footer;
    
}


#pragma mark - 请求数据
- (void)requestHomeData
{
    //1.请求header轮播图
    [self requestBanner];
    
    //2，请求分类导航的数据
    [self requestCategoryData];
    
    //3，请求最新头条数据
    /** 头条公告的数据在cell里请求 */
    
    //4，请求头条下的广告位
    [self requestHomeAdvertisement];
}

#pragma mark - 头部轮播图
/** 请求首页轮播图 */
- (void)requestBanner
{
    
    [netWork() requestHomeBannerWithHudView:self.view completionHandle:^(id data) {
        _bannerArray = [CJWHomeBannerModel objectsArrayWithKeyValuesArray:data];
        self.header.imageURLStringsGroup = [self getImageUrlWithArray:_bannerArray];
    }];
}
/** 获取轮播图的URL */
- (NSArray *)getImageUrlWithArray:(NSArray *)array
{
    NSMutableArray *temp = [NSMutableArray array];
    for (CJWHomeBannerModel *model in array) {
        [temp addObject:model.pic];
    }
    
    return temp;
}
/**  SDCycleScrollViewDelegate 轮播图的点击跳转 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //根据类型来跳转
    
    CJWHomeBannerModel *model = _bannerArray[index];
    
    CJWHomeBannerWebController *vc = [[CJWHomeBannerWebController alloc] init];
    vc.url = model.link;
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 分类导航
/** 请求分类导航的数据 */
- (void)requestCategoryData
{
    [netWork() requestHomeCategoryWithHudView:self.view completionHandle:^(id data) {
        NSArray *array = [CJWHomeCategoryModel objectsArrayWithKeyValuesArray:data];
        
        [self reloadCategoryCellWithArray:array];
    }];
}

//刷新分类的数据
- (void)reloadCategoryCellWithArray:(NSArray *)category
{
    CJWHomeCategoryCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.categoryArray = category;
}

#pragma mark - 头条下的广告
- (void)requestHomeAdvertisement
{
    [netWork() requestHomeAdvertisementWithHudView:self.view completionHandle:^(id data) {
        NSArray *adArray = [CJWHomeAdvertisementModel objectsArrayWithKeyValuesArray:data];
        
        [self reloadAdvertisementCellWithArray:adArray];
    }];
    
    [self reloadAdvertisementCellWithArray:@[]];
}

//刷新广告的图片
- (void)reloadAdvertisementCellWithArray:(NSArray *)array
{
    CJWHomeAdvertisementCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    cell.adArray = array;
}




#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [@[@3, @1, @1, @1, @10][section] integerValue];
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
        if (indexPath.row == 1) {
            //月末特卖   广告位
            CJWHomeAdvertisementCell  *cell = [CJWHomeAdvertisementCell  reuseCellWithTableView:tableView];
            
            return cell;
        }
    }
    
    
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section) return 10;
    
    
    return [super tableView:tableView heightForHeaderInSection:section];
    
    
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
        _header.hidesForSinglePage = YES;

        _header.delegate = self;
        _header.placeholderImage = [UIImage imageNamed:@""];
        _header.backgroundColor = [UIColor whiteColor];
    }
    return _header;
}


@end
