//
//  BlueToothHelper.h
//  BodyScale
//
//  Created by August on 14-10-12.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <math.h>
#import "CBPeripheral+MAC.h"

#define ServiceID                 @"FFE0"
#define WriteCharactarID          @"FFE3"
#define NotifyCharactarID         @"FFE1"

typedef void(^VarargsBlock) ();

NS_INLINE NSData* hexToBytes(NSString *hexString) {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= hexString.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [hexString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

NS_INLINE NSString * hexStringWithInteger(NSInteger tmpid)
{
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"a";break;
            case 11:
                nLetterValue =@"b";break;
            case 12:
                nLetterValue =@"c";break;
            case 13:
                nLetterValue =@"d";break;
            case 14:
                nLetterValue =@"e";break;
            case 15:
                nLetterValue =@"f";break;
            default:
                nLetterValue =[[NSString alloc]initWithFormat:@"%lli",ttmpig];
                
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
        
    }
    if (str.length % 2 == 0) {
        return str;
    }else{
        return [NSString stringWithFormat:@"0%@",str];
    }
}


typedef NS_ENUM(int32_t, MeasureActionType) {
    InstanceWeight = 0,//实时体重
    selectUserMesureAck,//选择用户测量
    selectUserMesureComplpete,//用户测量完成
    selectUserMesureComplpeteExtra,//测量完成的扩展数据
    CreateNewUser,//创建新的用户
    DeleteExistUser,//删除存在的用户
    UpdateExistUserInfo,//更新用户数据
    GetAllUserInfos,//获取秤内所有用户信息
    DeleteUserMeasureData,//删除用户所有测量数据
    ResetBodyScale,//重置体制秤
    GetBodyScaleSoftVersion,//获取秤的软件版本
    GetBodyScaleBlueToothVersion,//获取秤的蓝牙版本
};

@interface BlueToothHelper : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
@private
    VarargsBlock _centerChangedStateBlock;
    VarargsBlock _scanPeripheralsBlock;
    VarargsBlock _connectPeripheralBlock;
    VarargsBlock _cancelConnectPeripheralBlock;
    VarargsBlock _peripheralResponseBlock;
}

@property (nonatomic, strong, readonly) CBCentralManager *centralManager;
@property (nonatomic, strong, readonly) NSMutableArray *peripherals;
@property (nonatomic, strong) CBPeripheral *connectedPeripheral;

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
-(void)centralManagerScanPeripheralsWithSeviceUUIDS:(NSArray *)serviceUUIDs completeBlock:(void(^)(NSArray *peripherals))block;

/**
 *  连接特定的外围设备
 *
 *  @param peripheral 外围
 *  @param block      完成回调，error包含失败的错误信息
 */
-(void)centralManagerConnectToPeripheral:(CBPeripheral *)peripheral completeBlock:(void(^)(CBPeripheral *peripheral,NSError *error))block;

/**
 *  断开连接
 *
 *  @param peripheral 断开的外围设备
 *  @param block      完成回调，error包含失败的错误信息
 */
-(void)centralManagerCancelConnectPeripheral:(CBPeripheral *)peripheral comleteBlock:(void(^)(CBPeripheral *peripheral,NSError *error))block;

/**
 *  写数据到特定的外围设备
 *
 *  @param peripheral     外围
 *  @param characteristic 服务特征
 *  @param block          外围执行指令后返回数据回调
 */
-(void)centralManagerSendData:(NSData *)data ToPeripheral:(CBPeripheral *)peripheral;

/**
 *  外围设备数据分发回调，所有的数据更新都会调用这个接口
 *
 *  @param block 回调block
 */
-(void)centralManagerDidRecieveDataWithBlock:(void(^)(MeasureActionType type, id value, CBPeripheral *peripheral, NSError *error))block;

@end
