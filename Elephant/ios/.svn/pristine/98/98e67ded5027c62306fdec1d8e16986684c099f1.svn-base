//
//  Geo.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-29.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Geo.h"

@implementation Geo

@synthesize ongitude = _ongitude;

@synthesize latitude = _latitude;

@synthesize city = _city;

@synthesize province = _province;

@synthesize cityName = _cityName;

@synthesize provinceName = _provinceName;

@synthesize address = _address;

@synthesize pinyin = _pinyin;

@synthesize more = _more;


- (void)dealloc
{
}


/**
 *	从字典中解析Geo数据
 *
 *	@param	dic	json中的geo字典
 *
 *	@return	组装之后的Geo对象
 */
+ (Geo *)getGeoFromJsonDic:(NSDictionary *)dic
{
    Geo *geo = [[Geo alloc] init];
    NSArray *array = [dic objectForKey:@"coordinates"];
    geo.ongitude = [array objectAtIndex:0];
    geo.latitude = [array objectAtIndex:1];    
    return geo;
}

@end


