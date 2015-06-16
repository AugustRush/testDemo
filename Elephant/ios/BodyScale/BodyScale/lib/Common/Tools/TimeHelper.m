//
//  TimeHelper.m
//  FFLtd
//
//  Created by 两元鱼 on 13-3-29.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//

#import "TimeHelper.h"

static bool randomSeedflag = YES;
static bool randomSeedflaglong = YES;

@implementation TimeHelper

+ (NSString *)GetCurrentDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date = [[NSString alloc] initWithString:[dateFormatter stringFromDate:now]];
    return date;
}
+ (NSString *)GetPureCurrentDate
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMMdd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date = [[NSString alloc] initWithString:[dateFormatter stringFromDate:now]];
    return date;
}

+ (NSString *)GetCurrentTimeForFileSuffix
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd_HH-mm-ss_SSS";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date = [[NSString alloc] initWithString:[dateFormatter stringFromDate:now]];
    return date;
}

+ (NSString *)GetCurrentTimeStr
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date = [[NSString alloc] initWithString:[dateFormatter stringFromDate:now]];
    return date;
}

+ (NSDate *)GetCurrentTime
{
    NSDate *now = [NSDate date];
    return now;
}

+ (NSTimeInterval)GetCurrentGMTTime
{
    NSDate *now = [NSDate date];
    NSTimeInterval nowTime = [now timeIntervalSince1970];
    return nowTime;
}

+ (NSTimeInterval)GetCurrentMillisecondGMTTime
{
    NSTimeInterval nowTime = [self GetCurrentGMTTime] * 1000;
    NSTimeInterval _nowTime = nowTime/1000;
    return _nowTime;
}

+ (NSString *)GetCurrentTimeStringWithFormat:(NSString *)format
{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date = [[NSString alloc] initWithString:[dateFormatter stringFromDate:now]];
    return date;
}

+ (NSString*)setMonth
{
    NSDateFormatter* nowTime = [[NSDateFormatter alloc]init];
    [nowTime setDateFormat:@"y-MM"];
    NSString* month = [NSString stringWithFormat:@"%@",[nowTime stringFromDate:[NSDate date]]];
    return month;
}

+ (NSString*)setLastMonth:(NSString *)monthStr
{
    NSString *tempY = [monthStr substringToIndex:4];
    NSString *tempM = [monthStr substringFromIndex:5];
    
    int tmpY = [tempY intValue];
    int tmpM = [tempM intValue];
    
    if (1 == tmpM) {
        tmpY--;
        tmpM = 12;
    }
    else {
        tmpM--;
    }
   NSString* lastMonth = [NSString stringWithFormat:@"%d-%02d",tmpY,tmpM];
   return lastMonth;
}

