//
//  User.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-28.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Status;

@interface User : NSObject
{
    NSString    *_userId;
    
    NSString    *_screenName;
    
    NSString    *_name;
    
    NSString    *_province;
    
    NSString    *_city;
    
    NSString    *_location;
    
    NSString    *_description;
    
    NSString    *_url;
    
    NSString    *_profileImageUrl;
    
    NSString    *_profileUrl;
    
    NSString    *_domain;
    
    NSString    *_gender;
    
    int         _followersCount;
    
    int         _friendsCount;
    
    int         _statusesCount;
    
    int         _favouritesCount;
    
    NSString    *_createdAt;
    
    BOOL        _allowAllActMsg;
    
    BOOL        _geoEnabled;
    
    BOOL        _verified;
    
    NSString    *_remark;
    
    Status      *_status;
    
    NSString    *_statusId;
    
    BOOL        _allowAllComment;
    
    NSString    *_avatarLarge;
    
    NSString    *_verifiedReason;
    
    BOOL        _followMe;
    
    NSString    *_onlineStatus;
    
    int         _biFollowersCount;
    
    NSString    *_lang;
    
}

/**
 *	用户ID
 */
@property (nonatomic, copy)NSString *userId;


/**
 *	用户昵称
 */
@property (nonatomic, copy)NSString *screenName;


/**
 *	友好显示名称
 */
@property (nonatomic, copy)NSString *name;


/**
 *	用户所在省级ID
 */
@property (nonatomic, copy)NSString *province;


/**
 *	用户所在城市ID
 */
@property (nonatomic, copy)NSString *city;


/**
 *	用户所在地
 */
@property (nonatomic, copy)NSString *location;


/**
 *	用户个人描述
 */
@property (nonatomic, copy)NSString *description;


/**
 *	用户博客地址
 */
@property (nonatomic, copy)NSString *url;


/**
 *	用户头像地址，50×50像素
 */
@property (nonatomic, copy)NSString *profileImageUrl;


/**
 *	用户的微博统一URL地址
 */
@property (nonatomic, copy)NSString *profileUrl;


/**
 *	用户的个性化域名
 */
@property (nonatomic, copy)NSString *domain;


/**
 *	性别，m：男、f：女、n：未知
 */
@property (nonatomic, copy)NSString *gender;


/**
 *	粉丝数
 */
@property (nonatomic, assign)int followersCount;


/**
 *	关注数
 */
@property (nonatomic, assign)int friendsCount;


/**
 *	微博数
 */
@property (nonatomic, assign)int statusesCount;


/**
 *	收藏数
 */
@property (nonatomic, assign)int favouritesCount;


/**
 *	用户创建（注册）时间
 */
@property (nonatomic, copy)NSString *createdAt;


/**
 *	是否允许所有人给我发私信，true：是，false：否
 */
@property (nonatomic, assign)BOOL allowAllActMsg;


/**
 *	是否允许标识用户的地理位置，true：是，false：否
 */
@property (nonatomic, assign)BOOL geoEnabled;


/**
 *	是否是微博认证用户，即加V用户，true：是，false：否
 */
@property (nonatomic, assign)BOOL verified;


/**
 *	用户备注信息，只有在查询用户关系时才返回此字段
 */
@property (nonatomic, copy)NSString *remark;


/**
 *	用户的最近一条微博信息字段 详细
 */
@property (nonatomic, retain)Status *status;


/**
 *	用户的最近一条微博信息ID
 */
@property (nonatomic, copy)NSString *statusId;


/**
 *	是否允许所有人对我的微博进行评论，true：是，false：否
 */
@property (nonatomic, assign)BOOL allowAllComment;


/**
 *	用户大头像地址
 */
@property (nonatomic, copy)NSString *avatarLarge;


/**
 *	认证原因
 */
@property (nonatomic, copy)NSString *verifiedReason;


/**
 *	该用户是否关注当前登录用户，true：是，false：否
 */
@property (nonatomic, assign)BOOL followMe;


/**
 *	用户的在线状态，0：不在线、1：在线
 */
@property (nonatomic, copy)NSString *onlineStatus;


/**
 *	用户的互粉数
 */
@property (nonatomic, assign)int biFollowersCount;


/**
 *	用户当前的语言版本，zh-cn：简体中文，zh-tw：繁体中文，en：英语
 */
@property (nonatomic, copy)NSString *lang;


/**
 *	从字典中解析User数据
 *
 *	@param	dic	json中的user字典
 *
 *	@return	组装之后的User对象
 */
+ (User *)getUserFromJsonDic:(NSDictionary *)dic;



+ (NSString *)unicodeString:(NSString *)str1;



@end
