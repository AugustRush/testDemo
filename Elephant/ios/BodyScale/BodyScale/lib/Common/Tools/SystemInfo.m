//
//  SystemInfo.m
//  FFLtd
//
//  Created by 两元鱼 on 12-6-19.
//  Copyright (c) 2012年 FFLtd. All rights reserved.
//

#import "SystemInfo.h"
#import "AppDelegate.h"

#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>

static SystemInfo *instance = nil;

@interface SystemInfo()



@end

/*********************************************************************/

@implementation SystemInfo

#pragma mark -
#pragma mark notifications
- (id)init {
    self = [super init];
    if (self) {
    
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:) 
                                                     name:@"UIKeyboardDidShowNotification" 
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:) 
                                                     name:@"UIKeyboardWillHideNotification" 
                                                   object:nil];
    }
    return self;
}

- (void)postDismissCleanup {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"UIKeyboardDidShowNotification" 
                                                  object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:@"UIKeyboardWillHideNotification"
                                                  object:nil];
	
}

- (void)keyboardDidShow:(NSNotification*)notification {
	
	isKeyboardShowing_ = YES;
}

- (void)keyboardWillHide:(NSNotification*)notification {
	
	
	isKeyboardShowing_ = NO;
}

+ (BOOL)isKeyboardShowing
{
    return [SystemInfo sharedInstance]->isKeyboardShowing_;
}

#pragma mark -
#pragma mark single methods

+ (SystemInfo *)sharedInstance
{
    @synchronized(self){
        if (instance == nil) {
            instance = [[SystemInfo alloc] init];
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)dealloc {
    [self postDismissCleanup];
    
}

+ (BOOL)isIosVersionBelow5
{
    if ([[SystemInfo iosVersion] floatValue] < 5.0) {
        return YES;
    }
    return NO;
}

+ (NSString *)iosVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)platform
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
}

+ (NSString *)platformString
{
    NSString *platform = [SystemInfo platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone1G GSM";
    
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone3G GSM";
    
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone3GS GSM";
    
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone4 GSM";
    
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone4 CDMA";
    
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone4S";
    
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone5";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1 WiFi";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2 WiFi";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2 GSM";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2 CDMAV";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2 CDMAS";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini WiFi";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3 WiFi";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3 GSM";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3 CDMA";
    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    return platform;
    
}

//获取系统当前时间
+ (NSString *)systemTimeInfo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateString;
}

#pragma mark -
#pragma mark software version

+ (NSString *)softwareVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", version];
}

+ (BOOL)is_iPhone_5
{
    if ([UIScreen mainScreen].bounds.size.height == 568.0f)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark -
#pragma mark jailbreaker

static const char * __jb_app = NULL;

+ (BOOL)isJailBroken
{
	static const char * __jb_apps[] =
	{
		"/Application/Cydia.app",
		"/Application/limera1n.app",
		"/Application/greenpois0n.app",
		"/Application/blackra1n.app",
		"/Application/blacksn0w.app",
		"/Application/redsn0w.app",
		NULL
	};
    
	__jb_app = NULL;
    
	// method 1
    for ( int i = 0; __jb_apps[i]; ++i )
    {
        if ( [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:__jb_apps[i]]] )
        {
			__jb_app = __jb_apps[i];
			return YES;
        }
    }
	
    // method 2
	if ( [[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"] )
	{
		return YES;
	}
	
	// method 3
	if ( 0 == system("ls") )
	{
		return YES;
	}
	
    return NO;
}

+ (NSString *)jailBreaker
{
	if ( __jb_app )
	{
		return [NSString stringWithUTF8String:__jb_app];
	}
	else
	{
		return @"";
	}
}


@end
