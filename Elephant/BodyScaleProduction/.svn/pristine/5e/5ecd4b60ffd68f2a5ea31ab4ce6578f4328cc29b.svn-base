//
//  ScaleBllEncoder.m
//  BodyScale
//
//  Created by Go Salo on 14-2-19.
//  Copyright (c) 2014年 于菲. All rights reserved.
//

#import "ScaleBllEncoder.h"

@implementation ScaleBllEncoder

#pragma mark - Public Method
/**
 @brief 将当前时间同步给秤
 */
- (NSData *)dataEncordeUpdateTime {
    NSDate *orgDate;
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    orgDate=[dateFormat dateFromString:@"2000-01-01 00:00:00"];
    NSTimeInterval time=[nowDate timeIntervalSinceDate:orgDate];
    int sec=(int)time;
    //int sec=442940667;
    
    struct _SCALE_COMMAND_UPDATETIME_FORMAT cmd;
    
    cmd.h0 = 0xFA;
    cmd.h1 = 0xF8;
    
    memset(cmd.utime, 0x00, 4);
    memcpy(cmd.utime, [[NSData dataWithBytes:&sec length:4] bytes], 4);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:6];
    
    return data;
}

/**
 @brief 检查用户是否存在
 @pno 用户编号
 */
- (NSData *)dataEncordeExistUser:(int)pno {
    /*
     struct _SCALE_COMMAND_EXISTUSER_FORMAT cmd;
     
     cmd.command = SCALE_COMMAND_EXISTUSER;
     
     memset(cmd.userno, 0x00, 1);
     int dataLen = ([pno length] > 1) ? 1 : [pno length];
     memcpy(cmd.userno, [pno UTF8String], dataLen);
     
     NSData *data = [[NSData alloc]initWithBytes:&cmd length:2];
     [sensor write:sensor.activePeripheral data:data];
     */
    
    self.msDotype = [NSString stringWithFormat:@"%d",SAExistUser];
    
    struct _SCALE_COMMAND_EXISTUSER_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_EXISTUSER;
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1] bytes], 1);
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:2];
    
    return data;
}

/**
 @brief 创建新用户
 @param pno 用户编号
 @param height 身高
 @param age 体重
 @param gender 性别
 */
- (NSData *)dataEncordeNewUser:(int)pno height:(int)height age:(int)age gender:(int)gender {
    self.msDotype = [NSString stringWithFormat:@"%d",SANewUser];
    
    int heightN = [self transformToScaleHeight:height];
    
    struct _SCALE_COMMAND_NEWUSER_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_NEWUSER;
    
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1]bytes], 1);
    
    memset(cmd.height, 0x00, 1);
    memcpy(cmd.height, [[NSData dataWithBytes:&heightN length:1] bytes], 1);
    
    memset(cmd.age, 0x00, 1);
    memcpy(cmd.age, [[NSData dataWithBytes:&age length:1]bytes], 1);
    
    memset(cmd.gender, 0x00, 1);
    memcpy(cmd.gender, [[NSData dataWithBytes:&gender length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:5];
    
    return data;
}

/**
 @brief 删除用户
 @pno 用户编号
 */
- (NSData *)dataEncordeDeleteUser:(int)pno {
    self.msDotype = [NSString stringWithFormat:@"%d", SADelUser];
    
    struct _SCALE_COMMAND_DELETEUSER_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_DELETEUSER;
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1] bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:2];
    
    return data;
}

/**
 @brief 更新用户信息
 @param pno 用户编号
 @param height 身高
 @param age 体重
 @param gender 性别
 */
