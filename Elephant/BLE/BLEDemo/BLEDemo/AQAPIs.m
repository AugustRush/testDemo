//
//  AQAPIs.m
//  BLEDemo
//
//  Created by Zhanghao on 3/18/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import "AQAPIs.h"

// 指令群
#define SET_INSTRUCTION                     @"S"
#define OPERATE_INSTRUCTION                 @"O"
#define GET_INSTRUCTION                     @"G"

// 具体指令
#define SET_SYSTEM_TIME                     @"T"
#define SET_CONTINUOUS_MEASURE_TIME         @"N"
#define SET_DEFAULT_TURN_ON_MODE            @"M"
#define OPERATE_MEASURE_RIGHT_NOW           @"I"
#define OPERATE_STOP_MEASURING              @"S"
#define OPERATE_SWITCH_USER                 @"U"
#define OPERATE_SWITCH_HINT_SOUND           @"V"
#define OPERATE_TURN_OFF                    @"F"
#define OPERATE_CONTINUOUS_MEASURE          @"N"
#define GET_DEVICE_INFOMATION               @"D"
#define GET_SYSTEM_TIME                     @"T"
#define GET_SYSTEM_STATUS                   @"S"
#define GET_BLOOD_PRESSURE_DATA             @"N"
#define GET_STORE_LOCATION                  @"F"

// 其他指令
#define TURN_ON                             @"O"
#define TURN_OFF                            @"F"
#define KEEP_INTACT                         @"N"
#define NORMAL_MODE                         @"A"
#define ANGIOCARPY_MODE                     @"B"
#define MAX_SIZE                            999

#ifndef __AQ__HAS__SUFFIX
#define __AQ__HAS__SUFFIX                   1
#endif

@implementation AQAPIs

#pragma mark - Set instruction

+ (NSData *)setSystemTime:(NSDate *)date {
    NSString *time = dateToString(date, @"yyyyMMddHHmmss");
    NSString *content = [time substringWithRange:NSMakeRange(2, [time length] - 4)];
    return synthesiseInstruction(SET_INSTRUCTION, SET_SYSTEM_TIME, content);
}

+ (NSData *)setContinuousMeasureSegmentsWithContents:(NSArray *)contents user:(AQUserType)useType {
    NSString *c = nil;
    NSString *user = userNameByType(useType);
    for (NSString *content in contents) {
        if (!c) {
            c = content;
        } else {
            c = [c stringByAppendingString:content];
        }
        c = [c stringByAppendingString:user];
    }
    c = [IntString((int)[contents count]) stringByAppendingString:c];
    return synthesiseInstruction(SET_INSTRUCTION, SET_CONTINUOUS_MEASURE_TIME, c);
}

+ (NSData *)setDefaultPowerOnModeNeededBeep:(AQPickMode)sound userName:(AQUserType)userType measureMode:(AQMeasuerMode)mode continuousMeasure:(AQPickMode)measure {
    NSString *hintSound = pickModeString(sound);
    NSString *defaultUser = userNameByType(userType);
    NSString *measureMode = measureModeString(mode);
    NSString *continuousMeasure = pickModeString(measure);
    
    if (!hintSound || !defaultUser || !measureMode || !continuousMeasure) {
        return nil;
    }
    
    NSString *content = [NSString stringWithFormat:@"%@%@%@%@", hintSound, defaultUser, measureMode, continuousMeasure];
    return synthesiseInstruction(SET_INSTRUCTION, SET_DEFAULT_TURN_ON_MODE, content);
}

#pragma mark - Operate instruction

+ (NSData *)measureImmediately {
    return synthesiseInstruction(OPERATE_INSTRUCTION, OPERATE_MEASURE_RIGHT_NOW, nil);
}

+ (NSData *)stopMeasuring {
    return synthesiseInstruction(OPERATE_INSTRUCTION, OPERATE_STOP_MEASURING, nil);
}

