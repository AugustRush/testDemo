//
//  HTTPBaseModel.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-18.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "HTTPBaseModel.h"

@implementation HTTPBaseModel

- (id)initWithDelegate:(id<HTTPBaseModelDelegate>)delegate;
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
    }
    return self;
}

- (NSMutableDictionary *)getPublicParamWithDateString:(NSString *)dateString
{
    NSDictionary *dic = @{
                          BodyScaleDeviceType: BodyScaleDeviceTypeValue,
                          BodyScaleDeviceCode: BodyScaleDeviceCodeValue,
                          BodyScaleAppVer: BodyScaleAppVerValue,
                          BodyScaleReqTime: dateString,
                          };
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:dic];
    return param;
}

- (NSString *)currentDateString {
    return [[NSDate date] convertToYYYYMMDDHHMMSSDateFormat];
}

@end
