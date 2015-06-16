//
//  Status.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-28.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class Geo;

@interface Status : NSObject
{
    NSString            *_createdAt;
    
    NSString            *_statusId;
    
    NSString            *_statusMId;
    
    NSString            *_text;
    
    NSString            *_source;
    
    BOOL                _favorited;
    
    BOOL                _truncated;
    
    NSString            *_inReply2StatusId;
    
    NSString            *_inReply2UserId;
    
    NSString            *_inReply2ScreenName;
    
    NSString            *_mlevel;
    
    int                 _repostsCount;
    
    int                 _commentsCount;
    
    int                 _attitudesCount;
    
    NSMutableArray      *_thumbnailPic;
    
    NSString            *_bmiddlePic;
    
    NSString            *_originalPic;
    
    User                *_user;
    
    NSString            *_userId;
    
    Geo                 *_geo;
    
    Status              *_retweetedStatus;
    
    NSString            *_visibleType;
    
    NSString            *_visibleListId;
    
}

/**
 *	微博创建时间
 */
@property (nonatomic, copy)NSString *createdAt;


/**
 *	微博ID
 */
@property (nonatomic, copy)NSString *statusId;


/**
 *	微博MID
 */
@property (nonatomic, copy)NSString *statusMId;


/**
 *	微博信息内容
 */
@property (nonatomic, copy)NSString *text;


/**
 *	微博来源
 */
@property (nonatomic, copy)NSString *source;


/**
 *	是否已收藏，true：是，false：否
 */
@property (nonatomic, assign)BOOL favorited;


/**
 *	是否被截断，true：是，false：否
 */
@property (nonatomic, assign)BOOL truncated;


/**
 *	（暂未支持）回复ID
 */
@property (nonatomic, copy)NSString *inReply2StatusId;

/**
 *	（暂未支持）回复人UID
 */
@property (nonatomic, copy)NSString *inReply2UserId;


/**
 *	（暂未支持）回复人昵称
 */
@property (nonatomic, copy)NSString *inReply2ScreenName;


/**
 *	（暂未支持）
 */
@property (nonatomic, copy)NSString *mlevel;


/**
 *	转发数
 */
@property (nonatomic, assign)int repostsCount;


/**
 *	评论数
 */
@property (nonatomic, assign)int commentsCount;


/**
 *	表态数
 */
@property (nonatomic, assign)int attitudesCount;


/**
 *	缩略图片地址，没有时不返回此字段
 */
@property (nonatomic, retain)NSMutableArray *thumbnailPic;


/**
 *	中等尺寸图片地址，没有时不返回此字段
 */
@property (nonatomic, copy)NSString *bmiddlePic;


/**
 *	原始图片地址，没有时不返回此字段
 */
@property (nonatomic, copy)NSString *originalPic;


/**
 *	微博作者的用户信息字段
 */
@property (nonatomic, retain)User *user;


/**
 *	微博作者的用户信息字段
 */
@property (nonatomic, copy)NSString *userId;


/**
 *	地理信息字段
 */
@property (nonatomic, retain)Geo *geo;


/**
 *	被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property (nonatomic, retain)Status *retweetedStatus;


/**
 *	微博的可见性, 0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；
 */
@property (nonatomic, copy)NSString *visibleType;


/**
 *	微博的可见性及指定可见分组信息,list_id为分组的组号
 */
@property (nonatomic, copy)NSString *visibleListId;


/**
 *	从字典中解析Status数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Status对象
 */
+ (Status *)getStatusFromJsonDic:(NSDictionary *)dic;


@end

