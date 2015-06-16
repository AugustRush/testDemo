//
//  BTService.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-4-17.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BTService.h"
#import "BTUtils.h"

#define BTSERVICE_NOTIFICATION_CENTRALMANAGERDIDUUPDATESTATE    @"CENTRALMANAGERDIDUUPDATESTATE"

/*
#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif
 */
//#define NSLog(...)
//#define debugMethod()


@interface BTService () <CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, assign)id<BTServiceDelegate> delegate;
@property (strong, nonatomic)CBCentralManager  *manager;

@end

@implementation BTService {
    NSDictionary *_notifyOptions;           // 特征通知开关设置
}

#pragma mark - Initialization
- (id)initWithDelegate:(id<BTServiceDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.activePeripherals = [NSMutableArray array];
        self.peripherals = [NSMutableArray array];
    }
    return self;
}

#pragma mark - Public Method
/* 搜索设备 */
- (BOOL)scanForPeripheralsWithServices:(NSArray *)services timeout:(int)timeout {
    [_peripherals removeAllObjects];// 清空设备列表
    
    if ([_manager state] != CBCentralManagerStatePoweredOn) {
        NSLog(@"设备状态异常");
        return NO;
    }
    
    if (timeout != -1) {
        [NSTimer scheduledTimerWithTimeInterval:(float)timeout target:self selector:@selector(scanTimer:) userInfo:nil repeats:NO];
    }
    
    [_manager stopScan];
    [_manager scanForPeripheralsWithServices:nil options:0];
    return YES;
}

/* 停止搜索设备 */
- (void)stopScan {
    [_manager stopScan];
}

/* 连接到设备 */
- (void)connect:(CBPeripheral *)peripheral notifyOptions:(NSDictionary *)notifyOptions {
    if (notifyOptions) {
        _notifyOptions = [NSDictionary dictionaryWithDictionary:notifyOptions];
    } else {
        _notifyOptions = nil;
    }
    [_manager connectPeripheral:peripheral options:nil];
}

/* 与设备断开连接 */
- (void)disconnect:(CBPeripheral *)peripheral {
    [_manager cancelPeripheralConnection:peripheral];
}

