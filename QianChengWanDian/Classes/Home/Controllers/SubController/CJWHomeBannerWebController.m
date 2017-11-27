//
//  CJWHomeBannerWebController.m
//  QianChengWanDian
//
//  Created by Fireloli on 2017/11/24.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWHomeBannerWebController.h"

@interface CJWHomeBannerWebController ()

@end

@implementation CJWHomeBannerWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    //标题控制在十个字符以内
    if (title.length > 10) title = [[title substringFromIndex:9] stringByAppendingString:@".."];
    self.title = title;
    
}

@end
