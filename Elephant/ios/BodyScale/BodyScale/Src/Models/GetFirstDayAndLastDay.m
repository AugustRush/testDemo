//
//  GetFirstDayAndLastDay.m
//  BodyScale
//
//  Created by 两元鱼 on 15/3/18.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "GetFirstDayAndLastDay.h"

@implementation GetFirstDayAndLastDay

+ (NSArray *)getWeekBeginAndEnd:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    long firstDiff,lastDiff;
    firstDiff = [calendar firstWeekday] - weekDay;
    lastDiff = 7 - weekDay;

    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    return @[firstDayOfWeek, lastDayOfWeek];
}

+ (NSString *)getWeekBeginToEndString:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    long firstDiff,lastDiff;
    firstDiff = [calendar firstWeekday] - weekDay;
    lastDiff = 7 - weekDay;

    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM月dd日"];
    return [NSString stringWithFormat:@"%@-%@", [formater stringFromDate:firstDayOfWeek], [formater stringFromDate:lastDayOfWeek]];
}
+ (NSString *)getThisMonthString:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    long firstDiff,lastDiff;
    firstDiff = [calendar firstWeekday] - weekDay;
    lastDiff = 7 - weekDay;
    
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月"];
    return [NSString stringWithFormat:@"%@", [formater stringFromDate:firstDayOfWeek]];
}
+ (NSString *)getThisYearString:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    long firstDiff,lastDiff;
    firstDiff = [calendar firstWeekday] - weekDay;
    lastDiff = 7 - weekDay;
    
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年"];
    return [NSString stringWithFormat:@"%@", [formater stringFromDate:firstDayOfWeek]];
}

+ (NSArray *)getWeekBeginAndEndString:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    
    NSInteger weekDay = [comp weekday];
    NSInteger day = [comp day];
    long firstDiff,lastDiff;
    firstDiff = [calendar firstWeekday] - weekDay;
    lastDiff = 7 - weekDay;
    
    NSDateComponents *firstDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];
    
    NSDateComponents *lastDayComp = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    [lastDayComp setDay:day + lastDiff];
    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"MM-dd"];
    return @[[formater stringFromDate:firstDayOfWeek], [formater stringFromDate:lastDayOfWeek]];
}
+ (NSArray *)getMonthBeginAndEnd:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:nowDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok)
    {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    return @[beginString, endString];
}
+ (NSArray *)getYearBeginAndEnd:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSYearCalendarUnit startDate:&beginDate interval:&interval forDate:nowDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok)
    {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    
    return @[beginString, endString];
}
+ (NSString *)getThisYear:(NSDate *)nowDate
{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy"];
    NSString *beginString = [myDateFormatter stringFromDate:nowDate];
    return beginString;
}
+ (NSString *)getThisMonth:(NSDate *)nowDate
{
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"yyyy-MM"];
    NSString *beginString = [myDateFormatter stringFromDate:nowDate];
    return beginString;
}
+ (NSDate *)lastWeekDate:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    return [nowDate dateByAddingTimeInterval:-60*60*24*7];
}
+ (NSDate *)lastMonthDate:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    return [nowDate dateByAddingTimeInterval:-60*60*24*30];
}
+ (NSDate *)lastYearDate:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    return [nowDate dateByAddingTimeInterval:-60*60*24*365];
}
+ (NSDate *)nextWeekDate:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    return [nowDate dateByAddingTimeInterval:60*60*24*7];
}
+ (NSDate *)nextMonthDate:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    return [nowDate dateByAddingTimeInterval:60*60*24*30];
}
+ (NSDate *)nextYearDate:(NSDate *)nowDate
{
    if (nowDate == nil)
    {
        nowDate = [NSDate date];
    }
    return [nowDate dateByAddingTimeInterval:60*60*24*365];
}

@end
