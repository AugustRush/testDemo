//
//  AQAPIs.h
//  BLEDemo
//
//  Created by Zhanghao on 3/18/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AQMeasuerMode) {
    AQMeasuerModeNormal = 0,    // 普通模式
    AQMeasuerModeAngiocarpy,    // 心血管模式
    AQMeasuerModeKeepIntact     // 保持原样
};

typedef NS_ENUM(NSUInteger, AQPickMode) {
    AQPickModeTurnOn = 0,   // 开启模式
    AQPickModeTurnOff,      // 关闭模式
    AQPickModeKeepIntact    // 保持原样
};

typedef NS_ENUM(NSUInteger, AQUserType) {
    AQUserTypeA = 0,    // 用户A
    AQUserTypeB         // 用户B
};

@interface AQAPIs : NSObject

/**
 *  设置系统时间
 */
+ (NSData *)setSystemTime:(NSDate *)date;

/**
 *  设置持续测量时间段
 *
 *  @param contents  时间段内容数组，例如00140505
 *                   前四位表示起始时间，中间两位表示频率，后两位表示次数
 *  @param userType  当前用户
 */
+ (NSData *)setContinuousMeasureSegmentsWithContents:(NSArray *)contents user:(AQUserType)userType;

/**
 *  设置开机默认模式
 *
 *  @param sound    是否需要提示音，3种模式（开启，关闭，保持原样）分别对应AQPickMode枚举中的3个值
 *  @param userType 选择用户
 *  @param mode     测量模式
 *  @param measure  是否连续测量
 */
+ (NSData *)setDefaultPowerOnModeNeededBeep:(AQPickMode)sound
                                     userName:(AQUserType)userType
                                  measureMode:(AQMeasuerMode)mode
                            continuousMeasure:(AQPickMode)measure;

/**
 *  立刻测量
 */
+ (NSData *)measureImmediately;

/**
 *  停止测量
 */
+ (NSData *)stopMeasuring;

/**
 *  切换用户
 *
 *  @param userType 用户类型
 */
+ (NSData *)switchUser:(AQUserType)userType;

/**
 *  切换提示音
 *
 *  @param mode 切换模式
 */
+ (NSData *)switchBeepMode:(AQPickMode)mode;

/**
 *  关机
 */
+ (NSData *)powerOff;

/**
 *  连续测量
 *
 *  @param mode 切换连续测量模式
 */
+ (NSData *)switchContinuousMeasureMode:(AQPickMode)mode;

/**
 *  获取设备信息
 */
+ (NSData *)getDeviceInfo;

/**
 *  获取系统时间
 */
+ (NSData *)getSystemTime;

/**
 *  获取系统状态
 */
+ (NSData *)getSystemStatus;

/**
 *  获取血压数据
 *
 *  @param start 指定从某一条数据开始
 *  @param end   指定到某一条数据为止
 */
+ (NSData *)getBloodPressureDataWithStartIndex:(NSInteger)start endIndex:(NSInteger)end;

/**
 *  获取指定用户已存储信息的总条数
 */
+ (NSData *)getMessageCountWithUser:(AQUserType)userType;

@end
