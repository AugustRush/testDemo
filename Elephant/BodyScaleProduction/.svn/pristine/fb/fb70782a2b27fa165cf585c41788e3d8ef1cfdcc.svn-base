//
//  HTTPService.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFHTTPSessionManager (MyExtend)

- (NSURLSessionDataTask *)POSTByFullURL:(NSString *)URLString
                             parameters:(NSDictionary *)parameters
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)GETByFullURL:(NSString *)URLString
                            parameters:(NSDictionary *)parameters
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end


@interface AFHTTPRequestOperationManager (MyExtend)

- (AFHTTPRequestOperation *)POSTByFullURL:(NSString *)URLString
                               parameters:(NSDictionary *)parameters
                                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)GETByFullURL:(NSString *)URLString
                              parameters:(NSDictionary *)parameters
                                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end

@interface HTTPService : NSObject

+ (instancetype)sharedClient;

- (id)POST:(NSString *)URLString
parameters:(NSDictionary *)parameters
   success:(void (^)(id task, id responseObject))success
   failure:(void (^)(id task, NSError *error))failure;

- (id)POST:(NSString *)URLString
parameters:(NSDictionary *)parameters
     block:(void (^)(id <AFMultipartFormData> formData))block
   success:(void (^)(id task, id responseObject))success
   failure:(void (^)(id task, NSError *error))failure;



- (id)POSTWithFullURL:(NSString *)URLString
           parameters:(NSDictionary *)parameters
              success:(void (^)(id task, id responseObject))success
              failure:(void (^)(id task, NSError *error))failure;


- (id)GETWithFullURL:(NSString *)URLString
          parameters:(NSDictionary *)parameters
             success:(void (^)(id task, id responseObject))success
             failure:(void (^)(id task, NSError *error))failure;

@end

