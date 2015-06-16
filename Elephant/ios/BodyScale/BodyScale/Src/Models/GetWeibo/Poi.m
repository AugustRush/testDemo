//
//  Poi.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-11.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Poi.h"

@implementation Poi

@synthesize poiId = _poiId;

@synthesize title = _title;

@synthesize address = _address;

@synthesize lon = _lon;

@synthesize lat = _lat;

@synthesize category = _category;

@synthesize city = _city;

@synthesize province = _province;

@synthesize country = _country;

@synthesize url = _url;

@synthesize phone = _phone;

@synthesize postCode = _postCode;

@synthesize weiboId = _weiboId;

@synthesize categorys = _categorys;

@synthesize categoryName = _categoryName;

@synthesize icon = _icon;

@synthesize checkinNum = _checkinNum;

@synthesize checkinUserNum = _checkinUserNum;

@synthesize tipNum = _tipNum;

@synthesize photoNum = _photoNum;

@synthesize todoNum = _todoNum;

@synthesize distance = _distance;


- (void)dealloc
{
}

/**
 *	从字典中解析Poi数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Poi对象
 */
+ (Poi *)getPoiFromJsonDic:(NSDictionary *)dic
{
    Poi *aPoi = [[Poi alloc] init];
    aPoi.poiId = [dic objectForKey:@"poiid"];
    aPoi.title = [dic objectForKey:@"title"];
    aPoi.address = [dic objectForKey:@"address"];
    aPoi.lon = [dic objectForKey:@"lon"];
    aPoi.lat = [dic objectForKey:@"lat"];
    aPoi.category = [dic objectForKey:@"category"];
    aPoi.city = [dic objectForKey:@"city"];
    aPoi.province = [dic objectForKey:@"province"];
    aPoi.country = [dic objectForKey:@"country"];
    aPoi.url = [dic objectForKey:@"url"];
    aPoi.phone = [dic objectForKey:@"phone"];
    aPoi.postCode = [dic objectForKey:@"postcode"];
    aPoi.weiboId = [dic objectForKey:@"weibo_id"];
    aPoi.categorys = [dic objectForKey:@"categorys"];
    aPoi.categoryName = [dic objectForKey:@"category_name"];
    aPoi.icon = [dic objectForKey:@"icon"];
    aPoi.checkinNum = [[dic objectForKey:@"checkin_num"] intValue];
    aPoi.checkinUserNum = [[dic objectForKey:@"checkin_user_num"] intValue];
    aPoi.tipNum = [[dic objectForKey:@"tip_num"] intValue];
    aPoi.photoNum = [[dic objectForKey:@"photo_num"] intValue];
    aPoi.todoNum = [[dic objectForKey:@"todo_num"] intValue];
    aPoi.distance = [[dic objectForKey:@"distance"] intValue];
    
    return aPoi;
}

@end

