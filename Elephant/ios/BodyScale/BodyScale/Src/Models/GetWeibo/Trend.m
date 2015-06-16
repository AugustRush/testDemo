//
//  Trend.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-5.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Trend.h"

@implementation Trend

@synthesize name = _name;

@synthesize query = _query;

@synthesize amount = _amount;

@synthesize delta = _delta;


- (void)dealloc
{
}


/**
 *	从字典中解析表情Trend话题数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Trend话题对象
 */
+ (Trend *)getTrendFromJsonDic:(NSDictionary *)dic
{
    Trend *aTrend = [[Trend alloc] init];
    aTrend.name = [dic objectForKey:@"name"];
    aTrend.query = [dic objectForKey:@"query"];
    aTrend.amount = [dic objectForKey:@"amount"];
    aTrend.delta = [dic objectForKey:@"delta"];
    
    return aTrend;
}

@end


