//
//  CBCPCtrl.h
//  BLE-Tutorial_2
//
//  Created by Ole Andreas Torvmark on 3/16/12.
//  Copyright (c) 2012 ST alliance AS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol CBCPCtrlDelegate <NSObject>

@required
//-(void) updateCPLog:(NSString *)text;
//-(void) servicesRead;
-(void) updatedRSSI:(CBPeripheral *)peripheral;
-(void) updatedCharacteristic:(CBPeripheral *)peripheral sUUID:(CBUUID *)sUUID cUUID:(CBUUID *)cUUID data:(NSData *)data;
-(void) updatedCharacteristic:(CBPeripheral *)peripheral data:(NSData *)data;
@end


@interface CBCPCtrl : NSObject <CBPeripheralDelegate>


@property (strong,nonatomic) CBPeripheral *cBCP;
@property (strong,nonatomic) id<CBCPCtrlDelegate> delegate;


-(void)writeCharacteristic:(CBPeripheral *)peripheral sUUID:(NSString *)sUUID cUUID:(NSString *)cUUID data:(NSData *)data;

-(void)readCharacteristic:(CBPeripheral *)peripheral sUUID:(NSString *)sUUID cUUID:(NSString *)cUUID;

-(void)setNotificationForCharacteristic:(CBPeripheral *)peripheral sUUID:(NSString *)sUUID cUUID:(NSString *)cUUID enable:(BOOL)enable;
@end
