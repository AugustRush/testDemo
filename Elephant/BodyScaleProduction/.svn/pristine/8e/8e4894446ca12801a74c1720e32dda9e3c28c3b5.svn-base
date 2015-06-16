//
//  UserDataEntity.h
//  BodyScaleProduction
//
//  Created by Go Salo on 14-3-19.
//  Copyright (c) 2014年 Go Salo. All rights reserved.
//

#import "BaseEntity.h"
#import "PCEntity.h"


typedef NS_ENUM(NSInteger, DataStatus){
    DataStatus_exception    = 0,    //异常
    DataStatus_normal       = 1,    //正常
    DataStatus_default      = 2,    //未检测
};


@interface UserDataEntity : BaseEntity

@property(nonatomic,strong)NSString *UD_ID;             //数据id
@property(nonatomic,strong)NSString *UD_MEMID;          //会员Id
@property(nonatomic,strong)NSString *UD_WEIGHT;         //体重
@property(nonatomic,strong)NSString *UD_BMI;            //BMI

@property(nonatomic,strong)NSString *UD_FAT;            //脂肪率
@property(nonatomic,strong)NSString *UD_SKINFAT;        //皮下脂肪率
@property(nonatomic,strong)NSString *UD_OFFALFAT;       //内脏脂肪率
@property(nonatomic,strong)NSString *UD_MUSCLE;         //肌肉率

@property(nonatomic,strong)NSString *UD_METABOLISM;     //基础代谢率
@property(nonatomic,strong)NSString *UD_WATER;          //水含量
@property(nonatomic,strong)NSString *UD_BONE;           //骨骼重量
@property(nonatomic,strong)NSString *UD_BODYAGE;        //身体年龄

@property(nonatomic,strong)NSString *UD_STATUS;         //状态标志位
@property(nonatomic,strong)NSString *UD_CHECKDATE;      //测量时间
@property(nonatomic,strong)NSString *UD_CREATETIME;     //系统记录时间
@property(nonatomic,strong)NSString *UD_MODIFYTIME;     //修改时间

@property(nonatomic,strong)NSString *UD_devcode;        //体脂仪设备号
@property(nonatomic,strong)NSString *UD_longit;         //经度
@property(nonatomic,strong)NSString *UD_latit;          //纬度
@property(nonatomic,strong)NSString *UD_location;       //体脂仪绑定位置（坑位 0.o） 1-8


@property(nonatomic,strong)NSString *UD_isFriendData;   //是否是好友数据
@property(nonatomic,strong)NSString *UD_userId;         //用户id
@property(nonatomic)int             UD_checkCount;      //日测量次数


@property(nonatomic,strong)NSString *UD_eBMR;           //基础代谢率(欧洲)
@property(nonatomic)DataStatus      UD_dataStatus;      //数据检测状态
@property(nonatomic,strong)NSArray  *UD_pcEntityList;   //体征数据对象列表


@property(nonatomic,strong)NSString *UD_ryFit  ;        //ryFit指数




@end
