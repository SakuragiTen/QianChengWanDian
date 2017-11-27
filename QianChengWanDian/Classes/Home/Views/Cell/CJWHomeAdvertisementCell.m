//
//  CJWHomeAdvertisementCell.m
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeAdvertisementCell.h"
#import "CJWHomeModel.h"
@interface CJWHomeAdvertisementCell ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *advertisementView;

@end

@implementation CJWHomeAdvertisementCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (!_advertisementView) {
     
            [self.contentView addSubview:self.advertisementView];
//            [_advertisementView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.left.right.mas_equalTo(0);
//                make.bottom.mas_equalTo(0).priority(750);
//                make.height.mas_equalTo(105 * SCREEN_SCALE);
//            }];
            [self settingAdvertiseView] ;
        }
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setAdArray:(NSArray *)adArray
{
    _adArray = adArray;
    
    NSArray *imageArray = @[@"http://static.cjwsc.com/image/61/73/cc/6173ccda0efce9a34dd57b8ab9faa1ea.png"];//[CJWHomeAdvertisementModel imageUrlArrayWithArray:adArray];
    
    _advertisementView.imageURLStringsGroup = imageArray;
    
}

- (void)updateCycleView
{
    UITableView *tableView = [self currentTableView];
    [tableView beginUpdates];
    [self settingAdvertiseView];
    [tableView endUpdates];
}

- (void)settingAdvertiseView
{
    CGFloat top = _adArray.count ? 10 : 0;
    CGFloat height = _adArray.count ? 105 * SCREEN_SCALE : 0;
    [_advertisementView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(top);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
    }];
}
#pragma mark - lazyLoad
- (SDCycleScrollView *)advertisementView
{
    if (!_advertisementView) {
        _advertisementView = [[SDCycleScrollView alloc] init];
        _advertisementView.backgroundColor = [UIColor whiteColor];
        _advertisementView.autoScroll = YES;
        _advertisementView.showPageControl = YES;
        _advertisementView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _advertisementView.currentPageDotColor = kCJWOrangeColor;
        _advertisementView.pageDotColor = [UIColor lightGrayColor];
        _advertisementView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _advertisementView.autoScrollTimeInterval = 3.0f;
        _advertisementView.hidesForSinglePage = YES;
//        _advertisementView.imageURLStringsGroup = @[@"http://static.cjwsc.com/image/61/73/cc/6173ccda0efce9a34dd57b8ab9faa1ea.png"];
        _advertisementView.delegate = self;
        _advertisementView.placeholderImage = [UIImage imageNamed:@""];
  
    }
    return _advertisementView;
}
@end
