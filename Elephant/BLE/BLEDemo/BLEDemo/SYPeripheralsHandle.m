//
//  SYPeripheralsHandle.m
//  iChrono365
//
//  Created by 刘平伟 on 14-1-8.
//  Copyright (c) 2014年 刘平伟. All rights reserved.
//

#import "SYPeripheralsHandle.h"

SYPeripheralsHandle *__kBlueToothHandle = nil;

NSString *const SYDidConnectPeripheral = @"SYDidConnectPeripheral";

@interface SYPeripheralsHandle ()

@property (nonatomic, strong) NSMutableData *reciveData;
//@property (nonatomic, copy) BLTResponseBlock responseBlock;
//@property (nonatomic, copy) BLTSendDataFailedBlock failedBlock;

@property (nonatomic, strong) NSMutableArray *responseBlockArr;
@property (nonatomic, strong) NSMutableArray *failedBlockArr;

@end

@implementation SYPeripheralsHandle 

#pragma mark - init

-(id)init
{
    self = [super init];
    if (self) {
        
        self.responseBlockArr = [NSMutableArray array];
        self.failedBlockArr = [NSMutableArray array];
        
        self.reciveData = [NSMutableData data];
        _peripherals = [NSMutableArray array];

        _centerManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

#pragma mark - custom

+(SYPeripheralsHandle *)shareBlueToothHandle
{
    if (__kBlueToothHandle == nil) {
        __kBlueToothHandle = [[SYPeripheralsHandle alloc] init];
    }
    [__kBlueToothHandle centralManagerDidUpdateState:__kBlueToothHandle->_centerManager];
    return __kBlueToothHandle;
}

-(BLTStatus)status
{
    if (self.curConnectPeripheral) {
        return BLTStatusAvailable;
    } else{
        return BLTStatusUnavailable;
    }
}

- (BOOL)peripheralAvailable {
    return _curConnectPeripheral ? YES : NO;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    
//    NSString *message = nil;
    
    switch (central.state) {
            
        case CBCentralManagerStatePoweredOn:
        {
            // Scans for any peripheral
            [central scanForPeripheralsWithServices:@[[self getServiceUUID]]
                                            options:@{CBCentralManagerScanOptionAllowDuplicatesKey :
                                                          
                                                          @NO}];
        }
            break;
            
        case CBCentralManagerStateUnauthorized:
//            message = @"请在设置里打开蓝牙授权";
            break;

        case CBCentralManagerStatePoweredOff:
//            message = @"请打开蓝牙";
            _curConnectPeripheral = nil;
            break;
            
        case CBCentralManagerStateUnsupported:
//            message  = @"设备不支持相应的蓝牙模块";
            break;


        default:
            
//            NSLog(@"Central Manager did change state");
            
            break;
            
    }
    
//    if (message) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:message
//                                                       delegate:nil
//                                              cancelButtonTitle:@"确定"
//                                              otherButtonTitles: nil];
//        [alert show];
//    }
    
}

-(void)refreshScanPeripherals
{
    [self.peripherals removeAllObjects];
    [self centralManagerDidUpdateState:_centerManager];
    if (self.delegate && [self.delegate respondsToSelector:@selector(updataHasFindPeripheralsWith:)]) {
        [self.delegate updataHasFindPeripheralsWith:_peripherals];
    }
}

-(void)connectToPeripheral:(CBPeripheral *)peripheral
{
    if (![peripheral isConnected]) {
        [_centerManager connectPeripheral:peripheral options:nil];
    }
}

-(void)cancleConnectPeripheral:(CBPeripheral *)peripheral
{
    if (peripheral) {
        [_centerManager cancelPeripheralConnection:peripheral];
    }
}

-(void)startCurrentPeripheral
{
    static int nSendACnt = 0;
    if (nSendACnt<=39){
        nSendACnt++;
        NSData *data = [@"a" dataUsingEncoding:[NSString defaultCStringEncoding]];
        [self sendData:data toPeripheral:_curConnectPeripheral];
        [self performSelector:@selector(startCurrentPeripheral) withObject:nil afterDelay:.4f];
    }
    else{
        nSendACnt = 0;
    }
    
}

-(void)stopCurrentPeripheral
{
    if (_curConnectPeripheral) {
        NSData *data = [@"f" dataUsingEncoding:[NSString defaultCStringEncoding]];
        [self sendData:data toPeripheral:_curConnectPeripheral];
        [self cancleConnectPeripheral:_curConnectPeripheral];
    }
}

-(CBUUID *)getServiceUUID
{
    return [CBUUID UUIDWithString:fileService];
}

-(CBUUID *)getCharacteristicUUID
{
    return [CBUUID UUIDWithString:fileSub];
}

#pragma mark - base sevice handle

-(CBService *) findServiceFromUUIDEx:(CBUUID *)UUID p:(CBPeripheral *)p {
    for(int i = 0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
        if ([self compareCBUUID:s.UUID UUID2:UUID])
            return s;
    }
    return nil; //Service not found on this peripheral
}

-(CBCharacteristic *) findCharacteristicFromUUIDEx:(CBUUID *)UUID service:(CBService*)service {
    for(int i=0; i < service.characteristics.count; i++) {
        CBCharacteristic *c = [service.characteristics objectAtIndex:i];
        if ([self compareCBUUID:c.UUID UUID2:UUID]) return c;
    }
    return nil; //Characteristic not found on this service
}

-(void) readValue: (int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p {
    CBUUID *su = [self getServiceUUID];
    CBUUID *cu = [self getCharacteristicUUID];
    CBService *service = [self findServiceFromUUIDEx:su p:p];
    if (!service) {
        //        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:cu service:service];
    if (!characteristic) {
//        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p readValueForCharacteristic:characteristic];
}


-(void) writeValue:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p data:(NSData *)data {
    
    CBUUID *su = [self getServiceUUID];
    CBUUID *cu = [self getCharacteristicUUID];
//    NSLog(@"sd cd su cu  is [%@  %@  %@  %@]\n",sd,cd,su,cu);
    CBService *service = [self findServiceFromUUIDEx:su p:p];
    if (!service) {
//        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:cu service:service];
    if (!characteristic) {
//        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithoutResponse];
//    [p writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
}

-(void) getAllCharacteristicsFromKeyfob:(CBPeripheral *)p{
    for (int i=0; i < p.services.count; i++) {
        CBService *s = [p.services objectAtIndex:i];
//        printf("Fetching characteristics for service with UUID : %s\r\n",[self CBUUIDToString:s.UUID]);
        [p discoverCharacteristics:@[[self getCharacteristicUUID]] forService:s];
    }
}

- (void) printPeripheralInfo:(CBPeripheral*)peripheral {
    CFStringRef s = CFUUIDCreateString(NULL, peripheral.UUID);
//    printf("------------------------------------\r\n");
//    printf("Peripheral Info :\r\n");
//    printf("UUID : %s\r\n",CFStringGetCStringPtr(s, 0));
//    printf("RSSI : %d\r\n",[peripheral.RSSI intValue]);
//    printf("Name : %s\r\n",[peripheral.name cStringUsingEncoding:NSStringEncodingConversionAllowLossy]);
//    printf("isConnected : %d\r\n",peripheral.isConnected);
//    printf("-------------------------------------\r\n");
    CFRelease(s);
    
}

-(void) notify: (CBPeripheral *)peripheral on:(BOOL)on
{
    [self notification:0 characteristicUUID:0 p:peripheral on:YES];
    
    //[peripheral setNotifyValue:on forCharacteristic:dataNotifyCharacteristic];
}

-(void) notification:(int)serviceUUID characteristicUUID:(int)characteristicUUID p:(CBPeripheral *)p on:(BOOL)on {
    CBUUID *su = [self getServiceUUID];
    CBUUID *cu = [self getCharacteristicUUID];
    CBService *service = [self findServiceFromUUIDEx:su p:p];
    if (!service) {
        //        printf("Could not find service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    CBCharacteristic *characteristic = [self findCharacteristicFromUUIDEx:cu service:service];
    if (!characteristic) {
//        printf("Could not find characteristic with UUID %s on service with UUID %s on peripheral with UUID %s\r\n",[self CBUUIDToString:cu],[self CBUUIDToString:su],[self UUIDToString:p.UUID]);
        return;
    }
    [p setNotifyValue:on forCharacteristic:characteristic];
}

#pragma mark - basic peripheral handle

- (void)sendData:(NSData *)data {
    [self sendData:data toPeripheral:self.curConnectPeripheral];
}

-(void)sendData:(NSData *)data responseBlock:(BLTResponseBlock)responseBlock failedBlock:(BLTSendDataFailedBlock)failedBlock
{
//    self.responseBlock = responseBlock;
//    self.failedBlock = failedBlock;
    [self.responseBlockArr addObject:responseBlock];
    [self.failedBlockArr addObject:failedBlock];
    
    [self writeValue:0 characteristicUUID:0 p:self.curConnectPeripheral data:data];
}

//-(void)sendData:(NSData *)data responseBlock:(BLTResponseBlock)responseBlock failedBlock:(BLTSendDataFailedBlock)failedBlock type:(BLHandleType)type
//{
//
//}

-(void)sendData:(NSData *)data toPeripheral:(CBPeripheral *)peripheral
{
    [self sendData:data responseBlock:nil failedBlock:nil];
}

#pragma mark - CBPeripheralDelegate methods

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    
    if (error) {
//        printf("updateValueForCharacteristic failed\n");
        if (self.failedBlockArr.count > 0) {
            BLTSendDataFailedBlock block = [self.failedBlockArr lastObject];
            block(error);
            [self.failedBlockArr removeLastObject];
        }
//        self.failedBlock(error);
        return;
    }
//    NSLog(@"peripheral value is %@\n",characteristic.value);
    
    [self.reciveData appendData:characteristic.value];
    NSString *response = [[NSString alloc] initWithData:self.reciveData encoding:NSUTF8StringEncoding];
    
//    NSLog(@"peripheral response is %@",response);
    
    if ([response hasSuffix:@"\0"]) {
//        NSLog(@"over over over");
        [self.reciveData setLength:0];
    
        if (self.responseBlockArr.count > 0) {
            BLTResponseBlock block = [self.responseBlockArr lastObject];
            block(response,fileSub);
            [self.responseBlockArr removeLastObject];
//            self.responseBlock(response, @"FFE1");
        }
    
        if (self.delegate && [self.delegate respondsToSelector:@selector(peripheralDidUpdataValue:withUUID:)]) {
            [self.delegate peripheralDidUpdataValue:response withUUID:@"FFE1"];
        }
    
    }
    
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (!error) {
//        printf("Services of peripheral with UUID : %s found\r\n",[self UUIDToString:peripheral.UUID]);
        [self getAllCharacteristicsFromKeyfob:peripheral];
    }
    else {
//        printf("Service discovery was unsuccessfull !\r\n");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (!error) {
//        printf("Characteristics of service with UUID : %s found\r\n",[self CBUUIDToString:service.UUID]);
        for(int i=0; i < service.characteristics.count; i++) {
//            CBCharacteristic *c = [service.characteristics objectAtIndex:i];
//            printf("Found characteristic %s\r\n",[ self CBUUIDToString:c.UUID]);
            CBService *s = [peripheral.services objectAtIndex:(peripheral.services.count - 1)];
            if([self compareCBUUID:service.UUID UUID2:s.UUID]) {
//                printf("Finished discovering characteristics\n");
                [self notify:peripheral on:YES];
            }
        }
    }
    else {
//        printf("Characteristic discorvery unsuccessfull !\r\n");
    }
}

#pragma mark - CBCentralManagerDelegate methods

-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *pname=peripheral.name.lowercaseString;
     if ([pname hasPrefix:@"healthcare"]) {
        NSLog(@"discoverd peripheral %@",pname);
        [self.peripherals addObject:peripheral];
           
        if (self.delegate && [self.delegate respondsToSelector:@selector(updataHasFindPeripheralsWith:)]) {
            [self.delegate updataHasFindPeripheralsWith:_peripherals];
        }
        
    }
    
    //    }
    
}

-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    _curConnectPeripheral = peripheral;
    _curConnectPeripheral.delegate = self;
    
    [_curConnectPeripheral discoverServices:@[[self getServiceUUID]]];
    
    [self printPeripheralInfo:peripheral];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(peripheralHandleDidConnectPeripheral)]) {
        [self.delegate peripheralHandleDidConnectPeripheral];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SYDidConnectPeripheral object:nil];
}


-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    [_peripherals removeObject:_curConnectPeripheral];
    _curConnectPeripheral = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(peripheralHandleDidDisConnectPeripheral)]) {
        [self.delegate peripheralHandleDidDisConnectPeripheral];
    }
}

#pragma mark - string handle

-(int) compareCBUUID:(CBUUID *) UUID1 UUID2:(CBUUID *)UUID2 {
    char b1[16];
    char b2[16];
    [UUID1.data getBytes:b1];
    [UUID2.data getBytes:b2];
    if (memcmp(b1, b2, UUID1.data.length) == 0)return 1;
    else return 0;
}

#pragma mark - manage memory

-(void)dealloc
{
    self.delegate = nil;
    _centerManager.delegate = nil;
}

@end