- (NSData *)dataEncordeUpdateUser:(int)pno height:(int)height age:(int)age gender:(int)gender {
    self.msDotype = [NSString stringWithFormat:@"%d",SAUpdateUser];
    
    struct _SCALE_COMMAND_UPDATEUSER_FORMAT cmd;
    
    int heightH = [self transformToScaleHeight:height];
    
    cmd.command = SCALE_COMMAND_UPDATEUSER;
    
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1]bytes], 1);
    
    memset(cmd.height, 0x00, 1);
    memcpy(cmd.height, [[NSData dataWithBytes:&heightH length:1] bytes], 1);
    
    memset(cmd.age, 0x00, 1);
    memcpy(cmd.age, [[NSData dataWithBytes:&age length:1]bytes], 1);
    
    memset(cmd.gender, 0x00, 1);
    memcpy(cmd.gender, [[NSData dataWithBytes:&gender length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:5];
    
    return data;
}

/**
 @brief 获取单个用户信息
 @pno 用户编号
 */
- (NSData *)dataEncordeGetSimUser:(int)pno {
    self.msDotype = [NSString stringWithFormat:@"%d",SAGetSimUser];
    
    struct _SCALE_COMMAND_GETSIMUSER_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_GETSIMUSER;
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1] bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:2];
    
    return data;
}

/**
 @brief 获取所有用户信息
 */
- (NSData *)dataEncordeGetAllUser {
    self.msDotype = [NSString stringWithFormat:@"%d", SAGetAllUser];
    
    struct _SCALE_COMMAND_GETALLUSER_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_GETALLUSER;
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:1];
    
    return data;
}

/**
 @brief 获取所有用户信息-接收包后的反馈
 @param pkgnum 总包数
 @param pkgid 当前包ID
 */
