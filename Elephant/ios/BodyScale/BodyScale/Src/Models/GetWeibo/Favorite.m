//
//  Favorite.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-3.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Favorite.h"
#import "Status.h"
#import "Tag.h"

@implementation Favorite

@synthesize status = _status;

@synthesize tagArray = _tagArray;

@synthesize favoritedTime = _favoritedTime;


- (void)dealloc
{
}


/**
 *	从字典中解析Favorite数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Favorite对象
 */
+ (Favorite *)getFavoriteFromJsonDic:(NSDictionary *)dic
{
    Favorite *aFavorite = [[Favorite alloc] init];
    aFavorite.status = [Status getStatusFromJsonDic:[dic objectForKey:@"status"]];
    NSMutableArray *tagArray = [dic objectForKey:@"tags"];
    if ([tagArray count] != 0) {
        for (NSDictionary *tagDic in tagArray) {
            Tag *aTag = [Tag getTagFromJsonDic:tagDic];
            [aFavorite.tagArray addObject:aTag];
        }
    }
    aFavorite.favoritedTime = [dic objectForKey:@"favorited_time"];

    return aFavorite;
}


@end
