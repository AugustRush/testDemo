//
//  Comment.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-3.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "Comment.h"
#import "User.h"
#import "Status.h"

@implementation Comment

@synthesize createdAt = _createdAt;

@synthesize commentId = _commentId;

@synthesize text = _text;

@synthesize source = _source;

@synthesize user = _user;

@synthesize commentMId = _commentMId;

@synthesize status = _status;

@synthesize replyComment = _replyComment;


- (void)dealloc
{
}




/**
 *	从字典中解析Comment数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Comment对象
 */
+ (Comment *)getCommentFromJsonDic:(NSDictionary *)dic
{
    Comment *aComment = [[Comment alloc] init];
    aComment.createdAt = [dic objectForKey:@"created_at"];
    aComment.commentId = [dic objectForKey:@"id"];
    aComment.commentMId = [dic objectForKey:@"mid"];
    aComment.text = [dic objectForKey:@"text"];
    aComment.source = [dic objectForKey:@"source"];
    aComment.user = [User getUserFromJsonDic:[dic objectForKey:@"user"]];
    aComment.status = [Status getStatusFromJsonDic:[dic objectForKey:@"status"]];
    if ([dic objectForKey:@"reply_comment"] != nil) {
        aComment.replyComment = [Comment getCommentFromJsonDic:[dic objectForKey:@"reply_comment"]];
    }
    
    return aComment;
}



@end
