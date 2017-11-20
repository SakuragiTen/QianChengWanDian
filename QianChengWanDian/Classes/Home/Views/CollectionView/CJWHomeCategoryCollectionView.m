//
//  CJWHomeCategoryCollectionView.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeCategoryCollectionView.h"
#import "CJWHomeCategoryCollectionCell.h"
@interface CJWHomeCategoryCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation CJWHomeCategoryCollectionView


+ (instancetype)categoryCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH / 5.0, SCREEN_WIDTH / 5.0 + 20);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return [[self alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10) collectionViewLayout:layout];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self registerNib:[UINib nibWithNibName:@"CJWHomeCategoryCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"CJWHomeCategoryCollectionCell"];
    }
    
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CJWHomeCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CJWHomeCategoryCollectionCell" forIndexPath:indexPath];
  
    return cell;
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}



@end
