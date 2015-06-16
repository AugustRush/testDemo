//
//  BTModel.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-4-2.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BTInterfaceService.h"
#import "RyFitPeripheral.h"

#define BT_DATA_INITAIL_FINISHED                                @"BT_DATA_INITAIL_FINISHED"
#define BT_DATA_INITAIL_FAILED                                  @"BT_DATA_INITAIL_FAILED"
#define kLAST_CONNECTED_DEVICE_UUID_KEY                         @"kLAST_CONNECTED_DEVICE_UUID_KEY"
#define BTSERVICE_NOTIFICATION_CENTRALMANAGERDIDUUPDATESTATE    @"CENTRALMANAGERDIDUUPDATESTATE"

typedef void(^BTModelResponseCompletion)(id responseData);

@interface BTModel : NSObject

@property (nonatomic, readonly)NSMutableArray       *userInfoList;
@property (nonatomic, readonly)NSMutableArray       *allUserDataList;
@property (nonatomic, readonly)NSString             *deviceCode;
@property (nonatomic, readonly)BOOL                 peripheralDataPrepareOK;
@property (nonatomic, readonly)BOOL                 isConnecting;
@property (nonatomic, readonly)CBCentralManagerState managerState;

+ (BTModel *)sharedInstance;

/**
 *  装载
 */
- (void)setup;

/**
 *  断开与当前连接设备的连接（会自动重新连接设备）
 */
- (void)breakConnectPeripheral;

/**
 *  删除所有用户
 *
 *  @param completion 回调
 */
- (void)deleteAllUserCompletion:(BTModelResponseCompletion)completion;

/**
 *  选择用户称重
 *
 *  @param userInfo  用户信息
 *  @param isTesting 是否是测试 NO 切换用户/登陆用户入口 YES 未登陆用户/体验用户/注册用户
 */
- (void)selectUserInScale:(UserInfoEntity *)userInfo isTesting:(BOOL)isTesting;

@end
