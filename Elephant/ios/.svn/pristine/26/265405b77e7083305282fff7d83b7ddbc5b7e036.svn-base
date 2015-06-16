//
//  SNCHTTPRequest.m
//  BLH
//
//  Created by 两元鱼 on 10/15/12.
//  Copyright (c) 2012 BLH. All rights reserved.
//

#import "SNCHTTPRequest.h"
#import "JSONKit.h"

@implementation SNCHTTPRequest

#pragma mark -
#pragma mark JSON格式

// Post请求
+ (ASIHTTPRequest *)sendJSONRequestWithURL:(NSString *)urlString andPostData:(id)postData failedBlock:(FailedHttpBlock)failed completionBlock:(JSONHttpBlock)completion
{
    ASIHTTPRequest *request = [self requestWithURL:urlString andPostData:postData];
    request.timeOutSeconds = 15.0f;
    
    [request setCompletionBlock:^{
        
        ServerResponseState state = [self responseFailedWithRequest:request failedBlock:failed];
        
        switch (state)
        {
                
            case GeneralExceptionState:
            {
                
                // 已统一错误处理
                break;
            }
            case SessionTimeoutState:
            {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    //                    if ([self timeoutAutoLogin])
                    //                    {
                    //                        [self sendJSONRequestWithURL:urlString andPostData:postData failedBlock:failed completionBlock:completion];
                    //                    }
                    
                });
                
                break;
            }
            case JSONParseExceptionState:
            {
                
                if (failed)
                {
                    failed(kJSONParseExceptionCode, L(@"Please Try later"));
                }
                
                break;
            }
            default:
            {
                
                if (completion)
                {
                    completion(request.responseString.objectFromJSONString);
                }
                
                break;
            }
        }
        
        
    }];
    
    [request setFailedBlock:^{
        
        [self responseFailedWithRequest:request failedBlock:failed];
        
    }];
    
    [request startAsynchronous];
    
    return request;
}
// Get请求
+ (ASIHTTPRequest *)sendJSONRequestWithURL:(NSString *)urlString failedBlock:(FailedHttpBlock)failed completionBlock:(JSONHttpBlock)completion
{
    
    ASIHTTPRequest *request = [self requestWithURL:urlString];
    [request setCompletionBlock:^{
        
        ServerResponseState state = [self responseFailedWithRequest:request failedBlock:failed];
        
        switch (state)
        {
                
            case GeneralExceptionState:
            {
                
                // 已统一错误处理
                break;
            }
            case SessionTimeoutState:
            {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    //                    if ([self timeoutAutoLogin])
                    //                    {
                    //                        [self sendJSONRequestWithURL:urlString failedBlock:failed completionBlock:completion];
                    //                    }
                    
                });
                
                break;
            }
            case JSONParseExceptionState:
            {
                
                if (failed)
                {
                    failed(kJSONParseExceptionCode, L(@"Please Try later"));
                }
                
                break;
            }
            default:
            {
                
                if (completion)
                {
                    completion(request.responseString.objectFromJSONString);
                    
                }
                
                break;
            }
        }
        
    }];
    
    [request setFailedBlock:^{
        
        [self responseFailedWithRequest:request failedBlock:failed];
        
    }];
    
    [request startAsynchronous];
    
    return request;
}

+ (ASIFormDataRequest *)fileUploadRequestWithURL:(NSString *)urlString andPostData:(id)postData failedBlock:(FailedHttpBlock)failed completionBlock:(StringHttpBlock)completion
{
    ASIFormDataRequest *request = [self requestWithURL:urlString andPostData:postData];
    request.timeOutSeconds = 120.0f;
    
    request.postFormat = ASIMultipartFormDataPostFormat;
    
    [request setCompletionBlock:^{
        
        NSString *response = request.responseString;
        
        DLog(@"The server response is : \n%@", response);
        
        //上传图片特别处理 200 成功 2005满了
        if (completion)
        {
            completion(response);
        }
        
    }];
    
    [request setFailedBlock:^{
        
        [self responseFailedWithRequest:request failedBlock:failed];
        
    }];
    [request startAsynchronous];
    return request;
}

