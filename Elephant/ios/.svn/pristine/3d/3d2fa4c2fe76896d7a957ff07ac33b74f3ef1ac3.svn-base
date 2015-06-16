//
//  LPSinaEngine.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-9-25.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//
//  版本:1.0 最终修改日期：2013-10-13

/******************更改测试账号时需要修改以下三条内容*********************/

//#define SINA_REDIRECT_URI    @"http://api.huochaihe.cc/weibo/callback.php"

/*********************************************************************/
#define HOSTURL                  @"api.weibo.com"
#define SINA_AUTHORIZE_URL       @"https://api.weibo.com/oauth2/authorize"
#define SINA_ACCESSTOKEN_URL     @"https://api.weibo.com/oauth2/access_token"

#define SINA_ACCESS_TOKEN_KEY      @"SINAAccessTokenKey"
#define SINA_ACCESS_EXPIRES_IN_KEY @"SINAAccessExpiresInKey"
#define SINA_USER_ID_KEY           @"SINAUserIdKey"


#import <Foundation/Foundation.h>

#import "MKNetworkEngine.h"
#import "HttpBaseModel.h"
#import "SBJsonBase.h"
#import "SBJsonParser.h"
#import "SBJsonWriter.h"
#import "Status.h"
#import "Comment.h"
#import "User.h"
#import "Favorite.h"
#import "Emotion.h"
#import "Trend.h"
#import "School.h"
#import "App.h"
#import "Urls.h"
#import "Poi.h"

@interface LPSinaEngine : NSObject

/**
 *	授权地址
 *
 *	@return     UIWebView所要加载的url
 */
+ (NSURL *)authorizeURL;



#pragma mark -
#pragma mark 关于登录和登出的接口

/**
 *	判断有没有登录过，并且获得到的token有没有过期
 *
 *	@return     YES 有可用的token ，并且没有过期; NO 没有可用的token
 */
+ (BOOL)isAuthorized;



/**
 *	获取AccessToken
 *
 *	@param	code        在webView的重定向地址中取得code
 *  @param  isSuccess   block 请求成功的回调
 *                      BOOL  isSuccess 请求是否成功 YES or NO
 */
+ (void)getAccessToken:(NSString *)code
               success:(void (^) (BOOL isSuccess))isSuccess;



/**
 *	登出，清除当前账号的信息
 */
+ (void)logout;



#pragma mark -
#pragma mark 关于用户的接口
/**
 *	根据用户ID获取用户信息
 *
 *	@param	uid         用户ID
 *  @param  isSuccess   block   请求成功的回调
 *                      BOOL    请求是否成功 YES or NO
 *                      User    返回的用户信息对象
 */
+ (void)getUserInfo:(NSString *)uid
            success:(void (^) (BOOL isSuccess, User *aUser))isSuccess;



/**
 *	验证昵称是否可用，并给予建议昵称
 *
 *	@param	nickName        需要验证的昵称。4-20个字符，支持中英文、数字、"_"或减号。必须做URLEncode，采用UTF-8编码。
 *  @param  isSuccess       block           请求成功的回调
 *                          BOOL            isSuccess   请求是否成功 YES or NO
 *                          BOOL            isLegal     昵称是否可用 YES or NO
 *                          NSMutableArray  array       返回的推荐昵称数组
 */
+ (void)verifyNickName:(NSString *)nickName
               success:(void (^) (BOOL isSuccess, BOOL isLegal, NSMutableArray *array))isSuccess;



#pragma mark -
#pragma mark 关于微博的接口

/**
 *	发送微博
 *
 *	@param	aContent	微博的文字内容
 *	@param	picData     如果同时要上传的图片，传入图片的NSData对象。仅支持JPEG、GIF、PNG格式，图片大小小于5M。如果只发送文字微博，则传入nil。
 *	@param	latFloat    纬度，有效范围：-90.0到+90.0，+表示北纬，默认为0.0。
 *	@param	longFloat   经度，有效范围：-180.0到+180.0，+表示东经，默认为0.0。
 *	@param	visible     微博的可见性，0：所有人能看，1：仅自己可见，2：密友可见，3：指定分组可见，默认为0。
 *	@param	listId      微博的保护投递指定分组ID，只有当visible参数为3时生效且必选。
 *  @param  isSuccess   block   请求成功的回调
 *                      BOOL    请求是否成功 YES or NO
 *                      Status  当前发送的微博内容
 */