- (NSData *)dataEncordeGetAllUserConfirm:(int)pkgnum pkgid:(int)pkgid {
    self.msDotype = [NSString stringWithFormat:@"%d",SAGetAllUserback];
    
    struct _SCALE_COMMAND_GETALLUSER_BACK_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_GETALLUSER_BACK;
    cmd.backcmd = 0xB5;
    
    memset(cmd.pkgnum, 0x00, 1);
    memcpy(cmd.pkgnum, [[NSData dataWithBytes:&pkgnum length:1]bytes], 1);
    
    memset(cmd.pkgid, 0x00, 1);
    memcpy(cmd.pkgid, [[NSData dataWithBytes:&pkgid length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:4];
    
    return data;
}

/**
 @brief 用户称重
 @param pno 用户编号
 @param height 身高
 @param age 体重
 @param gender 性别
 */
- (NSData *)dataEncordeUserScale:(int)pno height:(int)height age:(int)age gender:(int)gender {
    self.msDotype = [NSString stringWithFormat:@"%d", SAUserScale];
    
    struct _SCALE_COMMAND_USERSCALE_FORMAT cmd;
    
    int heightH = [self transformToScaleHeight:height];
    
    cmd.command = SCALE_COMMAND_USERSCALE;
    
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1]bytes], 1);
    
    memset(cmd.height, 0x00, 1);
    memcpy(cmd.height, [[NSData dataWithBytes:&heightH length:1] bytes], 1);
    
    memset(cmd.age, 0x00, 1);
    memcpy(cmd.age, [[NSData dataWithBytes:&age length:1]bytes], 1);
    
    memset(cmd.gender, 0x00, 1);
    memcpy(cmd.gender, [[NSData dataWithBytes:&gender length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:5];
    
    return data;
}

/**
 @brief 获取用户称重-接收包后的反馈
 @param pkgnum 总包数
 @param pkgid 当前包ID
 */
- (NSData *)dataEncordeGetUserScaleConfirm:(int)pkgnum pkgid:(int)pkgid {
    self.msDotype = [NSString stringWithFormat:@"%d",SAUserScaleback];
    
    struct _SCALE_COMMAND_USERSCALE_BACK_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_USERSCALE_BACK;
    cmd.backcmd = 0xD0;
    
    memset(cmd.pkgnum, 0x00, 1);
    memcpy(cmd.pkgnum, [[NSData dataWithBytes:&pkgnum length:1]bytes], 1);
    
    memset(cmd.pkgid, 0x00, 1);
    memcpy(cmd.pkgid, [[NSData dataWithBytes:&pkgid length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:4];
    
    return data;
}

/**
 @brief 读取用户称重
 @param pno 用户编号
 */
- (NSData *)dataEncordeReadScaleData:(int)pno {
    self.msDotype = [NSString stringWithFormat:@"%d", SAReadScaledata];
    
    struct _SCALE_COMMAND_READSCALEDATA_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_READSCALEDATA;
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1] bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:2];
    
    return data;
}

/**
 @brief 读取用户称重-接收包后的反馈
 @param pkgnum 总包数
 @param pkgid 当前包ID
 */
- (NSData *)dataEncordeGetReadScaleDataConfirm:(int)pkgnum pkgid:(int)pkgid {
    self.msDotype = [NSString stringWithFormat:@"%d", SAReadScaledataback];
    
    struct _SCALE_COMMAND_READSCALEDATA_BACK_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_READSCALEDATA_BACK;
    cmd.backcmd = 0xD1;
    
    memset(cmd.pkgnum, 0x00, 1);
    memcpy(cmd.pkgnum, [[NSData dataWithBytes:&pkgnum length:1]bytes], 1);
    
    memset(cmd.pkgid, 0x00, 1);
    memcpy(cmd.pkgid, [[NSData dataWithBytes:&pkgid length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:4];
    
    return data;
}

/**
 @brief 删除用户测量数据
 @param pno 用户编号
 */
- (NSData *)dataEncordeDeleteScaleData:(int)pno {
    self.msDotype = [NSString stringWithFormat:@"%d", SADeleteScaledata];
    
    struct _SCALE_COMMAND_DELETESCALEDATA_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_DELETESCALEDATA;
    memset(cmd.userno, 0x00, 1);
    memcpy(cmd.userno, [[NSData dataWithBytes:&pno length:1] bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:2];
    
    return data;
}

/**
 @brief 实时重量传输
 @param locked 0:重量锁定;1:重量未锁定;
 */
- (NSData *)dataEncordeRealtimeWeight:(int)locked {
    self.msDotype = [NSString stringWithFormat:@"%d", SARtimeWeightlocked];
    
    struct _SCALE_COMMAND_RTIMEWEIGHT_BACK_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_RTIMEWEIGHT_BACK;
    cmd.backcmd = 0xD2;
    
    memset(cmd.weightlock, 0x00, 1);
    memcpy(cmd.weightlock, [[NSData dataWithBytes:&locked length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:3];
    
    return data;
}

/**
 @brief 设置秤体信息
 @param weightrange 重量识别范围
 @param elecrange 电阻识别范围
 */
- (NSData *)dataEncordeScaleSetting:(int)weightrange elecrange:(int)elecrange {
    self.msDotype = [NSString stringWithFormat:@"%d", SAScaleSetting];
    
    struct _SCALE_COMMAND_SCALESETTING_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_SCALESETTING;
    
    memset(cmd.weightrange, 0x00, 1);
    memcpy(cmd.weightrange, [[NSData dataWithBytes:&weightrange length:1]bytes], 1);
    
    memset(cmd.elecrange, 0x00, 1);
    memcpy(cmd.elecrange, [[NSData dataWithBytes:&elecrange length:1]bytes], 1);
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:3];
    
    return data;
}

/**
 @brief 客人模式进入
 */
- (NSData *)dataEncordeCustomtype {
    self.msDotype = [NSString stringWithFormat:@"%d", SACustomtype];
    
    struct _SCALE_COMMAND_CUSTOMTYPE_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_CUSTOMTYPE;
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:1];
    
    return data;
}

/**
 @brief 客人模式退出
 */
- (NSData *)dataEncordeQuitcustomtype {
    self.msDotype = [NSString stringWithFormat:@"%d", SAQuitcustomtype];
    
    struct _SCALE_COMMAND_QUITCUSTOMTYPE_FORMAT cmd;
    
    cmd.command = SCALE_COMMAND_QUITCUSTOMTYPE;
    
    NSData *data = [[NSData alloc]initWithBytes:&cmd length:1];
    
    return data;
}

#pragma mark - Private Method
// 身高数据转换秤那边身高的计算方法有点改动
/**********************************************
 *   APP ==> 秤传 N ＝（身高cm*10-1000）/ 5
 *   秤 ==> app  H（cm）=（N*5+1000）/ 10
 *   身高的范围是100-220cm
 **********************************************/
- (int)transformToScaleHeight:(int)height {
    return (height * 10 - 1000) / 5;
}

@end
