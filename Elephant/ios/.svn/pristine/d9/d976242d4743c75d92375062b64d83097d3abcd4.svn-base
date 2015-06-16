//
//  Tag.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-3.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tag : NSObject
{
    NSString    *_tagId;
    
    NSString    *_tagName;

}

/**
 *	收藏的微博所属的标签ID
 */
@property (nonatomic, copy)NSString *tagId;


/**
 *	收藏的微博所属的标签名
 */
@property (nonatomic, copy)NSString *tagName;


/**
 *	从字典中解析Tag数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Tag对象
 */
+ (Tag *)getTagFromJsonDic:(NSDictionary *)dic;


@end
