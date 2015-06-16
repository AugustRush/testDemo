//
//  SYPeripheralsHandle.h
//  iChrono365
//
//  Created by 刘平伟 on 14-1-8.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "NSString+MD5.h"

#define fileService     @"FFE0"
#define fileSub         @"FFE1"

extern NSString *const SYDidConnectPeripheral;

typedef void(^BLTResponseBlock)(NSString *response, NSString *UUID);
typedef void(^BLTSendDataFailedBlock)(NSError *err);

typedef NS_ENUM(NSInteger, BLTStatus)
{
    BLTStatusAvailable,
    BLTStatusUnavailable
};

//typedef NS_ENUM (NSInteger , BLHandleType)
//{
//    BLHandleTypeSetSystermTime = 0,
//    BLHandleTypeSetContinuesMeasureTime,
//    BLHandleTypeSetPowerOnDefaultModel,
//    BLHandleTypeMeasureNow,
//    BLHandleTypeStopMeasure,
//    BLHandleTypeChangeUser,
//    BLHandleTypeChangeNotifyMusic,
//    BLHandleTypeTest,
//    BLHandleTypePowerOff,
//    BLHandleTypeContinusMeasureSwitch,
//    BLHandleTypeGetDeviceInfo,
//    BLHandleTypeGetSystermTime,
//    BLHandleTypeSetSystermCurrentStatus,
//    BLHandleTypeGetMeasureData
//};

@protocol SYPeripheralsHandleDelegate <NSObject>

-(void)updataHasFindPeripheralsWith:(NSArray *)peripherals;
-(void)peripheralHandleDidConnectPeripheral;
-(void)peripheralHandleDidDisConnectPeripheral;
-(void)peripheralDidUpdataValue:(NSString *)string withUUID:(NSString *)UUID;

@end

@interface SYPeripheralsHandle : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    CBCentralManager *_centerManager;
    NSInteger _peripheralsCount;
    CBPeripheral *_curConnectPeripheral;
}

@property (nonatomic, assign) id<SYPeripheralsHandleDelegate>delegate;
@property (nonatomic, strong, readonly) CBPeripheral *curConnectPeripheral;
@property (nonatomic, strong, readonly) NSMutableArray *peripherals;
@property (nonatomic, readonly) BLTStatus status;

+(SYPeripheralsHandle *)shareBlueToothHandle;
-(void)refreshScanPeripherals;
-(void)connectToPeripheral:(CBPeripheral *)peripheral;
-(void)cancleConnectPeripheral:(CBPeripheral *)peripheral;
-(void)startCurrentPeripheral;
-(void)stopCurrentPeripheral;

- (BOOL)peripheralAvailable;

//handle peripheral
- (void)sendData:(NSData *)data;
-(void)sendData:(NSData *)data toPeripheral:(CBPeripheral *)peripheral;
-(void)sendData:(NSData *)data responseBlock:(BLTResponseBlock)responseBlock failedBlock:(BLTSendDataFailedBlock)failedBlock;

//-(void)sendData:(NSData *)data responseBlock:(BLTResponseBlock)responseBlock failedBlock:(BLTSendDataFailedBlock)failedBlock type:(BLHandleType)type;

@end