+ (void)sendStatus:(NSString *)aContent
           picData:(NSData *)picData
          latFloat:(float)latFloat
         longFloat:(float)longFloat
           visible:(int)visible
            listId:(NSString *)listId
           success:(void (^) (BOOL isSuccess, Status *aStatus))isSuccess;



/**
 *	转发一条微博
 *
 *	@param	statusId	要转发的微博ID。
 *	@param	aContent	添加的转发文本，必须做URLencode，内容不超过140个汉字，不填则默认为“转发微博”。
 *	@param	isComment	是否在转发的同时发表评论，0：否、1：评论给当前微博、2：评论给原微博、3：都评论，默认为0 。
 *  @param  isSuccess   block   请求成功的回调
 *                      BOOL    请求是否成功 YES or NO
 *                      Status  转发后的微博内容
 */
+ (void)repostStatusWithStatusId:(NSString *)statusId
                         content:(NSString *)aContent
                       isComment:(int)isComment
                         success:(void (^) (BOOL isSuccess, Status *aStatus))isSuccess;



/**
 *	根据微博ID删除指定微博
 *
 *	@param	statusId	需要删除的微博ID。
 *  @param  isSuccess   block   请求成功的回调
 *                      BOOL    请求是否成功 YES or NO
 *                      Status  当前收藏的微博内容
 */
+ (void)destroyStatusWithStatusId:(NSString *)statusId
                          success:(void (^) (BOOL isSuccess, Status *aStatus))isSuccess;



/**
 *	获取当前登录用户及其所关注用户的最新微博
 *
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过100，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	feature     过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *	@param	trimUser	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getStatusesWithSinceId:(int)sinceId
                         maxId:(int)maxId
                         count:(int)count
                          page:(int)page
                       feature:(int)feature
                      trimUser:(int)trimUser
                       success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取双向关注用户的最新微博
 *
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过100，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	feature     过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *	@param	trimUser	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getBilateralStatusesWithSinceId:(int)sinceId
                                  maxId:(int)maxId
                                  count:(int)count
                                   page:(int)page
                                feature:(int)feature
                               trimUser:(int)trimUser
                                success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取某个用户最新发表的微博列表
 *
 *	@param	uid         需要查询的用户ID。参数uid与screen_name二者必选其一，且只能选其一；
 *	@param	screenName  需要查询的用户昵称。
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过100，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	feature     过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *	@param	trimUser	返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getStatusesWithUId:(NSString *)uId
              orScreenName:(NSString *)screenName
                   sinceId:(int)sinceId
                     maxId:(int)maxId
                     count:(int)count
                      page:(int)page
                   feature:(int)feature
                  trimUser:(int)trimUser
                   success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取指定微博的转发微博列表
 *
 *	@param	statusId    需要查询的微博ID。
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过200，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	filter      作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getRepostStatusesWithStatusId:(NSString *)statusId
                              SinceId:(int)sinceId
                                maxId:(int)maxId
                                count:(int)count
                                 page:(int)page
                       filterByAuthor:(int)filter
                              success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取最新的提到登录用户的微博列表，即@我的微博
 *
 *	@param	sinceId             若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId               若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count               单页返回的记录条数，最大不超过100，默认为20。
 *	@param	page                返回结果的页码，默认为1。
 *	@param	filterByAuthor      作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *	@param	filterBySource      来源筛选类型，0：全部、1：来自微博、2：来自微群，默认为0。
 *	@param	filterByType        原创筛选类型，0：全部微博、1：原创的微博，默认为0。
 *  @param  isSuccess           block           请求成功的回调
 *                              BOOL            请求是否成功 YES or NO
 *                              NSMutableArray  返回的微博信息数组
 */
