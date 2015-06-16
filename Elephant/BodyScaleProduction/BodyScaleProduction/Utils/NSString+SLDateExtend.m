//
//  NSString+ToNSDate.m
//  schoolfellow
//
//  Created by EasyitsApp on 13-12-18.
//  Copyright (c) 2013年 www.easyits.net. All rights reserved.
//

#import "NSString+SLDateExtend.h"
#import "NSDate+SLExtend.h"

@implementation NSString (SLDateExtend)

// NSString 转换成NSDate @"yyyy-MM-dd HH:mm:ss" OR @"yyyy-MM-dd"
- (NSDate *)toDate
{
    NSString *convStr = nil;
    if (self.length > 19) {
        convStr = [self substringToIndex:19];
    } else {
        convStr = self;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    if (self.length >= 19) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    NSDate *dateByStr = [formatter dateFromString:convStr];
    return dateByStr;
}


#pragma mark - Public Method
// =========================== 活动时间 ===============================
- (NSString *)convertToActivityDateString
{
    NSDate *date = [self toDate];
    NSString *activityDateString = nil;
    if ([date isYesterdayOrEarlier]) {
        activityDateString = [date convertToStandardDateFormat];
    } else if ([date isToday] || [date isTomorrow] || [date isTheDayAfterTomorrow]) {
        activityDateString = [date convertToStandardRecentlyDateFormat];
    } else if ([date isThisWeekLater]) {
        activityDateString = [date convertToStandardThisWeekDateFormat];
    } else if ([date isNextWeekOrLater]) {
        activityDateString = [date convertToStandardDateFormat];
    } else {
        return nil;
    }
    
    return activityDateString;
}

// =========================== 聊天时间 ===============================
- (NSString *)convertToChatDateString
{
    NSDate *date = [self toDate];
    NSString *chatDateString = nil;
    if ([date isToday]) {
        chatDateString = [date convertToStandardTimeDateFormat];
    } else if ([date isYesterDay] || [date isTheDayBeforeYesterday]) {
        chatDateString = [date convertToStandardRecentlyDateFormat];
    } else if ([date isThisWeekEarlier]) {
        chatDateString = [date convertToStandardThisWeekDateFormat];
    } else {
        chatDateString = [date convertToStandardNormalDateFormat];
    }
    
    return chatDateString;
}

// ====================== 转换成动态,所有留言评论时间 =======================
- (NSString *)convertToDynamicAndDiscussDateString
{
    NSDate *date = [self toDate];
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    if (timeInterval < 60) {
        return @"刚刚";
    } else if (timeInterval < 60 * 60) {
        return [NSString stringWithFormat:@"%.0f分钟前", timeInterval / 60];
    } else if ([date isToday] || [date isYesterDay] || [date isTheDayBeforeYesterday]) {
        return [date convertToStandardRecentlyDateFormat];
    } else if ([date isThisWeekEarlier]) {
        return [date convertToStandardThisWeekDateFormat];
    } else if ([date isLastWeekOrEarlier]) {
        return [date convertToStandardNormalDateFormat];
    } else {
        return nil;
    }
}

@end
