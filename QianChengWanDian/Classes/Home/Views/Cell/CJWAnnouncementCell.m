//
//  CJWAnnouncementCell.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWAnnouncementCell.h"
#import "CJWAnnouncementView.h"
#import "CJWHomeModel.h"
@interface CJWAnnouncementCell ()

@property (nonatomic, strong) NSArray *announceArray;

@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation CJWAnnouncementCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
//    [self addAnnouncementViewWithContentArray:@[@"zheshidiyitiao", @"这是第二条第二条第二条"]];
    [self requestHeadLineData];
}

#pragma mark - 请求头条数据
- (void)requestHeadLineData
{
    [netWork() requestHomeHeadLineWithHudView:self.superview.superview completionHandle:^(id data) {
        _contentArray = [CJWHomeHeadLineModel objectsArrayWithKeyValuesArray:data];
         [self addAnnouncementViewWithContentArray:[CJWHomeHeadLineModel titleArrayWithArray:_contentArray]];
    }];
}


- (void)addAnnouncementViewWithContentArray:(NSArray *)contentArray
{
    
    CJWAnnouncementView *annView = [[CJWAnnouncementView alloc] init];
    
    [self.contentView addSubview:annView];
    
    [annView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(1);
        make.bottom.mas_equalTo(-1);
        make.right.mas_offset(-60);
        make.left.mas_equalTo(110);
    }];

    annView.contentArray = contentArray;
    
    __weak typeof(self) weakSelf = self;
    [annView didSelectedAnnouncement:^(NSString *content) {
        NSLog(@"点击了:%@", content);
    }];
}



@end
