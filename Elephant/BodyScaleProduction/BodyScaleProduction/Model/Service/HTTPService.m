//
//  HTTPService.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HTTPService.h"
#import "CONSTS.h"

#define IOS7_OR_LATER [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f


@implementation AFHTTPSessionManager (MyExtend)

- (NSURLSessionDataTask *)POSTByFullURL:(NSString *)URLString
                             parameters:(NSDictionary *)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                   URLString:URLString
                                                                  parameters:parameters
                                                                       error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request
                                                 completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                                                     if (error) {
                                                         
                                                         //self.baseURL = [NSURL URLWithString:DOMAIN_URL];
                                                         if (failure) {
                                                             failure(task, error);
                                                         }
                                                     } else {
                                                         if (success) {
                                                             success(task, responseObject);
                                                         }
                                                     }
                                                 }];
    
    [task resume];
    
    return task;
}



- (NSURLSessionDataTask *)GETByFullURL:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                   URLString:URLString
                                                                  parameters:parameters
                                                                       error:nil];
    
    __block NSURLSessionDataTask *task = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    [task resume];
    
    return task;
}



@end


@implementation AFHTTPRequestOperationManager (MyExtend)
- (AFHTTPRequestOperation *)POSTByFullURL:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST"
                                                                   URLString:URLString
                                                                  parameters:parameters
                                                                       error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request
                                                                      success:success
                                                                      failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

- (AFHTTPRequestOperation *)GETByFullURL:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET"
                                                                   URLString:URLString
                                                                  parameters:parameters
                                                                       error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request
                                                                      success:success
                                                                      failure:failure];
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end


static NSString * const BaseURLString = BASE_URL;
static AFHTTPRequestOperationManager    *_operationManager;
static AFHTTPSessionManager             *_sessionManager;

static AFHTTPRequestOperation           *_operation;
@implementation HTTPService

+ (instancetype)sharedClient {
    static HTTPService *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[HTTPService alloc] init];
        NSURL *baseURL = [NSURL URLWithString:BaseURLString];
        if (IOS7_OR_LATER) {
            _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
            _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];//[NSSet setWithObject:@"text/html"];
        } else {
            _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
            _operationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            _operationManager.responseSerializer = [AFJSONResponseSerializer serializer];
            _operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];//[NSSet setWithObject:@"text/html"];
        }
    });
    
    return _sharedClient;
}

- (id)POST:(NSString *)URLString
parameters:(NSDictionary *)parameters
   success:(void (^)(id task, id responseObject))success
   failure:(void (^)(id task, NSError *error))failure
{
    if (IOS7_OR_LATER) {
        return [_sessionManager POST:URLString
                parameters:parameters
                   success:success
                   failure:failure];
    } else {
        return [_operationManager POST:URLString
                parameters:parameters
                   success:success
                   failure:failure];
    }
}

// 发送文件
- (id)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
       block:(void (^)(id <AFMultipartFormData> formData))block
     success:(void (^)(id task, id responseObject))success
     failure:(void (^)(id task, NSError *error))failure {
    if (IOS7_OR_LATER) {
        return [_sessionManager POST:URLString
                          parameters:parameters
           constructingBodyWithBlock:block
                             success:success
                             failure:failure];
        
    } else {
        return [_operationManager POST:URLString
                            parameters:parameters
             constructingBodyWithBlock:block
                               success:success
                               failure:failure];
    }
}




- (id)POSTWithFullURL:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(void (^)(id task, id responseObject))success
              failure:(void (^)(id task, NSError *error))failure
{
    if (IOS7_OR_LATER) {
        return [_sessionManager POSTByFullURL:URLString
                                   parameters:parameters
                                      success:success
                                      failure:failure];
        
    } else {
        return [_operationManager POSTByFullURL:URLString
                                     parameters:parameters
                                        success:success
                                        failure:failure];
    }
}



- (id)GETWithFullURL:(NSString *)URLString
          parameters:(NSDictionary *)parameters
             success:(void (^)(id task, id responseObject))success
             failure:(void (^)(id task, NSError *error))failure
{
    if (IOS7_OR_LATER) {
        return [_sessionManager GETByFullURL:URLString
                                  parameters:parameters
                                     success:success
                                     failure:failure];
        
    } else {
        return [_operationManager GETByFullURL:URLString
                                    parameters:parameters
                                       success:success
                                       failure:failure];
    }
}


@end
