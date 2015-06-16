//
//  NSString+MD5.m
//  dianlv_ios2
//
//  Created by 刘 平伟 on 13-3-18.
//  Copyright (c) 2013年 VeryCD. All rights reserved.
//

#import "NSString+MD5.h"

#define kRSAPublicKey               @"MIGiMA0GCSqGSIb3DQEBAQUAA4GQADCBjAKBhACBgDj27R156+fzIQd+e2qrcCXE+BUDiFMPlRFM\
YlrMVosnl8shHeWEJO8xYo5i85NBUb6lLwwZoi/tWAkcU/QO96eglJfykqMFXPzB7iWu3ywL3YeZ\
yepiXTD7U4Bs2mAkgI5pvMIrUJKtofpZ6jTZp9ZhAmBu1XM7HYx0LfD0L4VUrQIDAQAB"

@implementation NSString (MD5_RSA)

+(NSString *)MD5StringWithString:(NSString *)string
{
    const char *concat_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02x", result[i]];
    return hash;
}

- (NSString *)URLEscaped {
	CFStringRef escaped = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"&+/?,", kCFStringEncodingUTF8);
	NSString *outP = [NSString stringWithString:(__bridge NSString *)escaped];
	CFRelease(escaped);
    return outP;
//	return [[out copy] autorelease];
}
- (NSString *)unURLEscape {
	CFStringRef unescaped = CFURLCreateStringByReplacingPercentEscapes(NULL, (CFStringRef)self, (CFStringRef)@"");
	NSString *outP = [NSString stringWithString:(__bridge NSString *)unescaped];
	CFRelease(unescaped);
    return outP;
//	return [[out copy] autorelease];
}

+(NSString *)getCurrentDateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curDateStr = [formatter stringFromDate:[NSDate date]];
    return curDateStr;
}

+(NSString *)getDateStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *curDateStr = [formatter stringFromDate:date];
    return curDateStr;
}

+(NSDate *)dateFromString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+(NSMutableArray*)splitString:(NSString*)str splitchar:(NSString*)splitchar
{
    NSMutableArray *result=[[NSMutableArray alloc]init];
    
    if ([str isEqualToString:@""]||[splitchar isEqualToString:@""]){
        return result;
    }
    
    int n=splitchar.length;
    NSString *instr=str;
    NSRange r=[str rangeOfString:splitchar options:NSCaseInsensitiveSearch];
    if (r.location==NSNotFound){
        [result addObject:str];
        return result;
    }
    else{
        while (true) {
            NSString *sub=[instr substringToIndex:r.location];
            [result addObject:sub];
            
            instr=[instr substringFromIndex:r.location+n ];
            r=[instr rangeOfString:splitchar options:NSCaseInsensitiveSearch];
            if (r.location==NSNotFound){
                [result addObject:instr];
                break;
            }
        }
    }
    
    return result;
}

+(int)indexOfString:(NSString*)str substr:(NSString*)substr
{
    int result=0;
    
    NSRange r=[str rangeOfString:substr];
    if (r.location==NSNotFound){
        result=-1;
    }
    else{
        result=r.location;
    }
    
    return result;
}

+ (NSString*)getDeviceVersion


{
    
    
    size_t
    size;
    
    
    sysctlbyname("hw.machine",
                 
                 NULL,
                 &size,
                 NULL,
                 0);
    
    
    char
    
    *machine = (char*)malloc(size);
    
    
    sysctlbyname("hw.machine",
                 machine, &size,
                 NULL,
                 0);
    
    
    NSString
    
    *platform = [NSString
                 
                 stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    
    free(machine);
    
    
    return platform;
}

- (NSString *)substringFromIndex:(NSUInteger)from length:(NSUInteger)length {
    if (from > self.length || from + length > self.length) {
        return nil;
    }
    return [self substringWithRange:NSMakeRange(from, length)];
}

@end
