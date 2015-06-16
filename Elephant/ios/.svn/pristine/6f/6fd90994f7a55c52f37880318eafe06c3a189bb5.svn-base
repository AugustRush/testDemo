//
//  Geo.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-29.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Geo : NSObject
{
    NSString    *_ongitude;
    
    NSString    *_latitude;
    
    NSString    *_city;
    
    NSString    *_province;
    
    NSString    *_cityName;
    
    NSString    *_provinceName;
    
    NSString    *_address;
    
    NSString    *_pinyin;
    
    NSString    *_more;
    
}

/**
 *	经度坐标
 */
@property (nonatomic, copy)NSString *ongitude;


/**
 *	维度坐标
 */
@property (nonatomic, copy)NSString *latitude;


/**
 *	所在城市的城市代码
 */
@property (nonatomic, copy)NSString *city;


/**
 *	所在省份的省份代码
 */
@property (nonatomic, copy)NSString *province;


/**
 *	所在城市的城市名称
 */
@property (nonatomic, copy)NSString *cityName;


/**
 *	所在省份的省份名称
 */
@property (nonatomic, copy)NSString *provinceName;


/**
 *	所在的实际地址，可以为空
 */
@property (nonatomic, copy)NSString *address;


/**
 *	地址的汉语拼音，不是所有情况都会返回该字段
 */
@property (nonatomic, copy)NSString *pinyin;


/**
 *	更多信息，不是所有情况都会返回该字段
 */
@property (nonatomic, copy)NSString *more;


/**
 *	从字典中解析Geo数据
 *
 *	@param	dic	json中的geo字典
 *
 *	@return	组装之后的Geo对象
 */
+ (Geo *)getGeoFromJsonDic:(NSDictionary *)dic;


@end
	