//
//  CJWBaseWebViewController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWBaseWebViewController.h"

@interface CJWBaseWebViewController ()

@end

@implementation CJWBaseWebViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self sendRequest];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)sendRequest
{
    _url = _url ? : @"http://www.cjwsc.com/";
    
    NSLog(@"%@", _url);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showLoading:@"" toView:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view];
}



- (UIWebView *)webView {
    if(_webView == nil) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(0, NavBar_Height, SCREEN_WIDTH, SCREEN_HEIGHT - NavBar_Height);
        _webView.delegate = self;
        _webView.dataDetectorTypes = UIDataDetectorTypeNone;
        [self.view addSubview:_webView];
    }
    return _webView;
}




@end
