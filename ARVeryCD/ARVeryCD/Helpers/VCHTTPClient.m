//
//  VCHTTPClient.m
//  ARVeryCD
//
//  Created by August on 14-7-31.
//  Copyright (c) 2014年 LPW. All rights reserved.
//

#import "VCHTTPClient.h"

static AFHTTPSessionManager *__manager = nil;

@implementation VCHTTPClient

+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __manager = [AFHTTPSessionManager manager];
    });
}

+(RACSignal *)GET_requestWithPath:(NSString *)path paramaters:(NSDictionary *)paramaters
{
    return [__manager rac_GET:path parameters:paramaters];
}

@end
