//
//  App.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-6.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface App : NSObject
{
    NSString *_appName;
    
    NSString *_membersCount;
}


@property (nonatomic, copy)NSString *appName;


@property (nonatomic, copy)NSString *membersCount;


/**
 *	从字典中解析表情App数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的App对象
 */
+ (App *)getAppFromJsonDic:(NSDictionary *)dic;



+ (NSString *)unicodeString:(NSString *)str1;


@end
