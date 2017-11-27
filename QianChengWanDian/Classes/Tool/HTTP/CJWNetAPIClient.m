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
SingletonImplementation(Client)

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
        [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        
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
    
   
    
    [self requestDataWithUrl:url params:params requestMethod:method requestType:type loadCache:NO handleCompletion:handle];
}


- (void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params requestMethod:(NetWorkMethod)method requestType:(NetWorkType)type loadCache:(BOOL)loadCache handleCompletion:(void (^)(id, NSError *))handle {
    
    if (url.length == 0) return;
    
    NSMutableDictionary *paramsDict = [self settingParamsDict:params url:url];
    
    //debug状态下 打印请求信息
    if (CJWDebug) [self printRequestInfoWithParams:paramsDict url:url method:method];
    
    
    NSString *requestUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    switch (method) {
        case Get:
            [self GET:requestUrl parameters:paramsDict loadCache:loadCache handleCompletion:handle];
            break;
        case Post:
            [self POST:requestUrl parameters:paramsDict handleCompletion:handle];
            break;
        default:
            break;
    }
}

#pragma mark - GET
- (void)GET:(NSString *)url parameters:(NSDictionary *)parameters loadCache:(BOOL)loadCache handleCompletion:(void(^)(id, NSError *))handle
{
    if (loadCache) {
        //加载缓存
    } else {
        //不需要加载缓存 直接请求数据
        [self GET:url parameters:parameters handleCompletion:handle];
    }
}
- (void)GET:(NSString *)url parameters:(NSDictionary *)parameters handleCompletion:(void(^)(id, NSError *))handle
{
    [[CJWNetAPIClient shareManager] GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印请求结果
        NSLog(@"\n===========response===========\n%@", url);
        if (CJWDebug) [self printResponse:responseObject];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - POST
- (void)POST:(NSString *)url parameters:(NSDictionary *)parameters handleCompletion:(void(^)(id, NSError *))handle
{
    [[CJWNetAPIClient shareManager] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //打印请求结果
        NSLog(@"\n===========response===========\n%@", url);
        if (CJWDebug) [self printResponse:responseObject];
        if ([self handleRespose:responseObject]) {
            //数据请求成功 接口无误
            if (handle) handle(responseObject, nil);
        } else {
            if (handle) handle(nil, nil);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        if (handle) handle(nil, error);
    }];
}

- (void)printResponse:(id)responseObject
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonStr);
}



- (NSMutableDictionary *)settingParamsDict:(NSDictionary *)params url:(NSString *)url
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
    
    //    订单接口与售后接口 添加IP跟MAC
    if([url rangeOfString:@"/afterSeller/"].location != NSNotFound ||[url rangeOfString:@"/order/"].location != NSNotFound){
        
        [paramsDict setObject:[CJWTool getIPAddress] forKey:@"customerIp"];
        [paramsDict setObject:[CJWTool getDeviceIdentifier] forKey:@"customerMac"];
    }
    
    //签名
    paramsDict[@"signatrue"] = [self signParams:paramsDict];
    
    return paramsDict;
}


/** 参数进行数字签名 */
- (NSString *)signParams:(NSDictionary *)params
{
    NSMutableDictionary *signDict = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *apiKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"api_request_key"];
    signDict[@"apiKey"] = apiKey;
    
    NSMutableString *buff = [NSMutableString string];
    
    //请求参数按照参数名ASCII码从小到大排序
    NSArray *sortKeys =signDict.allKeys;
    sortKeys = [sortKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        return [str1 compare:str2];
    }];
    
    for (int i = 0; i < sortKeys.count; i ++) {
        NSString *key = sortKeys[i];
        NSString *value = [NSString stringWithFormat:@"%@", signDict[key]];
        NSString *last = i == sortKeys.count - 1 ? @"" : @"&";
        if (value.length) {
            [buff appendString:[NSString stringWithFormat:@"%@=%@%@", key, value, last]];
        }
        
    }
    
    return [[buff md5String] lowercaseString];
    
}

/** 打印请求信息 */
- (void)printRequestInfoWithParams:(NSDictionary *)params url:(NSString *)url method:(NetWorkMethod)method
{
    NSString *urlParams = @"";
    for (int i = 0; i < params.allKeys.count; i ++) {
        NSString *key = params.allKeys[i];
        NSString *value = [NSString stringWithFormat:@"%@", params[key]];
        NSString *last = i == params.allKeys.count - 1 ? @"" : @"&";
        urlParams = [urlParams stringByAppendingString:[NSString stringWithFormat:@"%@=%@%@", key, value, last]];
    }
    
    NSString *requestUrl = [NSString stringWithFormat:@"%@?%@", url, urlParams];
    
    
    NSLog(@"\n===========request===========\n%@\n%@\n\n%@:\n%@", @[@"GET", @"POST"][method], requestUrl, url, params);
    
}


#pragma mark - 判断业务状态 code、status
- (BOOL)handleRespose:(id)response
{
    if ([response[CJWCODE] integerValue] != 0) {
        if ([response[CJWCODE] integerValue] == 401) {//未登录or失效
            //退出登录
        }
        
        return NO;
    }
    
    return YES;
}




@end








