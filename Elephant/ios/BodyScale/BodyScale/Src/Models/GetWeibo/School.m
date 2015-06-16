//
//  School.m
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-6.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import "School.h"

@implementation School

@synthesize schoolName = _schoolName;

@synthesize location = _location;

@synthesize schoolId = _schoolId;

@synthesize type = _type;


- (void)dealloc
{
}


/**
 *	从字典中解析表情School数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的School对象
 */
+ (School *)getSchoolFromJsonDic:(NSDictionary *)dic
{
    School *aSchool = [[School alloc] init];
    aSchool.schoolName = [self unicodeString:[dic objectForKey:@"school_name"]];
    DLog(@"schoolName--->>>%@",aSchool.schoolName);
    aSchool.location = [self unicodeString:[dic objectForKey:@"location"]];
    aSchool.schoolId = [self unicodeString:[dic objectForKey:@"id"]];
    aSchool.type = [self unicodeString:[dic objectForKey:@"type"]];
    
    return aSchool;
}

+ (NSString *)unicodeString:(NSString *)str1
{
    NSData *data = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str2 = [[NSString alloc] initWithData:data  encoding:NSUTF8StringEncoding];
    return str2;
}

@end


