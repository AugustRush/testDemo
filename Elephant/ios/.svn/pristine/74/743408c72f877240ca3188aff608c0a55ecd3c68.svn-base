//
//  Trend.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-5.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trend : NSObject
{
    NSString *_name;
    
    NSString *_query;
    
    NSString *_amount;
    
    NSString *_delta;
    
}

/**
 *	话题名称
 */
@property (nonatomic, copy)NSString *name;



@property (nonatomic, copy)NSString *query;



@property (nonatomic, copy)NSString *amount;



@property (nonatomic, copy)NSString *delta;



/**
 *	从字典中解析表情Trend话题数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Trend话题对象
 */
+ (Trend *)getTrendFromJsonDic:(NSDictionary *)dic;

@end


