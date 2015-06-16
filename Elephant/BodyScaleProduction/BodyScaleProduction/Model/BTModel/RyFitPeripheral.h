//
//  RyFitPeripheral.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-7.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface RyFitPeripheral : NSObject

@property (nonatomic)CBPeripheral   *peripheral;
@property (nonatomic)NSNumber       *RSSI;

- (NSString *)description;

@end
