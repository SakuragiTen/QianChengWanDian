//
//  CJWAnnouncementCell.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/17.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWAnnouncementCell.h"
#import "CJWAnnouncementView.h"

@interface CJWAnnouncementCell ()

@property (nonatomic, strong) NSArray *announceArray;

@end

@implementation CJWAnnouncementCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self addAnnouncementViewWithContentArray:@[@"zheshidiyitiao", @"这是第二条第二条第二条"]];
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
