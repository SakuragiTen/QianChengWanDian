//
//  CJWNetAPIClient.h
//  QianChengWanDian
//
//  Created by gongsheng on 2017/11/20.
//  Copyright © 2017年 Fireloli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


typedef enum {
    Get = 0,
    Post
} NetWorkMethod;

typedef enum {
    Java = 0,
    Php
} NetWorkType;

@interface CJWNetAPIClient : NSObject

SingletonInterface(Client)



- (void)requestDataWithUrl:(NSString *)url params:(NSDictionary *)params requestMethod:(NetWorkMethod)method requestType:(NetWorkType)type handleCompletion:(void(^)(id data, NSError *error))handle;

@end