+ (ASIFormDataRequest *)multifileUploadRequestWithURL:(NSString *)urlString andPostData:(id)postData
                                             fileData:(NSArray *)fileList failedBlock:(FailedHttpBlock)failed
                                      completionBlock:(StringHttpBlock)completion
{
    ASIFormDataRequest *request = [self multiRequestWithURL:urlString andPostData:postData fileData:fileList];
    request.timeOutSeconds = 120.0f;
    
    request.postFormat = ASIMultipartFormDataPostFormat;
    
    [request setCompletionBlock:^{
        
        NSString *response = request.responseString;
        
        DLog(@"The server response is : \n%@", response);
        
        //上传图片特别处理 200 成功 2005满了
        if (completion)
        {
            completion(response);
        }
        
    }];
    
    [request setFailedBlock:^{
        
        [self responseFailedWithRequest:request failedBlock:failed];
        
    }];
    [request startAsynchronous];
    return request;
}

#pragma mark -
#pragma mark XML格式

// Post请求
//+ (ASIHTTPRequest *)sendXMLRequestWithURL:(NSString *)urlString andPostData:(id)postData failedBlock:(FailedHttpBlock)failed completionBlock:(XMLHttpBlock)completion
//{
//    ASIHTTPRequest *request = [self requestWithURL:urlString andPostData:postData];
//    request.timeOutSeconds = 120.0f;
//
//    [request setCompletionBlock:^{
//
//        ServerResponseState state = [self responseFailedWithRequest:request failedBlock:failed];
//
//        switch (state)
//        {
//
//            case GeneralExceptionState:
//            {
//
//                // 已统一错误处理
//                break;
//            }
//            case SessionTimeoutState:
//            {
//
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//                    if ([self timeoutAutoLogin])
//                    {
//                        [self sendXMLRequestWithURL:urlString andPostData:postData failedBlock:failed completionBlock:completion];
//                    }
//
//                });
//
//                break;
//            }
//            default:
//            {
//
//                NSError *error = nil;
//                GDataXMLDocument *xmlDocument = nil;
//
//                if (request.responseString)
//                {
//                    xmlDocument = [[[GDataXMLDocument alloc] initWithXMLString:request.responseString options:0 error:&error] autorelease];
//
//                    if (error)
//                    {
//
//                        DLog(@"XML解析错误");
//
//                        if (failed)
//                        {
//                            failed(kXMLParseExceptionCode, L(@"Please Try later"));
//                        }
//
//                        break;
//                    }
//                }
//
//
//
//                if (completion)
//                {
//                    completion(xmlDocument);
//                }
//
//                break;
//            }
//        }
//
//    }];
//
//    [request setFailedBlock:^{
//
//        [self responseFailedWithRequest:request failedBlock:failed];
//
//    }];
//
//    [request startAsynchronous];
//
//    return request;
//}

// Get请求
//+ (ASIHTTPRequest *)sendXMLRequestWithURL:(NSString *)urlString failedBlock:(FailedHttpBlock)failed completionBlock:(XMLHttpBlock)completion
//{
//
//    ASIHTTPRequest *request = [self requestWithURL:urlString];
//    request.timeOutSeconds = 120.0f;
//
//    [request setCompletionBlock:^{
//
//        ServerResponseState state = [self responseFailedWithRequest:request failedBlock:failed];
//
//        switch (state)
//        {
//
//            case GeneralExceptionState:
//            {
//
//                // 已统一错误处理
//                break;
//            }
//            case SessionTimeoutState:
//            {
//
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//                    if ([self timeoutAutoLogin])
//                    {
//                        [self sendXMLRequestWithURL:urlString failedBlock:failed completionBlock:completion];
//                    }
//
//                });
//
//                break;
//            }
//            default:
//            {
//
//                NSError *error = nil;
//                GDataXMLDocument *xmlDocument = nil;
//
//                if (request.responseString)
//                {
//                    xmlDocument = [[[GDataXMLDocument alloc] initWithXMLString:request.responseString options:0 error:&error] autorelease];
//
//                    if (error)
//                    {
//
//                        DLog(@"XML解析错误");
//
//                        if (failed)
//                        {
//                            failed(kXMLParseExceptionCode, L(@"Please Try later"));
//                        }
//
//                        break;
//                    }
//                }
//
//
//
//                if (completion)
//                {
//                    completion(xmlDocument);
//                }
//
//                break;
//            }
//        }
//    }];
//
//    [request setFailedBlock:^{
//
//        [self responseFailedWithRequest:request failedBlock:failed];
//
//    }];
//
//    [request startAsynchronous];
//
//    return request;
//}

