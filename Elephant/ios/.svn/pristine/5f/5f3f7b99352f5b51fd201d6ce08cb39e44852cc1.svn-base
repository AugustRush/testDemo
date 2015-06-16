//
//  App.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-6.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "App.h"

@implementation App

@synthesize appName = _appName;

@synthesize membersCount = _membersCount;


- (void)dealloc
{
}


/**
 *	从字典中解析表情App数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的App对象
 */
+ (App *)getAppFromJsonDic:(NSDictionary *)dic
{
    App *aApp = [[App alloc] init];
    aApp.appName = [self unicodeString:[dic objectForKey:@"apps_name"]];
    aApp.membersCount = [self unicodeString:[dic objectForKey:@"members_count"]];

    return aApp;
}

+ (NSString *)unicodeString:(NSString *)str1
{
    NSData *data = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str2 = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    return str2;
}

@end
