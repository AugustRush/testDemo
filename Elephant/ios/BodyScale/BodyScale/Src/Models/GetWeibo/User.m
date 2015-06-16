//
//  User.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-28.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "User.h"
#import "Status.h"

@implementation User

@synthesize userId = _userId;

@synthesize screenName = _screenName;

@synthesize name = _name;

@synthesize province = _province;

@synthesize city = _city;

@synthesize location = _location;

@synthesize description = _description;

@synthesize url = _url;

@synthesize profileImageUrl = _profileImageUrl;

@synthesize profileUrl = _profileUrl;

@synthesize domain = _domain;

@synthesize gender = _gender;

@synthesize followersCount = _followersCount;

@synthesize friendsCount = _friendsCount;

@synthesize statusesCount = _statusesCount;

@synthesize favouritesCount = _favouritesCount;

@synthesize createdAt = _createdAt;

@synthesize allowAllActMsg = _allowAllActMsg;

@synthesize geoEnabled = _geoEnabled;

@synthesize verified = _verified;

@synthesize remark = _remark;

@synthesize status = _status;

@synthesize statusId = _statusId;

@synthesize allowAllComment = _allowAllComment;

@synthesize avatarLarge = _avatarLarge;

@synthesize verifiedReason = _verifiedReason;

@synthesize followMe = _followMe;

@synthesize onlineStatus = _onlineStatus;

@synthesize biFollowersCount = _biFollowersCount;

@synthesize lang = _lang;


- (void)dealloc
{
}


/**
 *	从字典中解析User数据
 *
 *	@param	dic	json中的user字典
 *
 *	@return	组装之后的User对象
 */
+ (User *)getUserFromJsonDic:(NSDictionary *)dic
{
    User *user = [[User alloc] init];
    user.userId = [dic objectForKey:@"id"];
    if ([dic objectForKey:@"screen_name"] != nil && ![[dic objectForKey:@"screen_name"] isEqualToString:@""] ) {
        user.screenName = [dic objectForKey:@"screen_name"];
    }else{
        user.screenName = [dic objectForKey:@"nickname"];
    }
    
    user.name = [dic objectForKey:@"name"];
    user.province = [dic objectForKey:@"province"];
    user.city = [dic objectForKey:@"city"];
    user.location = [dic objectForKey:@"location"];
    user.description = [dic objectForKey:@"description"];
    user.url = [dic objectForKey:@"url"];
    user.profileImageUrl = [dic objectForKey:@"profile_image_url"];
    user.profileUrl = [dic objectForKey:@"profile_url"];
    user.domain = [dic objectForKey:@"domain"];
    user.gender = [dic objectForKey:@"gender"];
    user.followersCount = [[dic objectForKey:@"followers_count"] intValue];
    user.friendsCount = [[dic objectForKey:@"friends_count"] intValue];
    user.statusesCount = [[dic objectForKey:@"statuses_count"] intValue];
    user.favouritesCount = [[dic objectForKey:@"favourites_count"] intValue];
    user.createdAt = [dic objectForKey:@"created_at"];
    user.allowAllActMsg = [[dic objectForKey:@"allow_all_act_msg"] boolValue];
    user.geoEnabled = [[dic objectForKey:@"geo_enabled"] boolValue];
    user.verified = [[dic objectForKey:@"verified"] boolValue];
    user.remark = [dic objectForKey:@"remark"];
    if ([dic objectForKey:@"status"] != nil) {
        user.status = [Status getStatusFromJsonDic:[dic objectForKey:@"status"]];
    }
    user.statusId = [dic objectForKey:@"status_id"];
    user.allowAllComment = [[dic objectForKey:@"allow_all_comment"] boolValue];
    user.avatarLarge = [dic objectForKey:@"avatar_large"];
    user.verifiedReason = [dic objectForKey:@"verified_reason"];
    user.followMe = [[dic objectForKey:@"follow_me"] boolValue];
    user.onlineStatus = [dic objectForKey:@"online_status"];
    user.biFollowersCount = [[dic objectForKey:@"bi_followers_count"] intValue];
    user.lang = [dic objectForKey:@"lang"];
    return user;
}


+ (NSString *)unicodeString:(NSString *)str1
{
    NSData *data = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str2 = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    return str2;
}


@end
