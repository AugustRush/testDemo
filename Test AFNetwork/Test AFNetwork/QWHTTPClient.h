//
//  QWHTTPClient.h
//  Test AFNetwork
//
//  Created by August on 14-8-6.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface QWHTTPClient : NSObject

/**
 *  GET 请求方法
 *
 *  @param path       请求的完整路径
 *  @param paramaters 请求参数字典
 *  @param success    成功回调的block (task 为当前请求的实例对象（NSURLSessionDataTask(ios 7以上)/AFHTTPRequestOperation）,response 为请求成功的返回对象)
 *  @param failed     失败回调block (task 同上，error 为请求失败的错误实例)
 *
 *  @return 当前的请求实例
 */

+(id)get_RequestWithPath:(NSString *)path
              paramaters:(NSDictionary *)paramaters
                 success:(void(^)(id task, id response))success
                  failed:(void(^)(id task, NSError *error))failed;


/**
 *  POST 请求方法
 *
 *  @param path       请求的完整路径
 *  @param paramaters 请求的参数字典
 *  @param success    成功回调(同上)
 *  @param failed     失败回调(同上)
 *
 *  @return 当前的请求实例
 */
+(id)post_requestWithPath:(NSString *)path
               paramaters:(NSDictionary *)paramaters
                  success:(void(^)(id task, id response))success
                   failed:(void(^)(id task, NSError *error))failed;


/**
 *  Multi_Part POST 请求
 *
 *  @param path       请求完整路径
 *  @param paramaters 参数字典
 *  @param block      表单数据block
 *  @param success    成功回调
 *  @param failed     失败回调
 *
 *  @return 当前的请求实例
 */
+(id)post_requestWithPath:(NSString *)path
               paramaters:(NSDictionary *)paramaters
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData>formData))block
                  success:(void (^)(id task, id response))success
                   failed:(void (^)(id task, NSError *))failed;

/**
 *  GET 请求方法 RAC模式(用法为 [(RACSignal *) subscribeNext:void(^)(id
  obj)]{
 
 })
 *
 *  @param path       请求的完整路径
 *  @param paramaters 请求的参数字典
 *
 *  @return RACSignal 信号
 */

+(RACSignal *)get_RuquestWithPath:(NSString *)path
                       paramaters:(NSDictionary *)paramaters;

/**
 *  POST 请求方法 RAC模式（用法同上）
 *
 *  @param path       请求的完整路径
 *  @param paramaters 请求的参数字典
 *
 *  @return RACSignal 信号
 */
+(RACSignal *)post_RequestWithPath:(NSString *)path
                        paramaters:(NSDictionary *)paramaters;


/**
 *  RAC Multi_part POST
 *
 *  @param path       完整路径
 *  @param paramaters 参数字典
 *  @param block      表单数据block
 *
 *  @return RACSignal 信号
 */
+(RACSignal *)post_RequestWithPath:(NSString *)path
                        paramaters:(NSDictionary *)paramaters
         constructingBodyWithBlock:(void(^)(id <AFMultipartFormData>formData))block;

@end
