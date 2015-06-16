//
//  BlueToothHelper.h
//  BodyScale
//
//  Created by August on 14-10-12.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define fileService     @"FFE0"
#define fileSub         @"FFE1"

typedef void(^VarargsBlock) ();

@interface BlueToothHelper : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
@private
    VarargsBlock _centerChangedStateBlock;
    VarargsBlock _scanPeripheralsBlock;
    VarargsBlock _connectPeripheralBlock;
    VarargsBlock _cancelConnectPeripheralBlock;
    NSMutableDictionary *_peripheralResponseBlocks;
}

@property (nonatomic, strong, readonly) CBCentralManager *centralManager;
@property (nonatomic, strong, readonly) NSMutableArray *peripherals;

/**
 *  蓝牙工具单例方法
 *
 *  @return BlueToothHelper 实例
 */
+(instancetype)shareInstance;

/**
 *  蓝牙中心设备状态改变回调
 *
 *  @param block 回调block
 */
-(void)centralManagerChangedStateBlock:(void(^)(CBCentralManagerState state))block;

/**
 *  搜索设备
 *
 *  @param block 外围数组回调
 */
-(void)centralManagerScanPeripheralsWithBlock:(void(^)(NSArray *peripherals))block;

/**
 *  搜索包含在特定UUID的service回调
 *
 *  @param serviceUUIDs 服务的UUID数组
 *  @param block        完成走索回调
 */
-(void)centralManagerScanPeripheralsWithSeviceUUIDS:(NSArray *)serviceUUIDs
                           completeBlock:(void(^)(NSArray *peripherals))block;

/**
 *  连接特定的外围设备
 *
 *  @param peripheral 外围
 *  @param block      完成回调，error包含失败的错误信息
 */
-(void)centralManagerConnectToPeripheral:(CBPeripheral *)peripheral
                completeBlock:(void(^)(CBPeripheral *peripheral,NSError *error))block;

/**
 *  断开连接
 *
 *  @param peripheral 断开的外围设备
 *  @param block      完成回调，error包含失败的错误信息
 */
-(void)centralManagerCancelConnectPeripheral:(CBPeripheral *)peripheral
                     comleteBlock:(void(^)(CBPeripheral *peripheral,NSError *error))block;

/**
 *  写数据到特定的外围设备
 *
 *  @param peripheral     外围
 *  @param characteristic 服务特征
 *  @param block          外围执行指令后返回数据回调
 */
-(void)centralManagerSendData:(NSData *)data
                 ToPeripheral:(CBPeripheral *)peripheral
            forCharacteristic:(CBCharacteristic *)characteristic
                responseBlock:(void(^)(CBCharacteristic *characteristic, NSError *error))block;
@end
