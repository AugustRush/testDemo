//
//  GloubleProperty.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "GloubleProperty.h"

@implementation GloubleProperty

+ (instancetype)sharedInstance {
    
    static GloubleProperty *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GloubleProperty alloc] init];
        _sharedClient.lat = @"0";
        _sharedClient.lng = @"0";
    });
    
    return _sharedClient;
}

@end
