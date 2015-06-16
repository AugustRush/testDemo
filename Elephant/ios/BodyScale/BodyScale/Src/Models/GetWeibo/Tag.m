//
//  Tag.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-3.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Tag.h"

@implementation Tag

@synthesize tagId = _tagId;

@synthesize tagName = _tagName;


- (void)dealloc
{
}


/**
 *	从字典中解析Tag数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Tag对象
 */
+ (Tag *)getTagFromJsonDic:(NSDictionary *)dic
{
    Tag *aTag = [[Tag alloc] init];
    aTag.tagName = [dic objectForKey:@"tag"];
    aTag.tagId = [dic objectForKey:@"id"];
    
    return aTag;
}


@end
