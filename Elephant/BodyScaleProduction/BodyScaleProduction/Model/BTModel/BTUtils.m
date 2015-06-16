//
//  BTUtils.m
//  RyfitInterfaceTestDemo
//
//  Created by Go Salo on 14-5-4.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BTUtils.h"

@implementation BTUtils

/* UUID转换成NSString (Later IOS 7.0) */
+ (NSString *)CBUUIDToString:(CBUUID *) UUID {
//<<<<<<< .mine
    NSString *dataString = [NSString stringWithCString:[[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy] encoding:NSUTF8StringEncoding];
    return [dataString substringWithRange:NSMakeRange(1, dataString.length - 2)];
    /*
     #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1
     return UUID.UUIDString;
     #else
     
     return [[UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy];
     [NSString alloc] init
     #endif
     */
//=======
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1
////    return UUID.UUIDString;
//    return @"";
//#endif
//>>>>>>> .r1960
}

/* UUID转换成NSString (IOS 5.0 to 7.0) */
+ (NSString *)UUIDToString:(CFUUIDRef)UUID {
    if (!UUID) return nil;
    CFStringRef s = CFUUIDCreateString(NULL, UUID);
    NSString *uuidString = [NSString stringWithString:(__bridge NSString *)s];
    CFRelease(s);
    return uuidString;
}

/* NSString转换成UUID */
+ (CBUUID *)StringToUUID:(NSString *)stringUUID {
    CBUUID *uuid = [CBUUID UUIDWithString:stringUUID];
    return uuid;
}

/* 比较两个CBUUID是否一样 */
+ (BOOL)compareCBUUID:(CBUUID *)UUID1 UUID2:(CBUUID *)UUID2 {
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return YES;
    else return NO;
}

/* 比较两个NSUUID是否一样 */
+ (BOOL)compareNSUUID:(NSUUID *)UUID1 UUID2:(NSUUID *)UUID2 {    
    uuid_t b1, b2;
    [UUID1 getUUIDBytes:b1];
    [UUID2 getUUIDBytes:b2];
    if (memcmp(b1, b2, sizeof(uuid_t)) == 0) {
        return YES;
    } else return NO;
}

/* 比较两个Peripheral 是否是同一个 */
+ (BOOL)comparePeripheral:(CBPeripheral *)peripheral1 peripheral2:(CBPeripheral *)peripheral2 {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    return [self compareNSUUID:peripheral1.identifier UUID2:peripheral2.identifier];
#else
    return [self compareCBUUID:peripheral1.UUID UUID2:peripheral2.UUID];
#endif
}

/* 比较UUID和int是否相等 */
+ (int)compareCBUUIDToInt:(CBUUID *)UUID1 UUID2:(UInt16)UUID2 {
    char b1[16];
    [UUID1.data getBytes:b1];
    UInt16 b2 = CFSwapInt16(UUID2);
    if (memcmp(b1, (char *)&b2, 2) == 0) return 1;
    else return 0;
}

/* CBUUID 转换成int */
+ (UInt16)CBUUIDToInt:(CBUUID *)UUID {
    char b1[16];
    [UUID.data getBytes:b1];
    return ((b1[0] << 8) | b1[1]);
}

/* int转换成CBUUID */
+ (CBUUID *)IntToUUID:(UInt16)intUUID {
    UInt16 swapUUID = CFSwapInt16(intUUID);
    NSData *UUIDData = [NSData dataWithBytes:&swapUUID length:sizeof(swapUUID)];
    CBUUID *UUID = [CBUUID UUIDWithData:UUIDData];
    return UUID;
}

/* 获取Peripheral 唯一标识符 */
+ (NSString *)getUUIDWithPeripheral:(CBPeripheral *)peripheral {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    return [peripheral.identifier UUIDString];
#else
    CFStringRef s = CFUUIDCreateString(NULL, peripheral.UUID);
    NSString *uuidString = (__bridge_transfer NSString *)s;
    return uuidString;
#endif
}

/* 打印周边设备信息 */
+ (void)printPeripheralInfo:(CBPeripheral*)peripheral {
#if DEBUG
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
        unsigned char uuidBytes[sizeof(uuid_t)];
        [peripheral.identifier getUUIDBytes:uuidBytes];
        CFUUIDRef uuid = CFUUIDCreateWithBytes(NULL,
                                               uuidBytes[0], uuidBytes[1], uuidBytes[2],
                                               uuidBytes[3], uuidBytes[4], uuidBytes[5],
                                               uuidBytes[6], uuidBytes[7], uuidBytes[8],
                                               uuidBytes[9], uuidBytes[10], uuidBytes[11],
                                               uuidBytes[12], uuidBytes[13], uuidBytes[14], uuidBytes[15]);
        
        CFStringRef s = CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    #else
        CFStringRef s = CFUUIDCreateString(NULL, peripheral.UUID);
    #endif 
        printf("------------------------------------\r\n");
        printf("Peripheral Info :\r\n");
        printf("UUID : %s\r\n", CFStringGetCStringPtr(s, 0));
        printf("RSSI : %d\r\n", [peripheral.RSSI intValue]);
        printf("Name : %s\r\n", [peripheral.name cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
        printf("isConnected : %lld\r\n", (long long)peripheral.state);
        printf("-------------------------------------\r\n");
        CFRelease(s);
#endif
}

@end
