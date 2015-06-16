//
//  NSString+ToNSDate.h
//  schoolfellow
//
//  Created by EasyitsApp on 13-12-18.
//  Copyright (c) 2013年 www.easyits.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SLDateExtend)

// NSString 转换成NSDate @"yyyy-MM-dd HH:mm:ss" OR @"yyyy-MM-dd"
- (NSDate *)toDate;

// 转换成活动时间
- (NSString *)convertToActivityDateString;
// 转换成聊天时间
- (NSString *)convertToChatDateString;
// 转换成动态,所有留言评论时间
- (NSString *)convertToDynamicAndDiscussDateString;
@end
