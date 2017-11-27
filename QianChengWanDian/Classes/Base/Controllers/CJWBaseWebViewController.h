//
//  CJWBaseWebViewController.h
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWBaseViewController.h"

@interface CJWBaseWebViewController : CJWBaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, copy) NSString *url;

@end
