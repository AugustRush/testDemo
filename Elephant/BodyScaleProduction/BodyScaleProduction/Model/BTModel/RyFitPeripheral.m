//
//  RyFitPeripheral.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-7.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "RyFitPeripheral.h"

@implementation RyFitPeripheral

- (NSString *)description {
    return [NSString stringWithFormat:@"设备:%@ RSSI:%@", self.peripheral.name, self.RSSI];
}

@end
