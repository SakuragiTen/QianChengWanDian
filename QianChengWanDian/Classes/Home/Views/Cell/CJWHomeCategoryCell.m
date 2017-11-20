//
//  CJWHomeCategoryCell.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeCategoryCell.h"
#import "CJWHomeCategoryCollectionView.h"

@interface CJWHomeCategoryCell ()

@property (nonatomic, strong) CJWHomeCategoryCollectionView *collectionView;

@property (nonatomic, assign) CGSize contentSize;

@end

//static _contentSize = {0，0};
@implementation CJWHomeCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self.subviews.count <= 1) {
            _contentSize = CGSizeMake(SCREEN_WIDTH / 5.0, (SCREEN_WIDTH / 5.0 + 20) * 2);
            [self addSubview:self.collectionView];
            [self settingCollectionView];
        }
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)updateTableView
{
    UITableView *tableView = (UITableView *)self.superview.superview;
    if (CGSizeEqualToSize(_contentSize, _collectionView.contentSize)) return;
    _contentSize = _collectionView.contentSize;
     [tableView beginUpdates];
    [self settingCollectionView];
    [tableView endUpdates];
    
}

- (void)settingCollectionView
{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0).priority(750);
        make.height.mas_equalTo(_contentSize.height);
    }];
}

#pragma mark - lazyload
- (CJWHomeCategoryCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [CJWHomeCategoryCollectionView categoryCollectionView];
        [_collectionView performBatchUpdates:^{
          
        } completion:^(BOOL finished) {
            [self updateTableView];
        }];

    }
    return _collectionView;
}




@end
