//
//  Status.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-28.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Status.h"
#import "User.h"
#import "Geo.h"

@implementation Status

@synthesize createdAt = _createdAt;

@synthesize statusId = _statusId;

@synthesize statusMId = _statusMId;

@synthesize text = _text;

@synthesize source = _source;

@synthesize favorited = _favorited;

@synthesize truncated = _truncated;

@synthesize inReply2StatusId = _inReply2StatusId;

@synthesize inReply2UserId = _inReply2UserId;

@synthesize inReply2ScreenName = _inReply2ScreenName;

@synthesize mlevel = _mlevel;

@synthesize repostsCount = _repostsCount;

@synthesize commentsCount = _commentsCount;

@synthesize attitudesCount = _attitudesCount;

@synthesize thumbnailPic = _thumbnailPic;

@synthesize bmiddlePic = _bmiddlePic;

@synthesize originalPic = _originalPic;

@synthesize user = _user;

@synthesize userId = _userId;

@synthesize geo = _geo;

@synthesize retweetedStatus = _retweetedStatus;

@synthesize visibleType = _visibleType;

@synthesize visibleListId = _visibleListId;

- (void)dealloc
{
}

/**
 *	从字典中解析Status数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Status对象
 */
+ (Status *)getStatusFromJsonDic:(NSDictionary *)dic
{
    Status *aStatus = [[Status alloc] init];
    aStatus.createdAt = [dic objectForKey:@"created_at"];
    aStatus.statusId = [dic objectForKey:@"id"];
    aStatus.statusMId = [dic objectForKey:@"mid"];
    aStatus.text = [dic objectForKey:@"text"];
    aStatus.source = [dic objectForKey:@"source"];
    aStatus.favorited = [[dic objectForKey:@"favorited"] boolValue];
    aStatus.truncated = [[dic objectForKey:@"truncated"] boolValue];
    aStatus.inReply2StatusId = [dic objectForKey:@"in_reply_to_status_id"];
    aStatus.inReply2UserId = [dic objectForKey:@"in_reply_to_user_id"];
    aStatus.inReply2ScreenName = [dic objectForKey:@"in_reply_to_screen_name"];
    if ([[dic objectForKey:@"geo"] class] != [NSNull class] ) {
        aStatus.geo = [Geo getGeoFromJsonDic:[dic objectForKey:@"geo"]];
    }
    aStatus.thumbnailPic = [[NSMutableArray alloc] initWithCapacity:0];
    NSMutableArray *imageArray = [dic objectForKey:@"pic_urls"];
    if ([imageArray count] != 0) {
        for (NSDictionary *imageDic in imageArray) {
            [aStatus.thumbnailPic addObject:[imageDic objectForKey:@"thumbnail_pic"]];
        }
    }
    if ([dic objectForKey:@"bmiddle_pic"] != nil ) {
        aStatus.bmiddlePic = [dic objectForKey:@"bmiddle_pic"];
    }
    if ([dic objectForKey:@"original_pic"] != nil ) {
        aStatus.originalPic = [dic objectForKey:@"original_pic"];
    }
    if ([dic objectForKey:@"user"] != nil) {
        aStatus.user = [User getUserFromJsonDic:[dic objectForKey:@"user"]];
    }
    aStatus.userId = [dic objectForKey:@"user_id"];
    if ([dic objectForKey:@"retweeted_status"] != nil) {
        aStatus.retweetedStatus = [Status getStatusFromJsonDic:[dic objectForKey:@"retweeted_status"]];
    }
    aStatus.repostsCount = [[dic objectForKey:@"reposts_count"] intValue];
    aStatus.commentsCount = [[dic objectForKey:@"comments_count"] intValue];
    aStatus.attitudesCount = [[dic objectForKey:@"attitudes_count"] intValue];
    aStatus.mlevel = [dic objectForKey:@"mlevel"];
    NSDictionary *visibleDic = [dic objectForKey:@"visible"];
    aStatus.visibleType = [visibleDic objectForKey:@"type"];
    aStatus.visibleListId = [visibleDic objectForKey:@"list_id"];
    return aStatus;
}

@end



