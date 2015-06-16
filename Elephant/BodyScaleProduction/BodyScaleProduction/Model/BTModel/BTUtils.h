//
//  BTUtils.h
//  RyfitInterfaceTestDemo
//
//  Created by Go Salo on 14-5-4.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BTUtils : NSObject

/* UUID转换成NSString (Later IOS 7.0) */
+ (NSString *)CBUUIDToString:(CBUUID *)UUID;

/* UUID转换成NSString (IOS 5.0 to 7.0) */
+ (NSString *)UUIDToString:(CFUUIDRef)UUID;

/* 比较两个UUID是否一样 */
+ (BOOL)compareCBUUID:(CBUUID *)UUID1 UUID2:(CBUUID *)UUID2;

/* 比较UUID和int是否相等 */
+ (int)compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2;

/* CBUUID 转换成int */
+ (UInt16)CBUUIDToInt:(CBUUID *) UUID;

/* int转换成CBUUID */
+ (CBUUID *)IntToUUID:(UInt16)intUUID;

/* 打印周边设备信息 */
+ (void)printPeripheralInfo:(CBPeripheral*)peripheral;

/* NSString转换成UUID */
+ (CBUUID *)StringToUUID:(NSString *)stringUUID;

/* 获取Peripheral 唯一标识符 */
+ (NSString *)getUUIDWithPeripheral:(CBPeripheral *)peripheral;

/* 比较两个Peripheral 是否是同一个 */
+ (BOOL)comparePeripheral:(CBPeripheral *)peripheral1 peripheral2:(CBPeripheral *)peripheral2;

@end
