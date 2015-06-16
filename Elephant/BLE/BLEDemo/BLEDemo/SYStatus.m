//
//  SYStatus.m
//  BLEDemo
//
//  Created by Zhanghao on 3/21/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import "SYStatus.h"

@implementation SYStatus

- (instancetype)initWithResponse:(NSString *)response {
    self = [super init];
    if (self) {
        NSString *currentUser = [response substringFromIndex:4 length:1];
        NSString *defaultUser = [response substringFromIndex:5 length:1];
        NSString *currentMode = [response substringFromIndex:8 length:1];
        NSString *defaultMode = [response substringFromIndex:9 length:1];
        NSString *power = [response substringFromIndex:12 length:2];
        NSString *currentBeep = [response substringFromIndex:16 length:1];
        NSString *defaultBeep = [response substringFromIndex:17 length:1];
        NSString *currentContinuous = [response substringFromIndex:20 length:1];
        NSString *defaultContinuous = [response substringFromIndex:21 length:1];

        if ([currentUser isEqualToString:@"A"]) {
            self.currentUser = @"用户A";
        } else if ([currentUser isEqualToString:@"B"]) {
            self.currentUser = @"用户B";
        }
        
        if ([defaultUser isEqualToString:@"A"]) {
            self.defaultUser = @"用户A";
        } else if ([defaultUser isEqualToString:@"B"]) {
            self.defaultUser = @"用户B";
        }
        
        if ([currentMode isEqualToString:@"A"]) {
            self.currentMeasureMode = @"普通模式";
        } else if ([currentMode isEqualToString:@"B"]) {
            self.currentMeasureMode = @"心血管模式";
        }
        
        if ([defaultMode isEqualToString:@"A"]) {
            self.defaultMeasureMode = @"普通模式";
        } else if ([defaultMode isEqualToString:@"B"]) {
            self.defaultMeasureMode = @"心血管模式";
        }
        
        self.poweLevel = [power integerValue];
        
        if ([currentBeep isEqualToString:@"O"]) {
            self.currentBeepMode = YES;
        } else if ([currentBeep isEqualToString:@"F"]) {
            self.currentBeepMode = NO;
        }
        
        if ([defaultBeep isEqualToString:@"O"]) {
            self.defaultBeepMode = YES;
        } else if ([defaultBeep isEqualToString:@"F"]) {
            self.defaultBeepMode = NO;
        }
        
        if ([currentContinuous isEqualToString:@"O"]) {
            self.currentContinuousMeasure = YES;
        } else if ([currentContinuous isEqualToString:@"F"]) {
            self.currentContinuousMeasure = NO;
        }
        
        if ([defaultContinuous isEqualToString:@"O"]) {
            self.defaultContinuousMeasure = YES;
        } else if ([defaultContinuous isEqualToString:@"F"]) {
            self.defaultContinuousMeasure = NO;
        }
        
    }
    return self;
}

@end
