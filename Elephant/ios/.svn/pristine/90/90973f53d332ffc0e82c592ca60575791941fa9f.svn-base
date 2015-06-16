//
//  Urls.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-10.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Urls.h"

@implementation Urls

@synthesize urlLong = _urlLong;

@synthesize urlShort = _urlShort;

@synthesize type = _type;

@synthesize result = _result;


- (void)dealloc
{
}


/**
 *	从字典中解析Urls数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Urls对象
 */
+ (Urls *)getUrlsFromJsonDic:(NSDictionary *)dic
{
    Urls *aUrl = [[Urls alloc] init];
    aUrl.urlLong = [dic objectForKey:@"url_long"];
    aUrl.urlShort = [dic objectForKey:@"url_short"];
    aUrl.type = [[dic objectForKey:@"type"] intValue];
    aUrl.result = [[dic objectForKey:@"result"] boolValue];
    
    return aUrl;
}

@end
