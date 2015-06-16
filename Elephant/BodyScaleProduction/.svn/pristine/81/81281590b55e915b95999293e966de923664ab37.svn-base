//
//  FlowManager.m
//  BodyScaleProduction
//
//  Created by Go Salo on 14-6-8.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "FlowManager.h"
#import "InterfaceModel.h"
#import "BTModel.h"

@implementation FlowManager {
    NSMutableArray *_stack;
}

+ (instancetype)sharedInstance {
    
    static FlowManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient           = [[FlowManager alloc] init];
        _sharedClient -> _stack = [NSMutableArray array];
        
        [[NSNotificationCenter defaultCenter] addObserver:_sharedClient selector:@selector(btInitDataFinished) name:BT_DATA_INITAIL_FINISHED object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:_sharedClient selector:@selector(loginSuccess) name:kIMLoginDataOk object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:_sharedClient selector:@selector(loginFailue) name:kIMLoginDataFailure object:nil];
    });
    
    return _sharedClient;
}

- (void)setup {
    [[BTModel sharedInstance] setup];
}

#pragma mark - Getter
- (FlowType)type {
    return [[[_stack lastObject] objectForKey:@"type"] integerValue];
}

- (UserInfoEntity *)userInfo {
    return [[_stack lastObject] objectForKey:@"userInfo"];
}

#pragma mark - Public Method
- (void)pushToFlowWithType:(FlowType)type userInfo:(UserInfoEntity *)userInfo {
    NSDictionary *enterStack = @{@"type": @(type),
                                 @"userInfo": userInfo};
    [_stack addObject:enterStack];
    
    [self updateBluetoothFlow];
}

- (void)transformCurrentStackToType:(FlowType)type userInfo:(UserInfoEntity *)userInfo {
    NSDictionary *enterStack = @{@"type": @(type),
                                 @"userInfo": userInfo};
    [_stack replaceObjectAtIndex:_stack.count - 1 withObject:enterStack];
    
    [self updateBluetoothFlow];
}

- (void)popToFlow {
    [_stack removeLastObject];
    
    if (_stack.count) {
        
    } else {
        
    }
    [self updateBluetoothFlow];
}

#pragma mark - Bluetooth Connecting
- (void)btInitDataFinished {
    // 如果已经是登录状态 连接设备如果不是 则登录之后连接
    
    [self updateBluetoothFlow];
}

- (void)loginSuccess {
    [self updateBluetoothFlow];
}

- (void)loginFailue {
    [self updateBluetoothFlow];
}

#pragma mark - Private Method
- (void)updateBluetoothFlow {
    NSDictionary *topStack = [_stack lastObject];
    FlowType type = [topStack[@"type"] integerValue];
    UserInfoEntity *userInfo = topStack[@"userInfo"];
    
    BOOL isTesting = !([[InterfaceModel sharedInstance] getLoginState] &&
                       [BTModel sharedInstance].peripheralDataPrepareOK &&
                       type == FlowTypeUser);
    if (type == FlowTypeUser) {
        userInfo = [[InterfaceModel sharedInstance] getHostUser];
    }
    [[BTModel sharedInstance] selectUserInScale:userInfo isTesting:isTesting];
}

@end
