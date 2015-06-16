//
//  SystemInfo.h
//  FFLtd
//
//  Created by 两元鱼 on 12-6-19.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//


/*!
 
 @header   SystemInfo
 @abstract 系统信息描述类
 @author   两元鱼
 @version  1.0  2012/6/19 Creation
 */


#define NEW_UUID_KEY  @"BlueBox-uuid"

@interface SystemInfo : NSObject
{
    @private    
    BOOL     isKeyboardShowing_;
}
+ (SystemInfo *)sharedInstance;

/*!system infos*/

/*!系统版本是否小于5.0*/
+ (BOOL)isIosVersionBelow5;

/*!系统版本*/
+ (NSString *)iosVersion;

/*!硬件版本*/
+ (NSString *)platform;

/*!硬件版本名称*/
+ (NSString *)platformString;

/*!系统当前时间 格式：yyyy-MM-dd HH:mm:ss*/
+ (NSString *)systemTimeInfo;


/*!software infos*/

/*!软件版本*/
+ (NSString *)softwareVersion;

/*!键盘是否弹出*/
+ (BOOL)isKeyboardShowing;

/*!是否是iPhone5*/
+ (BOOL)is_iPhone_5;

/*!是否越狱*/
+ (BOOL)isJailBroken;

/*!越狱版本*/
+ (NSString *)jailBreaker;
@end
