//
//  Favorite.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-3.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@interface Favorite : NSObject
{
    Status              *_status;
    
    NSMutableArray      *_tagArray;
    
    NSString            *_favoritedTime;
}


/**
 *	收藏的微博
 */
@property (nonatomic, retain)Status *status;


/**
 *	收藏的微博所属的标签ID
 */
@property (nonatomic, retain)NSMutableArray *tagArray;

/**
 *	收藏的时间
 */
@property (nonatomic, copy)NSString *favoritedTime;



/**
 *	从字典中解析Favorite数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Favorite对象
 */
+ (Favorite *)getFavoriteFromJsonDic:(NSDictionary *)dic;


@end
