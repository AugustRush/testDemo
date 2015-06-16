//
//  NSStringExtension.m
//  MB
//
//  Created by wangwei on 13-10-24.
//  Copyright (c) 2013年 FFLtd. All rights reserved.
//

#import "NSStringExtension.h"

@implementation NSString (MD5Extensions)
- (NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}



- (NSString *)trimSpecialCharacter
{
    NSCharacterSet *charset = [NSCharacterSet characterSetWithCharactersInString:@"/／'[]%&_(（)）?？ "];
    NSString *retStr = [NSString stringWithString:[self stringByTrimmingCharactersInSet:charset]];
    return retStr;
}

+ (NSString *)GenUUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

- (int)checksum
{
    NSData *data = [NSData dataWithBytes:self.UTF8String length:[self length]];
    //prepare data
    int nword = [data length];
    UInt8 *buf = (UInt8 *)[data bytes];
    
    unsigned long sum = 0;
    
    // Main summing loop
    while(nword > 1)
    {
        sum += *(UInt16 *)buf++;
        nword = nword - 2;
    }
    
    // Add left-over byte, if any
    if (nword > 0)
        sum = sum + *((UInt8 *) buf);
    
    while (sum>>16)
        sum = (sum & 0xFFFF) + (sum >> 16);
    
    unsigned short _sum = ~((unsigned short)sum);
    return _sum;
}

- (NSInteger) convertToInt
{
    NSInteger strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}

@end