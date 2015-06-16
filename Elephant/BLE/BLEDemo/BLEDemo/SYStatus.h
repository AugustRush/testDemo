//
//  SYStatus.h
//  BLEDemo
//
//  Created by Zhanghao on 3/21/14.
//  Copyright (c) 2014 刘平伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AQAPIs;

@interface SYStatus : NSObject

@property (nonatomic, copy) NSString *currentUser; // 当前用户
@property (nonatomic, copy) NSString *defaultUser; // 开机用户

@property (nonatomic, copy) NSString *currentMeasureMode; // 当前模式
@property (nonatomic, copy) NSString *defaultMeasureMode; // 当前模式

@property (nonatomic, assign) NSUInteger poweLevel; // 电量

@property (nonatomic, assign) BOOL currentBeepMode; // 当前提示音
@property (nonatomic, assign) BOOL defaultBeepMode; // 开机提示音

@property (nonatomic, assign) BOOL currentContinuousMeasure; // 当前连续测量
@property (nonatomic, assign) BOOL defaultContinuousMeasure; // 开机连续测量

- (instancetype)initWithResponse:(NSString *)response;

@end
