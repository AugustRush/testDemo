//
//  School.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-6.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface School : NSObject
{
    NSString *_schoolName;
    
    NSString *_location;
    
    NSString *_schoolId;
    
    NSString *_type;
    
}


@property (nonatomic, copy)NSString *schoolName;


@property (nonatomic, copy)NSString *location;


@property (nonatomic, copy)NSString *schoolId;


@property (nonatomic, copy)NSString *type;

/**
 *	从字典中解析表情School数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的School对象
 */
+ (School *)getSchoolFromJsonDic:(NSDictionary *)dic;


+ (NSString *)unicodeString:(NSString *)str1;


@end
