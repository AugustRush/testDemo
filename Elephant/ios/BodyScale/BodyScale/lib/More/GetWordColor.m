//
//  GetWordColor.m
//  FFLtd
//
//  Created by lyywhg on 14-7-24.
//  Copyright (c) 2014年 FFLtd. All rights reserved.
//

#import "GetWordColor.h"

@implementation GetWordColor


+(UIColor*)colorWithHexString:(NSString *)stringToConvert  
{  
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];  
	
    // String should be 6 or 8 characters  
    if ([cString length] < 6) return nil;  
	
    // strip 0X if it appears  
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];  
	
    if ([cString length] != 6 &&[cString length] != 8) return nil;  
	
    // Separate into r, g, b substrings  
    NSRange range;  
    range.location = 0;  
    range.length = 2;  
    NSString *rString = [cString substringWithRange:range];  
	
    range.location = 2;  
    NSString *gString = [cString substringWithRange:range];  
	
    range.location = 4;  
    NSString *bString = [cString substringWithRange:range];  
	
    // Scan values  
    unsigned int r, g, b,a=255.0;  
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  
    [[NSScanner scannerWithString:gString] scanHexInt:&g];  
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
	if ([cString length] == 8)  
	{
		range.location = 6; 
		NSString *aString = [cString substringWithRange:range]; 
		[[NSScanner scannerWithString:aString] scanHexInt:&a]; 
	}
	
    return [UIColor colorWithRed:((float) r / 255.0f)  
                           green:((float) g / 255.0f)  
                            blue:((float) b / 255.0f)  
                           alpha:((float) a / 255.0f)];  
} 

@end
