//
//  CJWNetAPIClient.m
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import "CJWNetAPIClient.h"
#define kCertificateName @"*.cjwsc.com"
@implementation CJWNetAPIClient

static AFHTTPSessionManager *_manager = nil;
+ (AFHTTPSessionManager *)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [AFHTTPSessionManager manager];
        
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        //返回数据支持的类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/javascript",@"text/plain",@"application/json", @"application/x-www-form-urlencoded", nil];
        
        //配置请求序列
        [_manager.requestSerializer setValue:@"application/json" forKey:@"Accept"];
        
        //请求超时
        _manager.requestSerializer.timeoutInterval = 20.0;
        
        //配置HTTPS
        _manager.securityPolicy = [self customSecurityPolicy];
        
    });
    
    return _manager;
}

+ (AFSecurityPolicy *)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kCertificateName ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    NSSet *setCer = [NSSet setWithObject:certData];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = setCer;
    
    return securityPolicy;
}





#pragma mark - 请求数据
- (void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params requestMethod:(NetWorkMethod)method requestType:(NetWorkType)type handleCompletion:(void (^)(id, NSError *))handle {
    
    [self requestDataWithUrl:url params:params requestMethod:method requestType:type handleCompletion:handle];
}


- (void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params requestMethod:(NetWorkMethod)method requestType:(NetWorkType)type loadCache:(BOOL)loadCache handleCompletion:(void (^)(id, NSError *))handle {
    
    if (url.length == 0) return;
    
    NSMutableDictionary *paramsDict = [self settingParamsDict:params];
    
    
}



- (NSMutableDictionary *)settingParamsDict:(NSDictionary *)params
{
    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
    double timeInterval = [[NSDate date] timeIntervalSince1970] * 1000;
    [paramsDict setObject:[NSString stringWithFormat:@"%.0f", timeInterval] forKey:@"timestamp"];
    if (params && [params allKeys].count > 0) {
        [paramsDict addEntriesFromDictionary:params];
    }
    [paramsDict setObject:@"30" forKey:@"businessType"];
    [paramsDict setObject:@"4" forKey:@"clientType"];
    [paramsDict setObject:@"4" forKey:@"clientApp"];
    [paramsDict setObject:@"3" forKey:@"applyChannel"];
    
    return paramsDict;
}







@end








