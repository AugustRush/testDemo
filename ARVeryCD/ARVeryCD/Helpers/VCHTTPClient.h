//
//  VCHTTPClient.h
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RACAFNetworking.h"
#import <Mantle.h>

//typedef void(^finishedBlock) (NSArray *array);
//typedef void(^failedBlock) (NSError *error);

@interface VCHTTPClient : NSObject

+(RACSignal *)GET_requestWithPath:(NSString *)path paramaters:(NSDictionary *)paramaters;

@end
