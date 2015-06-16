//
//  BTService.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-4-17.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreBluetooth/CoreBluetooth.h"

#define BTSERVICE_NOTIFICATION_DISCONNECT       @"DISCONNECT"
#define BTSERVICE_NOTIFICATION_CONNECTED        @"CONNECTED"

@protocol BTServiceDelegate

@optional
- (void)peripheralFound:(CBPeripheral *)peripheral RSSI:(NSNumber *)RSSI;
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic;
- (void)connectedPeripheral:(CBPeripheral *)peripheral;
- (void)unconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;
- (void)failToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;

@end

@interface BTService : NSObject

@property (strong, nonatomic)NSMutableArray    *peripherals;       // 已发现的设备
@property (strong, nonatomic)NSMutableArray    *activePeripherals; // 连接中的设备

- (id)initWithDelegate:(id<BTServiceDelegate>)delegate;

#pragma mark - Controlling Method

/**
 *  搜索设备
 *
 *  @param services 指定服务搜索设备
 *  @param timeout  搜索设备时间到达时间后自动关闭搜索以节省电量
 *
 *  @return 是否开始搜索
 */
- (BOOL)scanForPeripheralsWithServices:(NSArray *)services timeout:(int)timeout;

/**
 *  停止搜索设备
 */
- (void)stopScan;

/**
 *  连接到设备   
 *
 *  @param peripheral    周边设备
 *  @param notifyOptions 服务特征通知配置，默认所有通知权限的特征全部打开
 */
- (void)connect:(CBPeripheral *)peripheral notifyOptions:(NSDictionary *)notifyOptions;

/**
 *  与设备断开连接
 *
 *  @param peripheral
 */
- (void)disconnect:(CBPeripheral *)peripheral;

/**
 *  蓝牙写入数据
 *
 *  @param serviceUUID        服务UUID
 *  @param characteristicUUID 特征UUID
 *  @param peripheral         周边设备
 *  @param data               数据
 */
- (void)writeValueWithServiceUUID:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral data:(NSData *)data;

/**
 *  蓝牙写入数据
 *
 *  @param serviceUUID        服务UUID
 *  @param characteristicUUID 特征UUID
 *  @param peripheral         周边设备
 *  @param data               数据
 *  @param type               写入类型
 */
- (void)writeValueWithServiceUUID:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral data:(NSData *)data type:(CBCharacteristicWriteType)type;

/**
 *  蓝牙读取数据
 *
 *  @param serviceUUID        服务UUID
 *  @param characteristicUUID 特征UUID
 *  @param peripheral         周边设备
 */
- (void)readValue:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral;

/**
 *  修改蓝牙特征数据变更接收状态
 *
 *  @param serviceUUID        服务UUID
 *  @param characteristicUUID 特征UUID
 *  @param peripheral         周边设备
 *  @param on                 是否开启
 */
- (void)notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral on:(BOOL)on;

@end