+ (void)getMentionsStatusesWithSinceId:(int)sinceId
                                 maxId:(int)maxId
                                 count:(int)count
                                  page:(int)page
                        filterByAuthor:(int)filterByAuthor
                        filterBySource:(int)filterBySource
                          filterByType:(int)filterByType
                               success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取微博官方表情的详细信息
 *
 *	@param	type            表情类别，face：普通表情、ani：魔法表情、cartoon：动漫表情，默认为face。
 *	@param	language        语言类别，cnname：简体、twname：繁体，默认为cnname。
 *  @param  isSuccess       block           请求成功的回调
 *                          BOOL            请求是否成功 YES or NO
 *                          NSMutableArray  返回的表情数组
 */
+ (void)getEmotionsWithType:(NSString *)type
                   language:(NSString *)language
                    success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



#pragma mark -
#pragma mark 关于评论的接口

/**
 *	对一条微博进行评论
 *
 *	@param	comment     评论内容,内容不超过140个汉字。
 *	@param	statusId	需要评论的微博ID。
 *	@param	commentOri	是否评论给原微博，0：否、1：是，默认为0。
 *  @param  isSuccess   block       请求成功的回调
 *                      BOOL        请求是否成功 YES or NO
 *                      Comment     返回的用户信息对象
 */
+ (void)creatComment:(NSString *)comment
            statusId:(NSString *)statusId
          commentOri:(int)commentOri
             success:(void (^) (BOOL isSuccess, Comment *aComment))isSuccess;



/**
 *	删除一条评论
 *
 *	@param	commentId       要删除的评论ID，只能删除登录用户自己发布的评论。
 *  @param  isSuccess       block       请求成功的回调
 *                          BOOL        请求是否成功 YES or NO
 *                          Comment     返回的用户信息对象
 */
+ (void)destroyCommentWithCommentId:(NSString *)commentId
                            success:(void (^) (BOOL isSuccess, Comment *aComment))isSuccess;



/**
 *	回复一条评论
 *
 *	@param	commentId           需要回复的评论ID。
 *	@param	statusId            需要评论的微博ID。
 *	@param	content             回复评论内容，必须做URLencode，内容不超过140个汉字。
 *	@param	withoutMention      回复中是否自动加入“回复@用户名”，0：是、1：否，默认为0。
 *	@param	commentOri          当评论转发微博时，是否评论给原微博，0：否、1：是，默认为0。
 *  @param  isSuccess           block       请求成功的回调
 *                              BOOL        请求是否成功 YES or NO
 *                              Comment     返回的用户信息对象
 */
+ (void)replyCommentWithCommentId:(NSString *)commentId
                         statusId:(NSString *)statusId
                          content:(NSString *)content
                   withoutMention:(int)withoutMention
                       commentOri:(int)commentOri
                          success:(void (^) (BOOL isSuccess, Comment *aComment))isSuccess;



/**
 *	根据微博ID返回某条微博的评论列表
 *
 *	@param	statusId	需要查询的微博ID。
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的评论，默认为0。
 *	@param	count       单页返回的记录条数，默认为50。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	filter      作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回微博评论数组
 */
+ (void)getCommentsWithStatusId:(NSString *)statusId
                        sinceId:(int)sinceId
                          maxId:(int)maxId
                          count:(int)count
                           page:(int)page
                 filterByAuthor:(int)filter
                        success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取当前登录用户所发出的评论列表
 *
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的评论，默认为0。
 *	@param	count       单页返回的记录条数，默认为50。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	filter      来源筛选类型，0：全部、1：来自微博的评论、2：来自微群的评论，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回微博评论数组
 */