+ (ServerResponseState)responseFailedWithRequest:(ASIHTTPRequest *)request failedBlock:(FailedHttpBlock)failed
{
    
    NSError *error = request.error;
    
    NSString *errorMsg = nil;
    NSString *errorCode = nil;
    
    // 网络异常
    switch (error.code)
    {
        case ASIConnectionFailureErrorType:
        {
            errorMsg = @"A connection failure occurred";
            
            break;
        }
        case ASIRequestTimedOutErrorType:
        {
            
            errorMsg = @"The request timed out";
            
            break;
        }
        case ASIAuthenticationErrorType:
        {
            errorMsg = @"Authentication needed";
            
            break;
        }
        case ASIRequestCancelledErrorType:
        {
            errorMsg = @"The request was cancelled";
            
            break;
        }
        case ASIUnableToCreateRequestErrorType:
        {
            
            errorMsg = @"Unable to create request (bad url?)";
            
            break;
        }
        case ASIInternalErrorWhileBuildingRequestType:
        {
            errorMsg = @"Unable to obtain information on proxy servers needed for request";
            
            break;
        }
        case ASIInternalErrorWhileApplyingCredentialsType:
        {
            errorMsg = @"Failed to get authentication object from response headers";
            
            break;
        }
        case ASIFileManagementError:
        {
            errorMsg = @"Failed to move file";
            
            break;
        }
        case ASITooMuchRedirectionErrorType:
        {
            errorMsg = @"The request failed because it redirected too many times";
            
            break;
        }
        case ASICompressionError:
        {
            errorMsg = @"Compression data failed";
            
            break;
        }
        default:
        {
            
            errorMsg = @"Unknown exception";
            
            break;
        }
    }
    
    if (error.code != 0)
    {
        
        DLog(@"----The request failed, the error reason is ----\n%@.", error.userInfo);
        
        errorCode = [NSString stringWithFormat:@"%d", error.code];
        
        if (failed)
        {
            failed(errorCode, L(errorMsg));
        }
        
        return GeneralExceptionState;
    }
    
    // 系统异常
    
    NSString *response = request.responseString;
    
    //DLog(@"The server response is : \n%@", response);
    
    if (!response)
    {
        return NormalResponseState;
    }
    
    NSDictionary *jsonObject = [response objectFromJSONString];
    
    if (!jsonObject)
    {
        return JSONParseExceptionState;
    }
    
    errorCode = jsonObject[@"errorCode"];
    errorMsg = jsonObject[@"msg"];
    NSInteger result = [(NSNumber *)jsonObject[@"result"] integerValue];
    
    if (result != 0)
    {
        
        // 会话超时，需要重新登录
        if ((result == 2) && [@"cloudsync.2.userLogInOutOfTime" isEqualToString:errorCode])
        {
            DLog(@"会话已超时，请重新登录!");
            
            return SessionTimeoutState;
        }
        
        if (result == 3)
        {
            DLog(@"抱歉，系统内部错误，请稍后再试");
            
            errorMsg = L(@"Please Try later");
            
        }
        
        if (failed)
        {
            failed(errorCode, errorMsg);
            
            return GeneralExceptionState;
        }
        
    }
    
    return NormalResponseState;
}