/* 写入蓝牙数据 */
- (void)writeValueWithServiceUUID:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral data:(NSData *)data type:(CBCharacteristicWriteType)type {
    CBService *service = [self findServiceFromUUIDEx:serviceUUID p:peripheral];
    if (!service) {
        NSLog(@"在设备 %@ 中找不到服务 %@", [BTUtils UUIDToString:peripheral.UUID], [BTUtils CBUUIDToString:serviceUUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:characteristicUUID service:service];
    if (!characteristic) {
        NSLog(@"在设备 %@ 服务 %@ 中找不到 特征 %@", [BTUtils UUIDToString:peripheral.UUID], [BTUtils CBUUIDToString:serviceUUID], [BTUtils CBUUIDToString:characteristicUUID]);
        return;
    }
    
    [peripheral writeValue:data forCharacteristic:characteristic type:type];
}

/* 写入蓝牙数据 */
- (void)writeValueWithServiceUUID:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral data:(NSData *)data {
    CBService *service = [self findServiceFromUUIDEx:serviceUUID p:peripheral];
    if (!service) {
        NSLog(@"在设备 %@ 中找不到服务 %@", [BTUtils UUIDToString:peripheral.UUID], [BTUtils CBUUIDToString:serviceUUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:characteristicUUID service:service];
    if (!characteristic) {
        NSLog(@"在设备 %@ 服务 %@ 中找不到 特征 %@", [BTUtils UUIDToString:peripheral.UUID], [BTUtils CBUUIDToString:serviceUUID], [BTUtils CBUUIDToString:characteristicUUID]);
        return;
    }
    
    // 判断权限，写入是否有响应，如果有响应权限就响应，否则不响应
    CBCharacteristicWriteType type;
    if ((characteristic.properties & CBCharacteristicPropertyWrite) == CBCharacteristicPropertyWrite) {
        type = CBCharacteristicWriteWithResponse;
    } else {
        type = CBCharacteristicWriteWithoutResponse;
    }
    [peripheral writeValue:data forCharacteristic:characteristic type:type];
}

/* 读出蓝牙数据 */
- (void)readValue:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral {
    CBService *service = [self findServiceFromUUIDEx:serviceUUID p:peripheral];
    if (!service) {
        NSLog(@"Could not find service with UUID %@ on peripheral with UUID %@\r\n",[BTUtils CBUUIDToString:serviceUUID],[BTUtils UUIDToString:peripheral.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:characteristicUUID service:service];
    if (!characteristic) {
        NSLog(@"Could not find characteristic with UUID %@ on service with UUID %@ on peripheral with UUID %@\r\n",[BTUtils CBUUIDToString:characteristicUUID],[BTUtils CBUUIDToString:serviceUUID],[BTUtils UUIDToString:peripheral.UUID]);
        return;
    }
    [peripheral readValueForCharacteristic:characteristic];
}

/* 设置特征数据变更接收通知开关 */
- (void)notification:(CBUUID *)serviceUUID characteristicUUID:(CBUUID *)characteristicUUID peripheral:(CBPeripheral *)peripheral on:(BOOL)on {
    CBService *service = [self findServiceFromUUIDEx:serviceUUID p:peripheral];
    if (!service) {
        NSLog(@"在设备 %@ 上找不到 %@ 服务", [BTUtils UUIDToString:peripheral.UUID], [BTUtils CBUUIDToString:serviceUUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:characteristicUUID service:service];
    if (!characteristic) {
        NSLog(@"在设备 %@ 的服务 %@ 上，找不到特征%@", [BTUtils UUIDToString:peripheral.UUID], [BTUtils CBUUIDToString:serviceUUID], [BTUtils CBUUIDToString:characteristicUUID]);
        return;
    }
    [peripheral setNotifyValue:on forCharacteristic:characteristic];
}

#pragma mark - Private Method
/* 超时停止搜索 */
- (void)scanTimer:(NSTimer *)timer {
    [_manager stopScan];
}

/* 从周边设备中查找服务 返回nil 则周边设备中没有该服务 */
- (CBService *)findServiceFromUUIDEx:(CBUUID *)UUID p:(CBPeripheral *)p {
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([BTUtils compareCBUUID:s.UUID UUID2:UUID]) return s;
    }
    return nil;
}

/* 从服务中查找特征 返回nil 则服务中没有该特征 */
- (CBCharacteristic *)findCharacteristicFromUUIDEx:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([BTUtils compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil;
}

/* 从设备中寻找服务 */
- (CBService *)findServiceFromUUID:(CBUUID *)UUID p:(CBPeripheral *)peripheral {
    NSLog(@"设备中一共有%lu个服务", (unsigned long)peripheral.services.count);
    for (CBService *s in peripheral.services) {
        NSLog(@"找到服务%s", [[s.UUID.data description] cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
        if ([BTUtils compareCBUUID:s.UUID UUID2:UUID]) {
            return s;
        }
    }
    return  nil;
}

/* 从服务中寻找特征 */
- (CBCharacteristic *)findCharacteristicFromUUID:(CBUUID *)UUID p:(CBPeripheral *)peripheral service:(CBService *)service {
    for (CBCharacteristic *c in service.characteristics) {
        if ([[c.UUID data] isEqualToData:[UUID data]]) {
            return c;
        }
    }
    return nil;
}

#pragma mark - CBCentralManager Delegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    [[NSNotificationCenter defaultCenter] postNotificationName:BTSERVICE_NOTIFICATION_CENTRALMANAGERDIDUUPDATESTATE object:central];
    switch (central.state) {
        case CBCentralManagerStatePoweredOn:
            NSLog(@"蓝牙设备状态:开启");
            break;
        case CBCentralManagerStatePoweredOff:
            NSLog(@"蓝牙设备状态:关闭");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"蓝牙设备状态:重置中");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"蓝牙设备状态:未授权");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"蓝牙设备状态:未知");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"蓝牙设备状态:不支持");
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    if (peripheral.name.length == 0) {
        NSLog(@"发现不完整的设备包：过滤");
        return;
    }
    
    // 筛选设备剔除黑名单设备
    NSString *uuidString = [BTUtils getUUIDWithPeripheral:peripheral];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BluetoothUUIDBlackList" ofType:@"plist"];
    NSArray *blackList = [[NSArray alloc] initWithContentsOfFile:path];
    for (NSString *uuid in blackList) {
        if ([uuidString isEqualToString:uuid]) {
            NSLog(@"发现黑名单设备");
            return;
        }
    }
    
    // 发现第一个设备
    if (!_peripherals) {
        _peripherals = [NSMutableArray array];
    }
    
    // 添加设备到设备组
    for (int i = 0; i < [_peripherals count]; i++) {
        CBPeripheral *p = [_peripherals objectAtIndex:i];;
        if ([BTUtils comparePeripheral:peripheral peripheral2:p]) {
            // 如果设备是和之前设备重复的 替换掉数组中之前的设备
            [_peripherals replaceObjectAtIndex:i withObject:peripheral];
            NSLog(@"找到重复设备并替换掉原设备");
            return;
        }
    }
    
    [_peripherals addObject:peripheral];
    [_delegate peripheralFound:peripheral RSSI:RSSI];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [_activePeripherals addObject:peripheral];
    
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    
    [BTUtils printPeripheralInfo:peripheral];
    [_delegate connectedPeripheral:peripheral];
    [[NSNotificationCenter defaultCenter] postNotificationName:BTSERVICE_NOTIFICATION_CONNECTED object:peripheral];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"与设备 %@ 断开连接", peripheral.UUID);
    [_activePeripherals removeObject:peripheral];
    [_delegate unconnectPeripheral:peripheral error:error];
    [[NSNotificationCenter defaultCenter] postNotificationName:BTSERVICE_NOTIFICATION_DISCONNECT object:peripheral];
}

-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [_delegate failToConnectPeripheral:peripheral error:error];
    [[NSNotificationCenter defaultCenter] postNotificationName:BTSERVICE_NOTIFICATION_DISCONNECT object:peripheral];
}

#pragma mark - CBPeripheral delegate
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
        NSLog(@"设备 %@ 找到服务",[BTUtils UUIDToString:peripheral.UUID]);
        for (CBService *service in peripheral.services) {
            NSLog(@"搜索服务 %@ 特征",[BTUtils CBUUIDToString:service.UUID]);
            [peripheral discoverCharacteristics:nil forService:service];
        }
    } else {
        NSLog(@"服务搜索失败");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (!error) {
        NSLog(@"服务 %@ 找到特征",[BTUtils CBUUIDToString:service.UUID]);
        for(int i = 0; i < service.characteristics.count; i ++) {
            CBCharacteristic *characteristic = service.characteristics[i];
            NSLog(@"找到特征 %@", [BTUtils CBUUIDToString:((CBCharacteristic *)[service.characteristics objectAtIndex:i]).UUID]);
            
            // TODO: 按照notifyOption设置开关
            CBCharacteristicProperties properties = characteristic.properties;
            if ((properties & CBCharacteristicPropertyNotify) == CBCharacteristicPropertyNotify) {
                [self notification:service.UUID characteristicUUID:characteristic.UUID peripheral:peripheral on:YES];
            }
        }
    } else {
        NSLog(@"特征搜索失败");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (!error) {
        NSLog(@"更新设备 %@ 服务 %@ 中对象 %@ 的通知状态",[BTUtils CBUUIDToString:characteristic.UUID],[BTUtils CBUUIDToString:characteristic.service.UUID],[BTUtils UUIDToString:peripheral.UUID]);
    } else {
        NSLog(@"设置设备 %@ 服务 %@ 中对象 %@ 的通知错误",[BTUtils CBUUIDToString:characteristic.UUID],[BTUtils CBUUIDToString:characteristic.service.UUID],[BTUtils UUIDToString:peripheral.UUID]);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"更新特征信息失败");
    } else {
        [_delegate peripheral:peripheral didUpdateValueForCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"蓝牙写入信息失败：特征 %@ , error is %@", characteristic, error);
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    if (error) {
        NSLog(@"蓝牙写入信号信息失败：信号 %@ , error is %@", descriptor, error);
    }
}

- (void)peripheralDidUpdateRSSI:(CBPeripheral *)peripheral error:(NSError *)error {
    if (error) {
        NSLog(@"蓝牙获取RSSI失败：设备 %@ , error is %@", peripheral, error);
    }
}

@end
