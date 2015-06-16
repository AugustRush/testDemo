//
//  BlueToothHelper.m
//  BodyScale
//
//  Created by August on 14-10-12.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import "BlueToothHelper.h"

@interface BlueToothHelper ()

@end

@implementation BlueToothHelper

#pragma mark - init methods

-(instancetype)init
{
    self = [super init];
    if (self) {
        _centralManager = [[CBCentralManager alloc] init];
        _peripherals = [NSMutableArray array];
        _peripheralResponseBlocks = [NSMutableDictionary dictionary];
    }
    return self;
}

+(instancetype)shareInstance
{
    static BlueToothHelper *blueToothHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        blueToothHelper = [[BlueToothHelper alloc] init];
    });
    return blueToothHelper;
}

#pragma mark - public methods

-(void)centralManagerChangedStateBlock:(void (^)(CBCentralManagerState))block
{
    _centerChangedStateBlock = block;
}

-(void)centralManagerScanPeripheralsWithBlock:(void (^)(NSArray *))block
{
    [self centralManagerScanPeripheralsWithSeviceUUIDS:nil completeBlock:block];
}

-(void)centralManagerScanPeripheralsWithSeviceUUIDS:(NSArray *)serviceUUIDs completeBlock:(void (^)(NSArray *))block
{
    [self.centralManager scanForPeripheralsWithServices:serviceUUIDs
                                                options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@YES}];
    
    
    _scanPeripheralsBlock = block;
}

-(void)centralManagerConnectToPeripheral:(CBPeripheral *)peripheral completeBlock:(void (^)(CBPeripheral *,NSError *))block
{
    NSAssert(peripheral != nil, @"will connect to a peripheral which should not be nil");
    [self.centralManager connectPeripheral:peripheral options:nil];_connectPeripheralBlock = block;
}

-(void)centralManagerCancelConnectPeripheral:(CBPeripheral *)peripheral comleteBlock:(void (^)(CBPeripheral *,NSError *))block
{
    NSAssert(peripheral != nil, @"will cancel connect a peripheral which should not be nil");
    [self.centralManager cancelPeripheralConnection:peripheral];
    _cancelConnectPeripheralBlock = block;
}

-(void)centralManagerSendData:(NSData *)data
                 ToPeripheral:(CBPeripheral *)peripheral
            forCharacteristic:(CBCharacteristic *)characteristic
                responseBlock:(void (^)(CBCharacteristic *, NSError *))block
{
    [peripheral writeValue:data
         forCharacteristic:characteristic
                      type:CBCharacteristicWriteWithResponse];
    
}
#pragma mark - CBCentralManagerDelegate methods
//状态更改
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    _centerChangedStateBlock(central.state);
}

//发现外围
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    if (![_peripherals containsObject:peripheral]) {
        [_peripherals addObject:peripheral];
        _scanPeripheralsBlock(_peripherals);
    }
}

//连接
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    _connectPeripheralBlock(peripheral,nil);
}

//失去连接
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    _cancelConnectPeripheralBlock(peripheral,error);
}

//连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    _connectPeripheralBlock(peripheral,error);
}

-(void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict
{

}

-(void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals
{

}

-(void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals
{

}

#pragma mark - CBPeripheralDelegate methdos

-(void)peripheralDidUpdateName:(CBPeripheral *)peripheral
{

}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverIncludedServicesForService:(CBService *)service error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{

}

@end
