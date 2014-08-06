//
//  QWHTTPClient.h
//  Test AFNetwork
//
//  Created by August on 14-8-6.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

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

@end
