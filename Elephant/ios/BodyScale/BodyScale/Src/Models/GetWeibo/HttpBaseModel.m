//
//  HttpBaseModel.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-26.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "HttpBaseModel.h"

@implementation HttpBaseModel

+ (void)getDataResponseHostName:(NSString *)hostName
                           Path:(NSString *)path
                         params:(NSMutableDictionary*) params
                     httpMethod:(NSString*)method
                   onCompletion:(void (^)(NSData *responseData))completionBlock
                        onError:(MKNKErrorBlock)errorBlock
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:hostName];
    
    MKNetworkOperation *op =[engine operationWithPath:path params:params httpMethod:method ssl:YES];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        NSData *responseData = [operation responseData];
        completionBlock(responseData);
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error){
        errorBlock(error);
    }];
    
    [engine enqueueOperation:op];
    
    //内存泄露
    //TT_RELEASE_SAFELY(engine);
}

+ (void)uploadImageHostName:(NSString *)hostName
                       Path:(NSString *)path
                      image:(NSData *)imageData
                     params:(NSMutableDictionary*) params
                 httpMethod:(NSString*)method
               onCompletion:(void (^)(NSData *responseData))completionBlock
                    onError:(MKNKErrorBlock)errorBlock
{
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:hostName];
    
    MKNetworkOperation *op =[engine operationWithPath:path params:params httpMethod:method ssl:YES];
    [op addData:imageData forKey:@"pic"];
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        NSData *responseData = [operation responseData];
        completionBlock(responseData);
    } errorHandler:^(MKNetworkOperation* completedOperation, NSError* error){
        errorBlock(error);
    }];
    
    [engine enqueueOperation:op];
    
    //内存泄露
    //TT_RELEASE_SAFELY(engine);

}


@end
