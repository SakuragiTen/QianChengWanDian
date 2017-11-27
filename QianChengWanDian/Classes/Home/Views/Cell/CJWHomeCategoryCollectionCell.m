//
//  CJWHomeCategoryCollectionCell.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeCategoryCollectionCell.h"
@interface CJWHomeCategoryCollectionCell ()

/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/** 类名名称 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *
 * 图片的边距
 *
 */

/** 左 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadConstant;

/** 右 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tralingConstant;

/** 上 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstant;

@end

@implementation CJWHomeCategoryCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (SCREEN_WIDTH == 320) {
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _leadConstant.constant = 10;
        _tralingConstant.constant = 10;
        _topConstant.constant = 10;
    }
    
    
}

- (void)setCategoryModel:(CJWHomeCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:categoryModel.icon] placeholderImage:nil]; //UI强调此处不需要占位图
    
    _titleLabel.text =categoryModel.name;
}


@end
