//
//  CBCMCtrl.h
//  BLE-Tutorial_2
//
//  Created by Ole Andreas Torvmark on 3/15/12.
//  Copyright (c) 2012 ST alliance AS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol CBCMCtrlDelegate <NSObject>

@required
//- (void) updateCMLog:(NSString *)text;
- (void) foundPeripheral:(CBPeripheral *)p advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
- (void) connectedPeripheral:(CBPeripheral *)p;
- (void) connectedPeripherals:(NSArray *)p;

@end

@interface CBCMCtrl : NSObject <CBCentralManagerDelegate> {
    
}

@property bool cBReady;
@property (nonatomic,strong) CBCentralManager *cBCM;
@property (nonatomic,assign) id<CBCMCtrlDelegate> delegate;

@end