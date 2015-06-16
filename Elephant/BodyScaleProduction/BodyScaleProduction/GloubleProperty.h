//
//  GloubleProperty.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-24.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoEntity.h"
#import "UserDeviceInfoEntity.h"

#define USER_INFO_WILL_UPDATE [[GloubleProperty sharedInstance] currentUserInfoWillUpDate]

@interface GloubleProperty : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong)UserInfoEntity *currentUserEntity;
@property (nonatomic, strong)NSString       *sessionId;

@property (nonatomic, strong)NSString       *lng;//经度
@property (nonatomic, strong)NSString       *lat;//纬度
@property (nonatomic, strong)NSString       *url;//购买地址

@property (nonatomic, strong)NSString       *uuid;

@property (nonatomic, strong)UserDeviceInfoEntity *currentDeviceEntity;

@property (nonatomic)BOOL       registering;


// 个人资料是否变更
@property (nonatomic)BOOL currentUserInfoWillUpDate;
@property (nonatomic)BOOL currentUserSettingWillUpDate;

@property (nonatomic) BOOL leftViewWillAppear;

// 连接秤后初始化需要处理的参数
@property (nonatomic)BOOL smartModeEnable;
@property (nonatomic)int  userIdInScale;

@end