+ (void)getCommentsByMeWithSinceId:(int)sinceId
                             maxId:(int)maxId
                             count:(int)count
                              page:(int)page
                    filterBySource:(int)filter
                           success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取当前登录用户所接收到的评论列表
 *
 *	@param	sinceId             若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0。
 *	@param	maxId               若指定此参数，则返回ID小于或等于max_id的评论，默认为0。
 *	@param	count               单页返回的记录条数，默认为50。
 *	@param	page                返回结果的页码，默认为1。
 *	@param	filterByAuthor      作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *	@param	filterBySource      来源筛选类型，0：全部、1：来自微博的评论、2：来自微群的评论，默认为0。
 *  @param  isSuccess           block           请求成功的回调
 *                              BOOL            请求是否成功 YES or NO
 *                              NSMutableArray  返回评论数组
 */
+ (void)getComments2MeWithSinceId:(int)sinceId
                            maxId:(int)maxId
                            count:(int)count
                             page:(int)page
                   filterByAuthor:(int)filterByAuthor
                   filterBySource:(int)filterBySource
                          success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取当前登录用户的最新评论包括接收到的与发出的
 *
 *	@param	sinceId         若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0。
 *	@param	maxId           若指定此参数，则返回ID小于或等于max_id的评论，默认为0。
 *	@param	count           单页返回的记录条数，默认为50。
 *	@param	page            返回结果的页码，默认为1。
 *	@param	trimUser        返回值中user字段开关，0：返回完整user字段、1：user字段仅返回user_id，默认为0。
 *  @param  isSuccess       block           请求成功的回调
 *                          BOOL            请求是否成功 YES or NO
 *                          NSMutableArray  返回评论数组
 */
+ (void)getCommentsWithSinceId:(int)sinceId
                         maxId:(int)maxId
                         count:(int)count
                          page:(int)page
                      trimUser:(int)trimUser
                       success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取最新的提到当前登录用户的评论，即@我的评论
 *
 *	@param	sinceId             若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0。
 *	@param	maxId               若指定此参数，则返回ID小于或等于max_id的评论，默认为0。
 *	@param	count               单页返回的记录条数，默认为50。
 *	@param	page                返回结果的页码，默认为1。
 *	@param	filterByAuthor      作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。
 *	@param	filterBySource      来源筛选类型，0：全部、1：来自微博的评论、2：来自微群的评论，默认为0。
 *  @param  isSuccess           block           请求成功的回调
 *                              BOOL            请求是否成功 YES or NO
 *                              NSMutableArray  返回评论数组
 */
+ (void)getMentionsCommentsWithSinceId:(int)sinceId
                                 maxId:(int)maxId
                                 count:(int)count
                                  page:(int)page
                        filterByAuthor:(int)filterByAuthor
                        filterBySource:(int)filterBySource
                               success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;


#pragma mark -
#pragma mark 关于关系的接口

/**
 *	获取用户的关注列表 或 粉丝列表
 *
 *	@param	uid             需要查询的用户ID。参数uid与screen_name二者必选其一，且只能选其一；
 *	@param	screenName      需要查询的用户昵称。
 *	@param	flag            标示是获取关注列表或者粉丝列表 0：用户关注列表，1：用户粉丝列表
 *	@param	count           单页返回的记录条数，默认为50，最大不超过200。
 *	@param	cursor          返回结果的游标，下一页用返回值里的next_cursor，上一页用previous_cursor，默认为0。
 *	@param	trimStatus      返回值中user字段中的status字段开关，0：返回完整status字段、1：status字段仅返回status_id，默认为1。
 *  @param  isSuccess       block           请求成功的回调
 *                          BOOL            请求是否成功 YES or NO
 *                          NSMutableArray  返回的用户数组
 *                          NSString        nextCursor      下一页的游标
 *                          NSString        previousCursor  上一页的游标
 *                          NSString        totalNumber     总关注数
 */
+ (void)getFriendsOrFollowersWithUId:(NSString *)uId
                        orScreenName:(NSString *)screenName
                                flag:(int)flag
                               count:(int)count
                              cursor:(int)cursor
                          trimStatus:(int)trimStatus
                             success:(void (^) (BOOL isSuccess, NSMutableArray *array, NSString *nextCursor, NSString *previousCursor, NSString *totalNumber))isSuccess;



