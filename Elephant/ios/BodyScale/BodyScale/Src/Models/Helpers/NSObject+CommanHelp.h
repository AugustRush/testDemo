//
//  NSObject+CommanHelp.h
//  BodyScale
//
//  Created by zhangweiwei on 14/11/29.
//  Copyright (c) 2014年 August. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef  enum
{
    Choose_Gender_Type_Male = 1,
    Choose_Gender_Type_FMale = 2
    
}Choose_Gender_Type;

@interface CommanHelp : NSObject
+ (BOOL)isMobileNumber:(NSString*)mobileNum;
+ (BOOL)isStringNULL:(NSString*)paserStr;
+ (BOOL)isValidateEmail:(NSString *)email;
+ (NSString *) md5: (NSString *)encodeStr;
+ (void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+ (UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+ (NSString*)getDocmentsDirectory;
+ (BOOL)isHasNewVersion:(NSString*)versionCode;

@end