+ (NSData *)switchUser:(AQUserType)userType {
    return synthesiseInstruction(OPERATE_INSTRUCTION, OPERATE_SWITCH_USER, userNameByType(userType));
}

+ (NSData *)switchBeepMode:(AQPickMode)mode {
    return synthesiseInstruction(OPERATE_INSTRUCTION, OPERATE_SWITCH_HINT_SOUND, pickModeString(mode));
}

+ (NSData *)powerOff {
    return synthesiseInstruction(OPERATE_INSTRUCTION, OPERATE_TURN_OFF, nil);
}

+ (NSData *)switchContinuousMeasureMode:(AQPickMode)mode {
    return synthesiseInstruction(OPERATE_INSTRUCTION, OPERATE_CONTINUOUS_MEASURE, pickModeString(mode));
}

#pragma mark - Get instruction

+ (NSData *)getDeviceInfo {
    return synthesiseInstruction(GET_INSTRUCTION, GET_DEVICE_INFOMATION, nil);
}

+ (NSData *)getSystemTime {
    return synthesiseInstruction(GET_INSTRUCTION, GET_SYSTEM_TIME, nil);
}

+ (NSData *)getSystemStatus {
    return synthesiseInstruction(GET_INSTRUCTION, GET_SYSTEM_STATUS, nil);
}

+ (NSData *)getBloodPressureDataWithStartIndex:(NSInteger)start endIndex:(NSInteger)end {
    if (start < 0 || end < 0 || start > MAX_SIZE || end > MAX_SIZE) {
        return nil;
    }
    
    NSString *startString = [NSString stringWithFormat:@"%03d", (int)start];
    NSString *endString = [NSString stringWithFormat:@"%03d", (int)end];
    NSString *content = [NSString stringWithFormat:@"S=%@Q=%@", startString, endString];
    
    return synthesiseInstruction(GET_INSTRUCTION, GET_BLOOD_PRESSURE_DATA, content);
}

+ (NSData *)getMessageCountWithUser:(AQUserType)userType {
    return synthesiseInstruction(GET_INSTRUCTION, GET_STORE_LOCATION, userNameByType(userType));
}


#pragma mark - Helper

// 组合指令 指令群+具体指令+指令内容+后缀'\0'
NSData *synthesiseInstruction(NSString *group, NSString *detail, NSString *content) {
    if (!group || !detail) {
        return nil;
    }
    
    NSString *instruction = [group stringByAppendingString:detail];
    
    if (content) {
        instruction = [instruction stringByAppendingString:content];
    }
#if __AQ__HAS__SUFFIX
    instruction = [instruction stringByAppendingString:AQ_EOF];
#endif
    return [instruction dataUsingEncoding:NSUTF8StringEncoding];
}

NSString *pickModeString(AQPickMode mode) {
    NSString *modeString = nil;
    switch (mode) {
        case AQPickModeTurnOn:
            modeString = TURN_ON;
            break;
        case AQPickModeTurnOff:
            modeString = TURN_OFF;
            break;
        case AQPickModeKeepIntact:
            modeString = KEEP_INTACT;
            break;
        default:
            break;
    }
    return modeString;
}

NSString *measureModeString(AQMeasuerMode mode) {
    NSString *modeString = nil;
    switch (mode) {
        case AQMeasuerModeNormal:
            modeString = NORMAL_MODE;
            break;
        case AQMeasuerModeAngiocarpy:
            modeString = ANGIOCARPY_MODE;
            break;
        case AQMeasuerModeKeepIntact:
            modeString = KEEP_INTACT;
            break;
        default:
            break;
    }
    return modeString;
}

NSString *userNameByType(AQUserType type) {
    NSString *userName = nil;
    switch (type) {
        case AQUserTypeA:
            userName = @"A";
            break;
        case AQUserTypeB:
            userName = @"B";
            break;
        default:
            break;
    }
    return userName;
}

@end
