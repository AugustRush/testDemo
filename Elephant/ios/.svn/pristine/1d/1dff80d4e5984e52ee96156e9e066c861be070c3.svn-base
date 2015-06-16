//
//  UserInfoManager.m
//  BodyScale
//
//  Created by lyywhg on 15/4/26.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "UserInfoManager.h"

static UserInfoManager *_instance;

@implementation UserInfoManager

+(id)allocWithZone:(struct _NSZone *)zone
{
    //调用dispatch_once保证在多线程中也只被实例化一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UserInfoManager alloc] init];
    });
    return _instance;
}
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}


- (NSMutableArray *)userLoginArray
{
    if (!_userLoginArray)
    {
        _userLoginArray = [[NSMutableArray alloc] init];
    }
    return _userLoginArray;
}
- (NSMutableDictionary *)userLoginDict
{
    if (!_userLoginDict)
    {
        _userLoginDict = [[NSMutableDictionary alloc] init];
    }
    return _userLoginDict;
}

@end