/**
 *	关注一个用户 或者 取消关注一个用户
 *
 *	@param	userId      需要关注的用户ID。
 *	@param	userId      需要关注的用户昵称。
 *	@param	flag        标示是关注或者是取消关注 0:关注 1：取消关注
 *  @param  isSuccess   block   请求成功的回调
 *                      BOOL    请求是否成功 YES or NO
 *                      Status  当前关注的用户信息
 */
+ (void)creatOrDestroyFriendWithUserId:(NSString *)userId
                            screenName:(NSString *)screenName
                                  flag:(int)flag
                               success:(void (^) (BOOL isSuccess, User *aUser))isSuccess;



#pragma mark -
#pragma mark 关于收藏的接口

/**
 *	添加一条微博到收藏 或者 取消收藏一条微博
 *
 *	@param	statusId	要收藏的微博ID。
 *	@param	flag        标示是添加收藏还是取消收藏 0:添加收藏 1：取消收藏
 *  @param  isSuccess   block   请求成功的回调
 *                      BOOL    请求是否成功 YES or NO
 *                      Status  当前收藏的微博内容
 */
+ (void)creatOrDestroyFavoriteWithStatusId:(NSString *)statusId
                                      flag:(int)flag
                                   success:(void (^) (BOOL isSuccess, Favorite *aFavorite))isSuccess;



/**
 *	获取当前登录用户的收藏列表或系统推荐的热门收藏
 *
 *	@param	flag        标示获取收藏的种类 0：前登录用户的收藏列表 1：系统推荐的热门收藏
 *	@param	count       单页返回的记录条数，当flag = 0，默认为50。当flag = 1，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回所收藏微博的数组
 */
+ (void)getFavoriteWithFlag:(int)flag
                      count:(int)count
                       page:(int)page
                    success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



#pragma mark -
#pragma mark 关于话题的接口

/**
 *	获取最近的热门话题
 *	@param	flag            标示时间的远近 0：一小时内的热门话题 1：一天内的热门话题 2：一周内的热门话题
 *  @param  isSuccess       block           请求成功的回调
 *                          BOOL            请求是否成功 YES or NO
 *                          NSMutableArray  返回热门话题的数组
 */
+ (void)getTrendsWithFlag:(int)flag
                  success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



#pragma mark -
#pragma mark 关于搜索的接口

/**
 *	搜索时的联想搜索建议
 *
 *	@param	qstr        搜索的关键字，必须做URLencoding。
 *	@param	flag        搜索的标示符，0：搜索用户时的联想搜索建议  1：搜索学校时的联想搜索建议  2：搜索公司时的联想搜索建议  3：搜索应用时的联想搜索建议  4：@用户时的联想建议
 *	@param	count       返回的记录条数，默认为10。当flag为4，即搜索@用户时的联想建议，type为粉丝时最多1000，type为关注时最多2000。
 *	@param	type        联想类型：
                        当flag为2时，type表示学校类型，0：全部、1：大学、2：高中、3：中专技校、4：初中、5：小学，默认为0
                        当flag为4时，type表示联想用户类型，0：关注、1：粉丝。
                        当flag为其他时，此参数无效。
 *	@param	range       联想范围：
                        当flag为4时，即搜索@用户时的联想建议，0：只联想关注人、1：只联想关注人的备注、2：全部，默认为2。
                        当flag为其他时，此参数无效。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回联想建议的数组
 */
+ (void)searchSuggestionWithQStr:(NSString *)qstr
                            flag:(int)flag
                           count:(int)count
                            type:(int)type
                           range:(int)range
                         success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



#pragma mark -
#pragma mark 关于短链的接口

/**
 *	搜索时的联想搜索建议
 *
 *	@param	flag        标示转换的种类，0：长链转短链  1：短链转长链
 *	@param	urlStr      需要转换的链接，需要URLencoded，最多不超过20个。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  解析后的url数组
 */

+ (void)convertUrlWithFlag:(int)flag
                    urlStr:(NSString *)urlStr
                   success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



#pragma mark -
#pragma mark 关于地理信息，位置服务的接口

