//
//  NSStringAdditions.h
//  Weibo
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//




/**
 * Doxygen does not handle categories very well, so please refer to the .m file in general
 * for the documentation that is reflected on api.three20.info.
 */
@interface NSString (Additions)

+ (NSString *)generateGuid;
/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 * Determines if the string is empty or contains only whitespace.
 */
- (BOOL)isEmptyOrWhitespace;

/**
 * Parses a URL query string into a dictionary.
 */
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;

/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)versionStringCompare:(NSString *)other;



- (CGSize)heightWithFont:(UIFont*)withFont 
                    width:(float)width 
                linebreak:(NSLineBreakMode)lineBreakMode;


/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;


- (NSString *)replacedWhiteSpacsByString:(NSString *)replaceString;


- (NSString *)trim;

- (NSString *)formatJSON;

- (BOOL)eq:(NSString *)str;

/*!
 @method
 @abstract 单位转换
 @discussion NSString 类别
 @param bytes 以B为单位的data的长度
 @result nsstring  --B --kB --MB --GB
 */
+ (NSString *)bytesToAvaiUnit:(long long int) bytes;

/*!
 @method
 @abstract   获取当前时间
 @discussion NSString 类别,获取当前时间格式化后数据
 @result     NSString  @"yyyy'-'MM'-'dd HH:mm:ss"
 */
+ (NSString *)getFormatTimeString;

/*!
 @method
 @abstract   获取当前日期
 @discussion NSString 类别,获取当前时间格式化后数据
 @result     NSString  @"yyyy'-'MM'-'dd "
 */
+ (NSString *)getFormatDateString;

/*!
 @method
 @abstract   获取当前时间戳
 @discussion NSString 类别,获取当前时间戳
 @result     NSString 当前时间戳带有小数点后6位数的字符串
 */ 
+ (NSString *)getFormatTimeStampString;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

@end
