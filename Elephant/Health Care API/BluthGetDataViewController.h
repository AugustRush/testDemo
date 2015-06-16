//
//  BluthGetDataViewController.h
//  HealthManager
//
//  Created by Apple on 13-9-6.
//  Copyright (c) 2013年 ikentop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBCMCtrl.h"
#import "CBCPCtrl.h"

@protocol BLEDelegate;
@interface BluthGetDataViewController : UIViewController<CBCMCtrlDelegate,CBCPCtrlDelegate>
{
    
}
@property (strong,nonatomic) CBCMCtrl *CBC;
@property (strong,nonatomic) CBCPCtrl *CBP;
@property (weak,nonatomic)id<BLEDelegate>delegate;
@property (strong,nonatomic) NSString *selectedMACADDRES;


typedef NS_ENUM(NSInteger, CMDSTATUS)
{
    STATUS_BingToScale = 0xA0,
    STATUS_UnBingToScale = 0xA1,
    STATUS_UpdateUser = 0xA2,
    STATUS_SelectUser = 0xA5,
    STATUS_GetUserMeasurements = 0xA6,
    STATUS_DeleteMeasurementsStatus = 0xA7,
    STATUS_BingToNewScale = 0xA8,
    STATUS_ScaleReset = 0xAF,
    STATUS_GetModuleVersion = 0xAE,
    STATUS_GetBLEVersion = 0xA0
};


// Initlize
- (void)initWithself;


// API
- (void)enableSearch;
- (void)disableSearch;
- (void)tryConnect:(CBPeripheral *)p;
- (void)tryDisconnect;
- (NSString *)getMacAddress;
- (bool)isConnected;
- (NSArray *)getListUserExist;
- (NSArray *)getListUserData;
- (void)updateUserData:(int)pno withValue:(NSString *)value;
- (void)updateUserExist:(int)pno withValue:(NSString *)value;
- (void)enableSearchOtherDevices;
- (void)disableSearchOtherDevices;
- (CBPeripheral *)getConnectedCBPeripheral;



// APP to BT
- (void)scale_setDateTime;
- (void)BingToScale:(NSString *)macaddress withHeight:(NSString *)height withAge:(NSString *)age withSex:(NSString *)sex;
- (void)unBingToScale:(NSString *)macaddress withPNo:(NSString *)pno;
- (void)BingToNewScale:(NSString *)macaddress withPNo:(NSString *)pno withHeight:(NSString *)height withAge:(NSString *)age withSex: (NSString *)sex;
- (void)scale_updateuser:(NSString *)macaddress withPNo:(NSString *)pno withHeight:(NSString *)height withAge:(NSString *)age withSex:(NSString *)sex;
- (void)scale_getUserList:(NSString *)macaddress;
- (void)scale_selectuser:(NSString *)macaddress withPNo:(NSString *)pno withHeight:(NSString *)height withAge:(NSString *)age withSex:(NSString *)sex withUnit:(NSString *)unit;
- (void)scale_getUserMeasurements:(NSString *)macaddress withPNo:(NSString *)pno;
- (void)scale_deleteUserMeasurements:(NSString *)macaddress withPNo:(NSString *)pno;
- (void)scale_reset;
- (void)scale_getModuleVersion;
- (void)scale_getBLEVersion;
- (void)scale_guestuser:(NSString *)macaddress withHeight:(NSString *)height withAge:(NSString *)age withSex:(NSString *)sex withUnit:(NSString *)unit;


@end


// Event
@protocol BLEDelegate <NSObject>
@optional
- (void)foundPeripheral:(CBPeripheral *)p withMacAddress:(NSString *)macaddress;
- (void)didBingToScaleStatus:(double)pno;
- (void)didBingToNewScaleStatus:(double)pno;
- (void)didUnBingToScaleStatus:(double)status;
- (void)didUpdateUserStatus:(double)status;
- (void)didSelectUserStatus:(double)status;
- (void)didGetUserMeasurementsStatus:(double)status withRecords:(double)rec;
- (void)didDeleteMeasurementsStatus:(double)status;
- (void)didScaleResetStatus:(double)status;
- (void)didGetUserList:(NSString *)pno withHeight:(NSString *)height withAge:(NSString *)age withSex: (NSString *)sex;
- (void)didGetCurrentMeasurement:(NSString *)pno withTime:(NSDate *)time withWeight:(NSString *)weight withBF:(NSString *)bf withWater:(NSString *)water withMuscle:(NSString *)muscle withBone:(NSString *)bone withBMR:(NSString *)bmr withSFat:(NSString *)sfat withInFat:(NSString *)infat withBodyAge:(NSString *)bodyage withAMR:(NSString *)amr;
- (void)didGetUserMeasurement:(NSString *)pno withTime:(NSDate *)time withWeight:(NSString *)weight withBF:(NSString *)bf withWater:(NSString *)water withMuscle:(NSString *)muscle withBone:(NSString *)bone withBMR:(NSString *)bmr withSFat:(NSString *)sfat withInFat:(NSString *)infat withBodyAge:(NSString *)bodyage withAMR:(NSString *)amr withSeqNo:(int)seqno;
- (void)didGetLiveWeight:(NSString *)weight isLock:(double)islock;

- (void)didGetModuleVersion:(double)version;
- (void)didGetBLEVersion:(double)version;
- (void)didOverTimeStatus:(int)cmdID withStatus:(int)status;

@end
