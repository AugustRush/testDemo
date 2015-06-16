//
//  Comment.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-3.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@class Status;

@interface Comment : NSObject
{
    NSString *_createdAt;
    
    NSString *_commentId;
    
    NSString *_text;
    
    NSString *_source;
    
    User *_user;
    
    NSString *_commentMId;
    
    Status *_status;
    
    Comment *_replyComment;
    
}


/**
 *	评论创建时间
 */
@property (nonatomic, copy)NSString *createdAt;


/**
 *	评论的ID
 */
@property (nonatomic, copy)NSString *commentId;


/**
 *	评论的内容
 */
@property (nonatomic, copy)NSString *text;


/**
 *	评论的来源
 */
@property (nonatomic, copy)NSString *source;


/**
 *	评论作者的用户信息字段
 */
@property (nonatomic, retain)User *user;


/**
 *	评论的MID
 */
@property (nonatomic, copy)NSString *commentMId;


/**
 *	评论的微博信息字段
 */
@property (nonatomic, retain)Status *status;


/**
 *	评论来源评论，当本评论属于对另一评论的回复时返回此字段
 */
@property (nonatomic, retain)Comment *replyComment;



/**
 *	从字典中解析Comment数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Comment对象
 */
+ (Comment *)getCommentFromJsonDic:(NSDictionary *)dic;


@end
