//
//  FlowManager.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-8.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FlowType) {
    FlowTypeRegister,
    FlowTypeGuest,
    FlowTypeUser,
    FlowTypeJDRegister,
    FlowTypeAddUser
};

@interface FlowManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly)     FlowType        type;
@property (nonatomic, readonly)     UserInfoEntity  *userInfo;

- (void)setup;
- (void)pushToFlowWithType:(FlowType)type userInfo:(UserInfoEntity *)userInfo;
- (void)transformCurrentStackToType:(FlowType)type userInfo:(UserInfoEntity *)userInfo;
- (void)popToFlow;

@end