+ (NSDate *)GetDateWithTimeString:(NSString *)time
{
    if (time == nil) 
    {
        return nil;
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    return date;
}

+ (NSDate *)GetDateWithTimeString:(NSString *)time format:(NSString *)format
{
    if (time == nil){
        return nil;
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:time];
    return date;
}
+ (NSString *)getDateStringTimeInterval:(unsigned long long)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

+ (NSDate *)GetDateWithGMT:(unsigned long long)timeInterval
{
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

+ (NSString *)GetStringWithDate:(NSDate *)time
{
    if (time == nil) 
    {
        return @"";
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *date = [formatter stringFromDate:time];
    return date;
}

+ (NSString *)GetStringWithDate:(NSDate *)time format:(NSString *)format
{
    if (time == nil)
    {
        return @"";
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *date = [formatter stringFromDate:time];
    return date;
}

+ (NSString *)GetLocalStringWithDate:(NSDate *)time format:(NSString *)format
{

    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [NSLocale currentLocale];

    [fmt setDateStyle:NSDateFormatterShortStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
//    if (format) {
//        fmt.dateFormat = format;
//    }else{
//        fmt.dateFormat = @"yyyy-MM-dd HH:mm a";
//    }
    NSString* dateString = [fmt stringFromDate:time];
    return dateString;
}

+ (NSString *)GetStringHourWithDate:(NSDate *)time
{
    if (time == nil) 
    {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    NSString *date = [formatter stringFromDate:time];
    NSString *ret = @"  ";
    if (date != nil) 
    {
        ret = [[NSString alloc] initWithString:date];
    }
    return ret;
}

+ (NSDate *)ConvertDatetoLocal:(NSDate *)date
{
    if (date == nil)
    {
        return nil;
    }
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval]; 
    return localeDate;
}
+ (NSDate *)ConvertGMTTimeToLocal:(NSTimeInterval)timeinterval
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDate *date = [TimeHelper GetDateWithGMT:timeinterval];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString *)getFormateTimeWithDate:(NSDate *)timeDate
{
    if (timeDate == nil)
    {
        return @" ";
    }
    NSDate *currentlocaleDate           = [TimeHelper GetCurrentTime];  // 当前时间
    
    long long  todayInterval            = [currentlocaleDate timeIntervalSince1970];
    currentlocaleDate                   = [currentlocaleDate dateByAddingTimeInterval:-(todayInterval%86400)];
    todayInterval                       = [currentlocaleDate timeIntervalSince1970];
    NSDateFormatter *dateFormatter      = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *dateStr                   = [dateFormatter stringFromDate:timeDate];
    
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *date                        = [dateFormatter dateFromString:dateStr]; //要转换的时间
    long long  dateInterval             = [date timeIntervalSince1970];
    long long intervalDay                     = (long long)(todayInterval - (dateInterval-dateInterval%86400))/86400;
    
    if (intervalDay < 1 && intervalDay >= 0) //今天
    {
        todayInterval       = [[TimeHelper GetCurrentTime] timeIntervalSince1970];
        int todayHour       = (long long)todayInterval%86400/3600;
        int dateHour        = (long long)dateInterval%86400/3600;
        int intervalHour    = todayHour - dateHour;
        long long minInterval     = (todayInterval - dateInterval)/60;
        if (intervalHour == 0 || (intervalHour == 1 && minInterval < 60))  // 1小时之内
        {
            NSString *timeStr = nil;
            if (minInterval <= 0)
            {
                return NSLocalizedString(@"Now", nil);
            }
            else 
            {
                timeStr   = [NSString stringWithFormat:@"%lld",minInterval];
            }
            if (minInterval > 1) {
                timeStr = [NSString stringWithFormat:@"%@ %@",timeStr,NSLocalizedString(@"mins ago", nil)];
            }else{
                timeStr = [NSString stringWithFormat:@"%@ %@",timeStr,NSLocalizedString(@"min ago", nil)];
            }
            
            return NSLocalizedString(timeStr, nil);
        }
        return [[self class] GetStringHourWithDate:timeDate];
    }
    if(intervalDay < 2)// 昨天
    {
        return NSLocalizedString(@"Yesterday", nil);
    }
    
    long long weekInterval          = (todayInterval - dateInterval)/86400/7;
    if (weekInterval == 0)//一周之内
    {
        [dateFormatter setDateFormat:@"EEE, MMM d, yy"];
        NSString *str   = [dateFormatter stringFromDate:date];
        NSArray *array  = [str componentsSeparatedByString:@","];
        str = [array objectAtIndex:0];
        return NSLocalizedString(str, nil);
    }
    return [dateStr substringToIndex:10];
}
+ (NSString *)getTimeStrWithDate:(NSDate *)timeDate
{
    if (time == nil)
    {
        return @"";
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *date = [[formatter stringFromDate:timeDate] copy];
    return date;
}

+ (uint32_t)GenerateRandomNum
{
    if (randomSeedflag) {
        srandom((unsigned int)time(NULL));
        randomSeedflag = NO;
    }
    uint32_t ret = (uint32_t)random();
    return ret;
    
}

+ (long)GenerateRandomNumLong
{
    if (randomSeedflaglong) {
        srandom((unsigned int)time(NULL));
        randomSeedflaglong = NO;
    }
    long ret = random();
    return ret;
}

+ (NSString *)amStringWithStr:(NSString *)dateStr
{
    if (dateStr == nil){
        return @"";
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    if ([dateStr length] > 11) {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else{
        [formatter setDateFormat:@"MM-dd HH:mm"];
    }
    
    NSDate *date = [formatter dateFromString:dateStr];
    [formatter setDateFormat:@"MM-dd h:mm a"];
    NSString *str = [formatter stringFromDate:date];
    if (str) {
        return str;
    }
    return dateStr;
}
@end