/**
 *	获取附近地点
 *
 *	@param	latFloat    纬度，有效范围：-90.0到+90.0，+表示北纬。
 *	@param	longFloat   经度，有效范围：-180.0到+180.0，+表示东经。
 *	@param	range       查询范围半径，默认为2000，最大为10000，单位米。
 *	@param	count       单页返回的记录条数，默认为20，最大为50。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	sort        排序方式，0：按权重，1：按距离，3：按签到人数。默认为0。
 *	@param	offset      传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  解析后的Poi对象数组
 */
+ (void)getNearbyPoisWithLatFloat:(float)latFloat
                        longFloat:(float)longFloat
                            range:(int)range
                            count:(int)count
                             page:(int)page
                             sort:(int)sort
                           offset:(int)offset
                          success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取附近发位置微博的人 或 获取附近的微博
 *
 *	@param	flag        标示请求的种类，为0时：获取附近发位置微博的人 为1时：获取附近的微博
 *	@param	latFloat	纬度，有效范围：-90.0到+90.0，+表示北纬。
 *	@param	longFloat	经度，有效范围：-180.0到+180.0，+表示东经。
 *	@param	range       查询范围半径，默认为2000，最大为11132，单位米。
 *	@param	count       单页返回的记录条数，默认为20，最大为50。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	startTime	开始时间，Unix时间戳，不筛选则传0。
 *	@param	endTime     结束时间，Unix时间戳，不筛选则传0。
 *	@param	sort        排序方式，0：按时间、1：按距离，默认为0。
 *	@param	offset      传入的经纬度是否是纠偏过，0：没纠偏、1：纠偏过，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  解析后的User数组
 */
+ (void)getNearbyUsersWithFlag:(int)flag
                      latFloat:(float)latFloat
                     longFloat:(float)longFloat
                         range:(int)range
                         count:(int)count
                          page:(int)page
                     startTime:(long long)startTime
                       endTime:(long long)endTime
                          sort:(int)sort
                        offset:(int)offset
                       success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取当前登录用户与其好友的位置动态
 *
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过50，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	type        关系过滤，0：仅返回关注的，1：返回好友的，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getPlaceStatusesWithSinceId:(int)sinceId
                              maxId:(int)maxId
                              count:(int)count
                               page:(int)page
                               type:(int)type
                            success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/**
 *	获取某个用户的位置动态
 *
 *	@param	uid         需要查询的用户ID。
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过50，默认为20。
 *	@param	page        返回结果的页码，默认为1。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getPlaceStatusesWithUId:(NSString *)uId
                        sinceId:(int)sinceId
                          maxId:(int)maxId
                          count:(int)count
                           page:(int)page
                        success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;



/******************************************************************************/

#pragma mark -
#pragma mark 高级权限接口 正在申请中  未完成

/**
 *	获取当前登陆用户好友分组列表
 *
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回分组信息数组
 */
+ (void)getFriendshipsGroupsWithSuccess:(void (^) (BOOL isSuccess, NSMutableArray *friendsArray))isSuccess;



/**
 *	获取当前登录用户某一好友分组的微博列表
 *
 *	@param	listId      需要查询的好友分组ID，当查询的为私有分组时，则当前登录用户必须为其所有者。
 *	@param	sinceId     若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 *	@param	maxId       若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 *	@param	count       单页返回的记录条数，最大不超过200，默认为50。
 *	@param	page        返回结果的页码，默认为1。
 *	@param	feature     过滤类型ID，0：全部、1：原创、2：图片、3：视频、4：音乐，默认为0。
 *  @param  isSuccess   block           请求成功的回调
 *                      BOOL            请求是否成功 YES or NO
 *                      NSMutableArray  返回的微博信息数组
 */
+ (void)getFriendshipsGroupStatusesWithListId:(int)listId
                                      sinceId:(int)sinceId
                                        maxId:(int)maxId
                                        count:(int)count
                                         page:(int)page
                                      feature:(int)feature
                                      success:(void (^) (BOOL isSuccess, NSMutableArray *array))isSuccess;

@end

