//
//  Emotion.h
//  SinaWeibo
//
//  Created by Stephy_xue on 13-10-4.
//  Copyright (c) 2013年 Stephy_xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Emotion : NSObject
{
    NSString    *_category;
    
    BOOL        _common;
    
    BOOL        _hot;
    
    NSString    *_icon;
    
    NSString    *_phrase;
    
    NSString    *_picId;
    
    NSString    *_type;
    
    NSString    *_url;
    
    NSString    *_value;
}

@property (nonatomic, copy)NSString *category;

@property (nonatomic, assign)BOOL common;

@property (nonatomic, assign)BOOL hot;

@property (nonatomic, copy)NSString *icon;

@property (nonatomic, copy)NSString *phrase;

@property (nonatomic, copy)NSString *picId;

@property (nonatomic, copy)NSString *type;

@property (nonatomic, copy)NSString *url;

@property (nonatomic, copy)NSString *value;



/**
 *	从字典中解析表情Emotion数据
 *
 *	@param	dic	json中的字典
 *
 *	@return	组装之后的Emotion对象
 */
+ (Emotion *)getEmotionFromJsonDic:(NSDictionary *)dic;


@end