// 返回Post请求
+ (ASIFormDataRequest *)requestWithURL:(NSString *)urlString andPostData:(id)postData
{
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    request.shouldUseRFC2616RedirectBehaviour = YES; // 支持POST方式重定向
    request.shouldAttemptPersistentConnection = YES;
    
    if (postData)
    {
        // 消息格式：NSDictionary
        if ([postData isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *postDic = (NSDictionary *)postData;
            if (postDic.count > 0)
            {
                [postDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [(ASIFormDataRequest *)request setPostValue:obj forKey:key];
                    
                }];
            }
            DLog(@"The request url : %@", [urlString stringByAppendingFormat:@"?%@", [self debugContentFromPostData:postDic]]);
        }
        else if ([postData isKindOfClass:[NSData class]]) // 消息格式：二进制
        {
            NSMutableData *postBody = [NSMutableData dataWithData:postData];
            
            [(ASIFormDataRequest *)request setPostBody:postBody];
            
            [request setShouldStreamPostDataFromDisk:YES];
            
            DLog(@"----The request url : %@", urlString);
            
        }
        
    }
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    if ([urlString hasPrefix:@"https://"])
    {
        request.validatesSecureCertificate = NO;
    }
    
    return request;
}
// 返回Multi-Post请求
+ (ASIFormDataRequest *)multiRequestWithURL:(NSString *)urlString andPostData:(id)postData fileData:(NSArray *)array
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    request.shouldUseRFC2616RedirectBehaviour = YES; // 支持POST方式重定向
    request.shouldAttemptPersistentConnection = YES;
    [request setRequestMethod:@"POST"];
    
    if (postData)
    {
        
        // 消息格式：NSDictionary
        if ([postData isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *postDic = (NSDictionary *)postData;
            
            if (postDic.count > 0)
            {
                [postDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    [(ASIFormDataRequest *)request setPostValue:obj forKey:key];
                    
                }];
                
            }
            DLog(@"The request url : %@", [urlString stringByAppendingFormat:@"?%@", [self debugContentFromPostData:postDic]]);
        }
        else if ([postData isKindOfClass:[NSData class]]) // 消息格式：二进制
        {
            NSMutableData *postBody = [NSMutableData dataWithData:postData];
            
            [(ASIFormDataRequest *)request setPostBody:postBody];
            
            [request setShouldStreamPostDataFromDisk:YES];
            
            DLog(@"----The request url : %@", urlString);
            
        }
        
    }
    if (array != nil && array.count > 0)
    {
        for (NSDictionary *dict in array)
        {
            [request addData:dict[@"data"] withFileName:dict[@"name"] andContentType:dict[@"type"] forKey:dict[@"key"]];
        }
    }
    
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    if ([urlString hasPrefix:@"https://"])
    {
        request.validatesSecureCertificate = NO;
    }
    
    return request;
}

// 返回Get请求
+ (ASIHTTPRequest *)requestWithURL:(NSString *)urlString
{
    DLog(@"The request url : %@", urlString);
    
    NSString *urlEncoded = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlEncoded]];
    
    request.shouldAttemptPersistentConnection = NO;
    
    request.defaultResponseEncoding = NSUTF8StringEncoding;
    
    if ([urlString hasPrefix:@"https://"])
    {
        request.validatesSecureCertificate = NO;
    }
    
    return request;
}

// 用于调试查看报文
+ (NSString *)debugContentFromPostData:(NSDictionary *)postDic
{
    NSMutableString *requestContent = nil;
    
    if (postDic && postDic.count > 0)
    {
        
        requestContent = [NSMutableString stringWithString:@""];
        
        [postDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            
            NSString *paramEntry = nil;
            
            if ([requestContent isEqualToString:@""])
            {
                paramEntry = [NSString stringWithFormat:@"%@=%@",key, obj];
            }
            else
            {
                paramEntry = [NSString stringWithFormat:@"&%@=%@",key, obj];
            }
            
            
            [requestContent appendString:paramEntry];
            
        }];
    }
    
    return requestContent;
}

@end
