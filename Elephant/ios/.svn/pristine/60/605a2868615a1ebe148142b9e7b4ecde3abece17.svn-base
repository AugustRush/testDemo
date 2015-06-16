//
//  SNCHTTPRequest.h
//  BLH
//
//  Created by 两元鱼 on 10/15/12.
//  Copyright (c) 2012 BLH. All rights reserved.
//

#import "ASIFormDataRequest.h"
#import <Foundation/Foundation.h>
#import "ASIDownloadCache.h"

#define kJSONParseExceptionCode         @"network.data.json.exception"
#define kXMLParseExceptionCode          @"network.data.xml.exception"

#define kImageUploadCapacityLimited     @"2005"
#define kImageUploadResponseSuccess     @"200"

typedef void (^StringHttpBlock)(NSString *);
typedef void (^JSONHttpBlock)(NSDictionary *);
//typedef void (^XMLHttpBlock)(GDataXMLDocument *);

typedef void (^FailedHttpBlock)(NSString *, NSString *);

typedef enum {
    
    NormalResponseState = 0,
    
    GeneralExceptionState,
    
    SessionTimeoutState,
    
    JSONParseExceptionState
    
} ServerResponseState;

@interface SNCHTTPRequest : NSObject

// JSON格式
+ (ASIHTTPRequest *)sendJSONRequestWithURL:(NSString *)urlString andPostData:(id)postData failedBlock:(FailedHttpBlock)failed completionBlock:(JSONHttpBlock)completion;
+ (ASIHTTPRequest *)sendJSONRequestWithURL:(NSString *)urlString failedBlock:(FailedHttpBlock)failed completionBlock:(JSONHttpBlock)completion;

// XML格式
//+ (ASIHTTPRequest *)sendXMLRequestWithURL:(NSString *)urlString andPostData:(id)postData failedBlock:(FailedHttpBlock)failed completionBlock:(XMLHttpBlock)completion;
//+ (ASIHTTPRequest *)sendXMLRequestWithURL:(NSString *)urlString failedBlock:(FailedHttpBlock)failed completionBlock:(XMLHttpBlock)completion;

// 单个文件上传
+ (ASIFormDataRequest *)fileUploadRequestWithURL:(NSString *)urlString andPostData:(id)postData failedBlock:(FailedHttpBlock)failed completionBlock:(StringHttpBlock)completion;
// 多文件上传
+ (ASIFormDataRequest *)multifileUploadRequestWithURL:(NSString *)urlString andPostData:(id)postData fileData:(NSArray *)fileList failedBlock:(FailedHttpBlock)failed completionBlock:(StringHttpBlock)completion;


@end
