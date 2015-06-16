//
//  NSString+MD5.h
//  dianlv_ios2
//
//  Created by 刘 平伟 on 13-3-18.
//  Copyright (c) 2013年 VeryCD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonCrypto/CommonDigest.h"
#import <sys/sysctl.h>

@interface NSString (MD5)

- (NSString *)URLEscaped;
- (NSString *)unURLEscape;
- (CGFloat)textHeightAtMaxSize:(CGSize)maxSize font:(UIFont *)font;
- (NSString *)substringFromIndex:(NSUInteger)from length:(NSUInteger)length;

+ (NSString*)getDeviceVersion;
+ (NSString *)getCurrentDateStr;
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSString *)MD5StringWithString:(NSString *)string;
+ (NSString *)getDateStringFromDate:(NSDate *)date;
+ (NSMutableArray*)splitString:(NSString*)str splitchar:(NSString*)splitchar;
+ (int)indexOfString:(NSString*)str substr:(NSString*)substr;

@end
