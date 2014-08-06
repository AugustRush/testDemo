//
//  QWHTTPClient.m
//  Test AFNetwork
//
//  Created by August on 14-8-6.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "QWHTTPClient.h"

#define _SYSTERMVERSION_GREATER_7_0    [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

static AFHTTPRequestOperationManager *__operationManager = nil;
static AFHTTPSessionManager *__sessionManager = nil;

@implementation QWHTTPClient

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_SYSTERMVERSION_GREATER_7_0) {
            __sessionManager = [AFHTTPSessionManager manager];
            __sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        }else{
            __operationManager = [AFHTTPRequestOperationManager manager];
            __operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        }
    });
}

+(id)get_RequestWithPath:(NSString *)path
              paramaters:(NSDictionary *)paramaters
                 success:(void (^)(id, id))success
                  failed:(void (^)(id, NSError *))failed
{
    
    if (_SYSTERMVERSION_GREATER_7_0) {
        return  [__sessionManager GET:path parameters:paramaters success:success failure:failed];
    }else{
        return [__operationManager GET:path parameters:paramaters success:success failure:failed];
    }
}

+(id)post_requestWithPath:(NSString *)path
               paramaters:(NSDictionary *)paramaters
                  success:(void (^)(id, id))success
                   failed:(void (^)(id, NSError *))failed
{
    if (_SYSTERMVERSION_GREATER_7_0) {
        return [__sessionManager POST:path parameters:paramaters success:success failure:failed];
    }else{
        return [__operationManager POST:path parameters:paramaters success:success failure:failed];
    }
}

@end
