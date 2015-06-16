//
//  AQTrendingViewController.h
//  BdoyScaleDemo
//
//  Created by Zhanghao on 5/14/14.
//  Copyright (c) 2014 Zhanghao. All rights reserved.
//

#import "AQBaseViewController.h"

typedef NS_ENUM(NSUInteger, AQOptionType) {
    AQOptionTypeRyFitIndex,                 // RyFit指数
    AQOptionTypeWeight,                     // 体重
    AQOptionTypeBMI,                        // BMI
    AQOptionTypeBodyFatRate,                // 体脂率
    AQOptionTypeWaterContent,               // 水含量
    AQOptionTypeMuscleRate,                 // 肌肉比例
    AQOptionTypeBoneWeight,                 // 骨骼重量
    AQOptionTypeBasalMetabolismAsian,       // 基础代谢（亚标）
    AQOptionTypeBasalMetabolismEurope,      // 基础代谢（欧标）
    AQOptionTypeSubcutaneous,               // 皮下脂肪
    AQOptionTypeInternalOrgans,             // 内脏脂肪
    AQOptionTypeBodyAge,                    // 身体年龄
};

typedef NS_ENUM(NSUInteger, AQDateType) {
    AQDateTypeDay,
    AQDateTypeWeek,
    AQDateTypeMonth,
    AQDateTypeYear
};

@interface AQTrendingViewController : AQBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
          initialType:(AQOptionType)optionType
             dateType:(AQDateType)dateType
             initDate:(NSDate *)date;

@end
