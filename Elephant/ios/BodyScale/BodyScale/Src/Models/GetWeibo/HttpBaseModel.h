//
//  HttpBaseModel.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-26.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"

@interface HttpBaseModel : NSObject

typedef void (^ResponseDataBlock)(id);

+ (void)getDataResponseHostName:(NSString *)hostName
                           Path:(NSString *)path
                         params:(NSMutableDictionary*) params
                     httpMethod:(NSString*)method
                   onCompletion:(void (^)(NSData *responseData))completionBlock
                        onError:(MKNKErrorBlock)errorBlock;

+ (void)uploadImageHostName:(NSString *)hostName
                       Path:(NSString *)path
                      image:(NSData *)imageData
                     params:(NSMutableDictionary*) params
                 httpMethod:(NSString*)method
               onCompletion:(void (^)(NSData *responseData))completionBlock
                    onError:(MKNKErrorBlock)errorBlock;
@end
