//
//  Urls.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-10.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Urls : NSObject
{
    NSString    *_urlShort;
    
    NSString    *_urlLong;
    
    int         _type;
    
    BOOL        _result;
}

/**
 *	短链接
 */
@property (nonatomic, copy)NSString *urlShort;


/**
 *	原始长链接
 */
@property (nonatomic, copy)NSString *urlLong;


/**
 *	链接的类型，0：普通网页、1：视频、2：音乐、3：活动、5、投票
 */
@property (nonatomic, assign)int type;


/**
 *	短链的可用状态，true：可用、false：不可用。
 */
@property (nonatomic, assign)BOOL result;


/**
 *	从字典中解析Urls数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Urls对象
 */
+ (Urls *)getUrlsFromJsonDic:(NSDictionary *)dic;


@end





